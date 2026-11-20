from .xeng_descramble import xeng_descramble


class xeng_descramble_4ant(xeng_descramble):
    """casper_library Correlator/xeng_descramble_4ant -> casper_dsp
    rtl/Correlator/xeng_descramble_4ant.sv (thin wrapper of xeng_descramble
    with NUM_ANTS = 4 and RAM_LATENCY = 2 fixed inside the RTL).

    Mask parameters n_bits / acc_len / demux_factor -> N_BITS / ACC_LEN /
    DEMUX_FACTOR; PLATFORM left at "GENERIC". Ports identical to
    xeng_descramble, instantiated directly (no wrapper).
    """
    RTL_MODULE = 'xeng_descramble_4ant'
    RTL_FILES = xeng_descramble.RTL_FILES + ['rtl/Correlator/xeng_descramble_4ant.sv']
    HAS_NUM_ANTS = False
