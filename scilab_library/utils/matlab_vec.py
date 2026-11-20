"""Parse the MATLAB-style vector expressions that Simulink masks take for
vector parameters (e.g. munge's div_size / order), without evaluating
arbitrary code.

Accepted (elements separated by spaces, commas or semicolons, optionally in
[...] or {...}):
    16            a number
    [8 0 9 1]     a list
    0:15  0:2:14  ranges (a:b, a:step:b), as in MATLAB
    16*ones(1,16) ones(1,16)*16  ones(1,16)  ones(16,1)
    zeros(1,4)
and any concatenation of these, e.g. [16*ones(1,8) 8 8].
"""
import re

_NUM = r'[+-]?(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?'
_FILL = re.compile(r'^(?:(%s)\*)?(ones|zeros)\((\d+)(?:,(\d+))?\)(?:\*(%s))?$' % (_NUM, _NUM))
_RANGE = re.compile(r'^(%s):(?:(%s):)?(%s)$' % (_NUM, _NUM, _NUM))


def _num(text):
    val = float(text)
    return int(val) if val == int(val) else val


def _element(text):
    if re.fullmatch(_NUM, text):
        return [_num(text)]
    m = _RANGE.match(text)
    if m:
        start, step, stop = float(m.group(1)), float(m.group(2) or 1), float(m.group(3))
        if step == 0:
            raise ValueError('range %r has a zero step' % text)
        vals, k = [], 0
        while (step > 0 and start + k * step <= stop + 1e-9) or (step < 0 and start + k * step >= stop - 1e-9):
            vals.append(_num(repr(start + k * step)))
            k += 1
        return vals
    m = _FILL.match(text)
    if m:
        pre, func, rows, cols, post = m.groups()
        rows, cols = int(rows), int(cols) if cols is not None else int(rows)
        if pre is not None and post is not None:
            raise ValueError('cannot parse %r' % text)
        if cols is not None and min(rows, cols) > 1:
            raise ValueError('%r is a matrix, not a vector' % text)
        scale = _num(pre if pre is not None else post) if (pre or post) else 1
        fill = scale if func == 'ones' else 0
        return [fill] * (rows * cols)
    raise ValueError('cannot parse %r' % text)


def parse_vector(text):
    """List of numbers (int when integral) of a MATLAB vector expression;
    raises ValueError when the text is not one of the accepted forms."""
    if isinstance(text, (int, float)):
        return [_num(repr(text))]
    if isinstance(text, (list, tuple)):
        return [_num(repr(v)) for v in text]
    s = str(text).strip()
    if s[:1] in '[{' and s[-1:] in ']}':
        s = s[1:-1]
    # no spaces around operators or inside parentheses, so that only element
    # separators remain
    s = re.sub(r'\s*([*:])\s*', r'\1', s)
    s = re.sub(r'\(\s*([^)]*?)\s*\)', lambda m: '(' + re.sub(r'\s+', '', m.group(1)) + ')', s)
    out = []
    depth, cur = 0, ''
    for ch in s + ' ':
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        if depth == 0 and ch in ' \t,;':
            if cur:
                out += _element(cur)
            cur = ''
        else:
            cur += ch
    if depth != 0:
        raise ValueError('unbalanced parentheses in %r' % text)
    if not out:
        raise ValueError('empty vector')
    return out
