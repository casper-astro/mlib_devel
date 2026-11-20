import json
import os

# the Xcos parameter templates of the casper_xps blocks
XPS_TEMPLATES = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                             'scilab_blocks', 'casper_xps')


def xps_template(module):
    """Default parameters of a casper_xps Xcos block (its .json template),
    i.e. what a newly placed block of that kind holds."""
    with open(os.path.join(XPS_TEMPLATES, module + '.json')) as f:
        p = json.load(f)['parameters']
    return dict(zip(p['keys'], p['values']))
