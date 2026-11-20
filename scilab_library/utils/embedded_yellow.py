"""Yellow blocks that live inside a dsp block.

In Simulink some casper_library blocks contain yellow blocks: sync_gen has
three software registers, a snapshot has its ctrl / status registers and a
shared BRAM. The Scilab block only shows the Simulink ports, so these yellow
blocks are added to jasper.json here, before jasper.per / jasper.dsp are
written:

* A dsp block class may define a classmethod
  ``embedded_yellow_blocks(blk)``, where ``blk`` is the block's jasper.json
  entry (all values are strings). It returns a dict with
    'yellow_blocks': [{'block': <xps block config, e.g. from
                                  xps_frontend.sw_reg.sw_reg.config()>,
                       'ports': [(dsp_port, xps_port, width, dir), ...]}]
        dsp_port is the port name the dsp block uses in modify_top
        (the signal is <fullname>_<dsp_port>), xps_port the yellow block's
        port label (as for a link drawn in Xcos), dir is 'in' (yellow block
        -> dsp block) or 'out' (dsp block -> yellow block);
    'design_info': [{'name': ..., 'tag': 'casper:...', <params>}]
        extra design_info.tab entries, like the casper:snapshot ones the
        Simulink flow writes for casperfpga.
  The yellow block's name should be the Simulink path below the model with
  '/' replaced by '_' (e.g. sync_gen_sync), so that the register names
  match a Simulink build.

* A yellow block may have a Scilab-side class xps_frontend/<tag>.py with a
  classmethod ``dsp_interface(blk)``, for yellow blocks whose Simulink
  version also holds Simulink logic that ends up in the DSP IP (e.g. the
  shared_bram's address / word order logic). It returns
    {'tag': 'dsp:<interface block>', 'params': {...},
     'ports': [(port, dir, width), ...]}
  with dir 'in' / 'out' seen from the yellow block. That dsp block, named
  <yellow block>_if, is put between the yellow block and the dsp blocks
  linked to it: its ports are <port> on the dsp side and yb_<port> on the
  yellow block side.

Everything added here is marked with 'embedded_in', so expanding a
jasper.json twice gives the same result.
"""
import importlib

MARK = 'embedded_in'


def _xps_port_name(projname, blkname, port):
    return '%s_%s_%s' % (projname, blkname, port)


def _link(src_blk, src_port, src_id, dst_blk, dst_port, dst_id, width, link_type, owner):
    return {'src_blk_name': src_blk, 'src_port_name': src_port, 'src_port_width': width,
            'src_port_id': src_id, 'dst_blk_name': dst_blk, 'dst_port_name': dst_port,
            'dst_port_width': width, 'dst_port_id': dst_id, 'link_type': link_type, MARK: owner}


def _dsp_class(tag):
    try:
        mod = importlib.import_module('dsp_blocks.' + tag[4:])
    except ImportError:
        return None
    return getattr(mod, tag[4:], None)


def _strip(model_info):
    """Undo an earlier expansion."""
    for key in ('xps_blocks', 'dsp_blocks'):
        model_info[key] = [b for b in model_info[key] if MARK not in b]
    links = []
    for link in model_info['link_info']:
        if MARK in link:
            # a rewritten link: put the original back, unless that was
            # itself added (a link to an embedded yellow block)
            if 'orig' in link and MARK not in link['orig']:
                links.append(link['orig'])
            continue
        links.append(link)
    model_info['link_info'] = links
    model_info.pop('design_info', None)


def _expand_dsp_blocks(model_info, projname):
    design_info = []
    next_id = {}
    for blk in list(model_info['dsp_blocks']):
        cls = _dsp_class(blk['tag'])
        if cls is None or not hasattr(cls, 'embedded_yellow_blocks'):
            continue
        res = cls.embedded_yellow_blocks(dict(blk))
        for yb in res.get('yellow_blocks', []):
            cfg = dict(yb['block'])
            cfg['fullpath'] = projname + '/' + cfg['name']
            cfg[MARK] = blk['name']
            model_info['xps_blocks'].append(cfg)
            in_id = out_id = 0
            for dsp_port, xps_port, width, direction in yb['ports']:
                # port ids of the hidden ports start after the block's own
                n = next_id.setdefault(blk['name'], 1000) + 1
                next_id[blk['name']] = n
                dsp_sig = _xps_port_name(projname, blk['name'], dsp_port)
                xps_sig = _xps_port_name(projname, cfg['name'], xps_port)
                if direction == 'in':
                    out_id += 1
                    model_info['link_info'].append(_link(cfg['name'], xps_sig, out_id, blk['name'], dsp_sig, n,
                                                         int(width), 'xps_dsp', blk['name']))
                else:
                    in_id += 1
                    model_info['link_info'].append(_link(blk['name'], dsp_sig, n, cfg['name'], xps_sig, in_id,
                                                         int(width), 'dsp_xps', blk['name']))
        for d in res.get('design_info', []):
            d = dict(d)
            d[MARK] = blk['name']
            design_info.append(d)
    return design_info


