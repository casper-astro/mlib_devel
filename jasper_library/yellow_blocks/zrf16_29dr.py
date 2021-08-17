from .yellow_block import YellowBlock
from .zrf16 import zrf16

class zrf16_29dr(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        return zrf16(blk, plat, hdl_root)


