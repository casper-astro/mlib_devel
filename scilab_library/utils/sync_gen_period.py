"""sync_gen's sync period (casper_library sync_gen_init.m), with the checks of
casper_dsp's Misc/sync_gen.sv. Shared by dsp_blocks/sync_gen.py and the
sync_gen dialog."""
from math import gcd


def sync_gen_period(sim_acc_len, fft_size, fft_simult_inputs, pfb_fir_taps, reorder_vec, scale):
    """Return (period, constant): the sync_out period with sync_period_sel = 0
    and the constant sync_gen_init.m writes (period - 2). Raises ValueError
    naming the parameter when the values are not valid."""
    for key, val in (('sim_acc_len', sim_acc_len), ('fft_size', fft_size),
                     ('fft_simult_inputs', fft_simult_inputs), ('scale', scale)):
        if int(val) != val or val < 1:
            raise ValueError('%s = %s must be an integer >= 1' % (key, val))
    if int(pfb_fir_taps) != pfb_fir_taps or pfb_fir_taps < 1:
        raise ValueError('pfb_fir_taps = %s must be an integer >= 1' % pfb_fir_taps)
    if len(reorder_vec) < 1:
        raise ValueError('reorder_vec must have at least one element')
    lcm = 1
    for i, v in enumerate(reorder_vec):
        if int(v) != v or v < 1:
            raise ValueError('reorder_vec element %d = %s must be an integer >= 1' % (i, v))
        lcm = lcm // gcd(lcm, int(v)) * int(v)
    num = int(scale) * int(sim_acc_len) * int(pfb_fir_taps) * int(fft_size) * lcm
    if num % int(fft_simult_inputs):
        raise ValueError('the sync period %d / %d is not an integer' % (num, int(fft_simult_inputs)))
    period = num // int(fft_simult_inputs)
    const = period - 2
    if not -2 ** 31 <= const <= 2 ** 31 - 1:
        raise ValueError('the sync period - 2 = %d does not fit the Signed 32-bit constant' % const)
    return period, const
