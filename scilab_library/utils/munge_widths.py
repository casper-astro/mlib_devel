"""Port widths of casper_dsp's FlowControl/munge.sv, shared by
dsp_blocks/munge.py and the munge dialog (block_guis/casper_dsp/munge)."""


def munge_widths(divisions, div_size, order):
    """(din width, dout width) of munge.sv: din is the sum of the division
    sizes (a single size applies to every division), dout the sum of the
    sizes of the divisions order names (dout = din with one division).
    Raises ValueError on the conditions munge.sv stops on with $fatal."""
    if divisions < 1:
        raise ValueError('divisions = %d must be at least 1' % divisions)
    if len(div_size) not in (1, divisions):
        raise ValueError('div_size has %d elements; it needs 1 or divisions = %d'
                         % (len(div_size), divisions))
    if any(s != int(s) or s < 0 for s in div_size):
        raise ValueError('div_size %s: every size must be an integer >= 0' % div_size)
    sizes = [int(s) for s in div_size] * divisions if len(div_size) == 1 else [int(s) for s in div_size]
    din = sum(sizes)
    if din < 1:
        raise ValueError('the division sizes must not all be 0')
    if divisions == 1:
        return din, din
    if any(o != int(o) or not 0 <= o <= divisions - 1 for o in order):
        raise ValueError('order %s: every entry must be an integer in 0..%d' % (order, divisions - 1))
    dout = sum(sizes[int(o)] for o in order)
    if dout < 1:
        raise ValueError('order %s names only divisions of size 0' % order)
    return din, dout
