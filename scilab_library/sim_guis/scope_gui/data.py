"""
Load casper_simulation.json (written by CasperRawData.WriteSimData) for the
scope GUI. Independent of Qt, so it can be tested without a display.

The json holds {'simdata': [{'name', 'type': {'width', ...}, 'data':
[[t_ps, value], ...]}, ...]}, with one value every `tick` ps (half a clock
period) and value strings as written in the VCD: 'b0101' for a bus, '0' or
'1' for a 1-bit signal, with 'x' / 'z' for unknown bits.

Each signal is sampled once per clock cycle, on the rising edges of
user_clk: the value taken is the one just before the edge, i.e. what a
register clocked by that edge captures.
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


class Signal(object):
    """One sampled signal: t (ns of each rising edge) and raw unsigned words."""
    def __init__(self, name, width, t, raw):
        self.name = name
        self.width = width
        self.t = t        # float64, ns
        self.raw = raw    # float64, unsigned word value, NaN for x / z

    @property
    def is_bit(self):
        return self.width == 1

    def values(self, fmt='unsigned'):
        """The samples in the given number format (only 'unsigned' for now;
        signed / fixed point come with the scope block's dtype)."""
        if fmt == 'unsigned':
            return self.raw
        raise ValueError('number format %r is not supported yet' % fmt)


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
    order = []
    for entry in simdata:
        name = entry['name']
        series[name] = _raw_series(entry)
        widths[name] = int(entry.get('type', {}).get('width', 1))
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
            # the value just before each edge; t is the edge time
            t, raw = t[edges], raw[edges - 1]
        signals.append(Signal(name, widths[name], t / 1000.0, raw))
    return signals
