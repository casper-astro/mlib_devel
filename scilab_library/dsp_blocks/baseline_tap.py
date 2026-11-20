from .auto_tap import auto_tap


class baseline_tap(auto_tap):
    """casper_library baseline_tap (Correlator) ->
    casper_dsp/rtl/Correlator/baseline_tap.sv.

    Same structure and conventions as auto_tap (see auto_tap.py): the RTL
    ports are exactly the Simulink/Xcos ports, so the module is instantiated
    directly, no wrapper. Every mask param goes to the RTL param of the same
    name upper-cased, as the plain integer the mask holds. Not passed:
    N_BITS_OUT (derived in the RTL) and PLATFORM (RTL default "GENERIC").

    Port names follow the Simulink block: note the sync input is named
    'sync1' (system_2.xml Inport 7), not 'sync_in'.
    """
    RTL_MODULE = 'baseline_tap'

    PARAMS = [
        ('n_ants', 'N_ANTS'),
        ('ant_sep', 'ANT_SEP'),
        ('n_bits', 'N_BITS'),
        ('acc_len', 'ACC_LEN'),
        ('add_latency', 'ADD_LATENCY'),
        ('mult_latency', 'MULT_LATENCY'),
        ('bram_latency', 'BRAM_LATENCY'),
        ('mult_type', 'MULT_TYPE'),
        ('use_bram_delay', 'USE_BRAM_DELAY'),
    ]

    INPUTS = [('a_del', 'a'), ('a_ndel', 'a'), ('a_end', 'a'), ('acc_in', 'acc'),
              ('valid_in', '1'), ('rst', '1'), ('sync1', '1')]
    OUTPUTS = [('a_del_out', 'a'), ('a_ndel_out', 'a'), ('a_end_out', 'a'), ('acc_out', 'acc'),
               ('valid_out', '1'), ('rst_out', '1'), ('sync_out', '1')]

    # auto_tap's files minus auto_tap.sv and sync_delay.sv (used by auto_tap only)
    RTL_FILES = [f for f in auto_tap.RTL_FILES
                 if not f.endswith(('/auto_tap.sv', '/sync_delay.sv'))] + [
        'rtl/Correlator/baseline_tap.sv',
    ]