def _xps_class(tag):
    try:
        mod = importlib.import_module('xps_frontend.' + tag[4:])
    except ImportError:
        return None
    return getattr(mod, tag[4:], None)


def _insert_dsp_interfaces(model_info, projname):
    """Put each yellow block's dsp-side interface block between it and the
    dsp blocks linked to it. A dsp block -> yellow block port link becomes
    dsp block -> interface <port> (dsp_dsp) plus interface yb_<port> ->
    yellow block <port> (dsp_xps); the other direction likewise. A port
    linked to another yellow block (xps_xps) keeps its links and gets no
    interface port."""
    for cfg in list(model_info['xps_blocks']):
        cls = _xps_class(cfg['tag'])
        if cls is None or not hasattr(cls, 'dsp_interface'):
            continue
        spec = cls.dsp_interface(dict(cfg))
        yname = cfg['name']
        ifname = yname + '_if'
        prefix = '%s_%s_' % (projname, yname)
        ports = {p: (d, w, i + 1) for i, (p, d, w) in enumerate(spec['ports'])}
        # ports that also connect to yellow blocks stay as they are
        for link in model_info['link_info']:
            if link['link_type'] == 'xps_xps':
                for blk, sig in ((link['src_blk_name'], link['src_port_name']),
                                 (link['dst_blk_name'], link['dst_port_name'])):
                    if blk == yname and sig.startswith(prefix):
                        ports.pop(sig[len(prefix):], None)
        new_links = []
        used = False
        for link in model_info['link_info']:
            if link['link_type'] == 'dsp_xps' and link['dst_blk_name'] == yname:
                port = link['dst_port_name'][len(prefix):]
                if port in ports and ports[port][0] == 'in':
                    nl = dict(link, dst_blk_name=ifname, dst_port_name=_xps_port_name(projname, ifname, port),
                              dst_port_id=ports[port][2], link_type='dsp_dsp')
                    nl[MARK] = yname
                    nl['orig'] = link
                    new_links.append(nl)
                    used = True
                    continue
            if link['link_type'] == 'xps_dsp' and link['src_blk_name'] == yname:
                port = link['src_port_name'][len(prefix):]
                if port in ports and ports[port][0] == 'out':
                    nl = dict(link, src_blk_name=ifname, src_port_name=_xps_port_name(projname, ifname, port),
                              src_port_id=ports[port][2], link_type='dsp_dsp')
                    nl[MARK] = yname
                    nl['orig'] = link
                    new_links.append(nl)
                    used = True
                    continue
            new_links.append(link)
        if not used:
            continue
        # the interface connects to every remaining port of the yellow block
        for port, (direction, width, pid) in ports.items():
            ysig = _xps_port_name(projname, yname, port)
            isig = _xps_port_name(projname, ifname, 'yb_' + port)
            if direction == 'in':
                new_links.append(_link(ifname, isig, pid, yname, ysig, pid, int(width), 'dsp_xps', yname))
            else:
                new_links.append(_link(yname, ysig, pid, ifname, isig, pid, int(width), 'xps_dsp', yname))
        model_info['link_info'] = new_links
        blk = {'name': ifname, 'fullpath': projname + '/' + ifname, 'tag': spec['tag']}
        blk.update(spec.get('params', {}))
        blk[MARK] = yname
        model_info['dsp_blocks'].append(blk)


def expand(model_info, projname):
    """Add the embedded yellow blocks and the yellow blocks' dsp interfaces to a
    jasper.json dict (in place). Returns the dict."""
    _strip(model_info)
    design_info = _expand_dsp_blocks(model_info, projname)
    _insert_dsp_interfaces(model_info, projname)
    if design_info:
        model_info['design_info'] = design_info
    return model_info
