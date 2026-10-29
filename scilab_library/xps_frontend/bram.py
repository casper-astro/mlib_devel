from xps_frontend.template import xps_template


class bram(object):
    # Scilab-frontend description of the xps:bram yellow block (sbram,
    # jasper_library/yellow_blocks/bram.py).
    # Simulink's shared_bram yellow block also holds Simulink logic between
    # the user ports and the memory, which the Simulink flow compiles into the
    # DSP IP (xps_library/shared_bram_mask.m): calc_add (the address) and
    # munge_in / munge_out (the 32-bit word order of data_in / data_out).
    # jasper's bram yellow block is only the memory, so this logic is a dsp
    # block (dsp:shared_bram_if) that the frontend puts between the bram and
    # the dsp blocks connected to it (see utils/embedded_yellow.py).

    @classmethod
    def config(cls, name, addr_width, data_width, **params):
        """jasper.json entry of a shared BRAM that a dsp block contains (see
        utils/embedded_yellow.py): the casper_xps sbram defaults, with the
        given values."""
        cfg = xps_template('sbram')
        cfg.update(name=name, addr_width=str(addr_width), data_width=str(data_width),
                   init_vals='[0:2^%d-1]' % int(addr_width))
        cfg.update({k: str(v) for k, v in params.items()})
        return cfg

    @classmethod
    def dsp_interface(cls, blk):
        aw = int(float(blk['addr_width']))
        dw = int(float(blk['data_width']))
        return {
            'tag': 'dsp:shared_bram_if',
            'params': {'addr_width': str(aw), 'data_width': str(dw)},
            # (port, direction seen from the yellow block, width)
            'ports': [('addr', 'in', aw), ('data_in', 'in', dw), ('we', 'in', 1),
                      ('data_out', 'out', dw)],
        }
