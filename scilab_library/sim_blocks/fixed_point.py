"""
Fixed-point helpers for the simulation source blocks (sine, noise): turn
real values into bitwidth-bit words and write them as the .dat file the
testbench reads with $readmemb (one binary word per line).
"""
import numpy as np

ARITH_TYPES = ('signed', 'unsigned')
OVERFLOW_MODES = ('saturate', 'error')


def word_range(bitwidth, arith_type):
    """(lowest, highest) integer word of the format."""
    if arith_type == 'signed':
        return -2**(bitwidth - 1), 2**(bitwidth - 1) - 1
    return 0, 2**bitwidth - 1


def quantize(values, bitwidth, bin_pt, arith_type, overflow='error', what='value'):
    """Round values * 2^bin_pt to integer words of the given format.

    overflow 'saturate' clips the words to the format's range, 'error'
    raises a ValueError naming `what` when a word does not fit.
    Returns a list of Python ints (no 64-bit limit on the width)."""
    if arith_type not in ARITH_TYPES:
        raise ValueError('arith_type must be one of %s, got %r' % (ARITH_TYPES, arith_type))
    if overflow not in OVERFLOW_MODES:
        raise ValueError('overflow must be one of %s, got %r' % (OVERFLOW_MODES, overflow))
    lo, hi = word_range(bitwidth, arith_type)
    words = [int(round(float(v) * 2**bin_pt)) for v in values]
    if overflow == 'saturate':
        return [min(max(w, lo), hi) for w in words]
    if words and (min(words) < lo or max(words) > hi):
        raise ValueError('%s does not fit in %d %s bits with binary point %d (words %d .. %d, range %d .. %d)'
                         % (what, bitwidth, arith_type, bin_pt, min(words), max(words), lo, hi))
    return words


def write_dat(filename, words, bitwidth):
    """Write the words, two's complement when negative, one per line."""
    mask = 2**bitwidth - 1
    with open(filename, 'w') as f:
        for w in words:
            f.write(format(w & mask, '0%db' % bitwidth) + '\n')
