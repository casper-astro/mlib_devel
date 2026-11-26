"""
Load casper_simulation.json (written by CasperRawData.WriteSimData) for the
scope GUI. Independent of Qt, so it can be tested without a display.

The json holds {'simdata': [{'name', 'type': {'width', ...}, 'data':
[[t_ps, value], ...]}, ...]}, with one value every `tick` ps (half a clock
period) and value strings as written in the VCD: 'b0101' for a bus, '0' or
'1' for a 1-bit signal, with 'x' / 'z' for unknown bits. A scope block's
signal also has 'format': {'arith_type': 'unsigned' | 'signed', 'bin_pt'},
the number format set on the block (unsigned, binary point 0 without it).

Each signal is sampled once per clock cycle, on the rising edges of
user_clk: the value taken is the one just before the edge, i.e. what a
register clocked by that edge captures. The scope shows the samples by
their index (0, 1, 2, ...), independent of the clock rate.
"""
import json
import numpy as np

CLOCK_NAME = 'user_clk'


def parse_value(text):
    """VCD value string -> int, or None when it holds x / z bits."""
    bits = text[1:] if text[:1] in ('b', 'B') else text
    try:
        return int(bits, 2)
    except ValueError:
        return None


ARITH_TYPES = ('unsigned', 'signed')


class Signal(object):
    """One sampled signal: sample indices n and raw unsigned words, plus the
    number format set on its scope block."""
    def __init__(self, name, width, n, raw, arith_type='unsigned', bin_pt=0):
        self.name = name
        self.width = width
        self.n = n        # float64, sample index 0, 1, 2, ...
        self.raw = raw    # float64, unsigned word value, NaN for x / z
        self.arith_type = arith_type if arith_type in ARITH_TYPES else 'unsigned'
        self.bin_pt = max(int(bin_pt), 0)

    @property
    def is_bit(self):
        return self.width == 1

    def values(self, arith_type=None, bin_pt=None):
        """The samples as fixed-point numbers: signed reads the word as two's
        complement, and the result is divided by 2^bin_pt. Defaults to the
        format of the scope block."""
        arith_type = self.arith_type if arith_type is None else arith_type
        bin_pt = self.bin_pt if bin_pt is None else bin_pt
        vals = self.raw.copy()
        if arith_type == 'signed':
            neg = vals >= 2.0**(self.width - 1)   # False for NaN
            vals[neg] -= 2.0**self.width
        elif arith_type != 'unsigned':
            raise ValueError('arithmetic type %r is not unsigned or signed' % arith_type)
        return vals / 2.0**bin_pt


def _raw_series(entry):
    t = np.array([d[0] for d in entry['data']], dtype=np.float64)
    vals = [parse_value(str(d[1])) for d in entry['data']]
    raw = np.array([np.nan if v is None else float(v) for v in vals], dtype=np.float64)
    return t, raw


def rising_edge_indices(clk):
    """Indices i where clk goes 0 -> 1 between samples i-1 and i."""
    c = np.nan_to_num(clk, nan=0.0)
    return np.nonzero((c[1:] == 1) & (c[:-1] == 0))[0] + 1


def load(filename):
    """Return the list of Signals in the file (user_clk excluded), sampled on
    the rising edges of user_clk. Without a user_clk every recorded sample
    is kept."""
    with open(filename, 'r', encoding='utf-8') as f:
        simdata = json.load(f)['simdata']
    series = {}
    widths = {}
    formats = {}
    order = []
    for entry in simdata:
        name = entry['name']
        series[name] = _raw_series(entry)
        widths[name] = int(entry.get('type', {}).get('width', 1))
        formats[name] = entry.get('format', {})
        order.append(name)
    edges = None
    if CLOCK_NAME in series:
        edges = rising_edge_indices(series[CLOCK_NAME][1])
    signals = []
    for name in order:
        if name == CLOCK_NAME:
            continue
        t, raw = series[name]
        if edges is not None and len(edges):
            # the value just before each edge
            raw = raw[edges - 1]
        fmt = formats[name]
        signals.append(Signal(name, widths[name], np.arange(len(raw), dtype=np.float64), raw,
                              str(fmt.get('arith_type', 'unsigned')).lower(), fmt.get('bin_pt', 0)))
    return signals
