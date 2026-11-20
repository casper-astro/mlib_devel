from xps_frontend.template import xps_template


class sw_reg(object):
    # Scilab-frontend description of the xps:sw_reg yellow block
    # (jasper_library/yellow_blocks/sw_reg.py).

    @classmethod
    def config(cls, name, io_dir, bitwidth=32, **params):
        """jasper.json entry of a software register that a dsp block
        contains (see utils/embedded_yellow.py): the casper_xps swreg
        defaults, with the given values. io_dir is 'From Processor' or
        'To Processor'."""
        cfg = xps_template('swreg')
        cfg.update(name=name, io_dir=io_dir, bitwidths=str(bitwidth))
        cfg.update({k: str(v) for k, v in params.items()})
        return cfg
