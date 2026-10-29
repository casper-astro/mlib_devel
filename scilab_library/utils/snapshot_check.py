"""Parameter checks of the snapshot and bitfield_snapshot (bitsnap) blocks,
shared by dsp_blocks/{snapshot,bitfield_snapshot}.py and their mask dialogs.

The rules are casper_library's (bitfield_maskcheck.m, snapshot_init.m) plus
the limits of casper_dsp's Scopes/snapshot.sv, which implements BRAM
storage with offset, circap, value, ext_arm and ext_circ off and, for the
bitsnap, one io field; the other settings are refused here instead of being
dropped.

Values may be the strings the dialog / Xcos store or the converted values of
jasper.dsp ('on' -> True, '12' -> 12).
"""
import re
try:
    # as utils.snapshot_check (the dsp blocks)
    from .matlab_vec import parse_vector
except ImportError:
    # as snapshot_check, with scilab_library/utils on sys.path (the dialogs)
    from matlab_vec import parse_vector

DATA_WIDTHS = [8, 16, 32, 64, 128]
UNSUPPORTED = [('offset', 'Start delay support'), ('circap', 'Circular capture support'),
               ('value', 'Extra value capture support'), ('ext_arm', 'External arm support'),
               ('ext_circ', 'External circular capture support')]


def onoff(val):
    """'on' / 'off' of a checkbox value."""
    if val is True or val == 'on':
        return 'on'
    if val is False or val == 'off':
        return 'off'
    raise ValueError('%r is not on / off' % (val,))


def text(val):
    if val is True or val is False:
        return onoff(val)
    return str(val).strip()


def parse_names(val):
    """Names of a [msb...lsb] name list, e.g. '[a b]' -> ['a', 'b']
    (bitfield_maskcheck.m's str_to_cell_list)."""
    s = text(val).replace('[', '').replace(']', '').replace(',', ' ')
    return s.split()


def _int(val, label, errors, lo=None, hi=None):
    try:
        f = float(text(val))
    except ValueError:
        errors.append('%s must be an integer, not %r.' % (label, text(val)))
        return None
    if f != int(f):
        errors.append('%s must be an integer, not %r.' % (label, text(val)))
        return None
    v = int(f)
    if lo is not None and v < lo or hi is not None and v > hi:
        rng = ('from %d to %d' % (lo, hi)) if hi is not None else ('>= %d' % lo)
        errors.append('%s must be %s, not %d.' % (label, rng, v))
        return None
    return v


def _snapshot_core(p, prefix, errors):
    """storage / nsamples / data_width / unsupported options of a snapshot
    (keys <prefix>storage, ...). Returns (nsamples, data_width)."""
    if text(p[prefix + 'storage']) != 'bram':
        errors.append('Storage medium %r is not supported: only bram (DRAM storage is not '
                      'implemented in casper_dsp snapshot.sv).' % text(p[prefix + 'storage']))
    for key, label in UNSUPPORTED:
        try:
            if onoff(p[prefix + key]) == 'on':
                errors.append('"%s" is not supported: turn it off (not implemented in casper_dsp '
                              'snapshot.sv).' % label)
        except ValueError:
            errors.append('"%s" must be on or off.' % label)
    dw = _int(p[prefix + 'data_width'], 'Data width', errors)
    if dw is not None and dw not in DATA_WIDTHS:
        errors.append('Data width must be one of %s, not %d.' % (DATA_WIDTHS, dw))
        dw = None
    ns = _int(p[prefix + 'nsamples'], 'Number of Samples (2^?)', errors, lo=1)
    if ns is not None and dw is not None:
        linc = {8: 0, 16: 1, 32: 2, 64: 3, 128: 4}[dw]
        if ns + linc > 30:
            errors.append('Number of Samples (2^?) %d is too large for data width %d: the byte count '
                          'must fit the 32-bit status register (nsamples + log2(data_width/8) <= 30).'
                          % (ns, dw))
            ns = None
    return ns, dw


def check_snapshot(p):
    """Errors and derived values of a snapshot block:
    (errors, {'nsamples', 'data_width', 'in_width'})."""
    errors = []
    ns, dw = _snapshot_core(p, '', errors)
    iw = _int(p['in_width'], 'Input (din) bit width', errors, lo=1)
    return errors, {'nsamples': ns, 'data_width': dw, 'in_width': iw}


def check_bitsnap(p):
    """Errors and derived values of a bitfield_snapshot block:
    (errors, {'io_name', 'io_width', 'nsamples', 'data_width', 'delay'})."""
    errors = []
    names = parse_names(p['io_names'])
    name = None
    if len(names) != 1:
        errors.append('Names: exactly one io field is supported (casper_dsp bitfield_snapshot.sv), '
                      'not %d (%s).' % (len(names), text(p['io_names'])))
    elif not re.fullmatch(r'[A-Za-z]\w*', names[0]):
        errors.append('Names: %r is not a valid name (letters, digits and _, starting with a letter).'
                      % names[0])
    else:
        name = names[0]
    vals = {}
    for key, label in (('io_widths', 'Bitwidths'), ('io_bps', 'Binary pts'), ('io_types', 'Data types')):
        try:
            v = parse_vector(text(p[key]))
        except ValueError as e:
            errors.append('%s: %s.' % (label, e))
            continue
        if len(v) != 1:
            errors.append('%s: one value is supported (one io field), not %d.' % (label, len(v)))
        elif v[0] != int(v[0]):
            errors.append('%s must be an integer, not %s.' % (label, v[0]))
        else:
            vals[key] = int(v[0])
    if 'io_types' in vals and vals['io_types'] not in (0, 1, 2):
        errors.append('Data types: type cannot be %d, must be 0, 1 or 2.' % vals['io_types'])
    width = vals.get('io_widths')
    if width is not None and width < 1:
        errors.append('Bitwidths must be >= 1, not %d.' % width)
        width = None
    if width is not None and 'io_bps' in vals and not 0 <= vals['io_bps'] <= width:
        errors.append('Binary pts must be from 0 to the bit width (%d), not %d.' % (width, vals['io_bps']))
    ns, dw = _snapshot_core(p, 'snap_', errors)
    if width is not None and dw is not None and width > dw:
        errors.append('Total width must be %d (the data width) or less, set to %d.' % (dw, width))
    delay = _int(p['snap_delay'], 'Pre-snapshot delay', errors, lo=0)
    return errors, {'io_name': name, 'io_width': width, 'nsamples': ns, 'data_width': dw, 'delay': delay}
