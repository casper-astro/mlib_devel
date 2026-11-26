from .sim_block import SimBlock
from . import fixed_point
import numpy as np
import logging


# Noise distributions: the 'distribution' parameter (lower case) -> a
# function (rng, n, params) returning n real noise values, where rng is a
# numpy Generator seeded with the block's seed and params the block's
# parameters (strings, as in jasper.json). To add a distribution, add a
# function here, register it in NOISE_TYPES, and add it to the
# distribution drop-down in block_guis/casper_sim/noise (plus any new
# parameters to scilab_blocks/casper_sim/noise.json and the GUI).
def _gaussian(rng, n, params):
    mean = float(params['mean'])
    std_dev = float(params['std_dev'])
    if std_dev < 0:
        raise ValueError('std_dev must not be negative, got %s' % params['std_dev'])
    return mean + std_dev * rng.standard_normal(n)


NOISE_TYPES = {
    'gaussian': _gaussian,
}


class noise(SimBlock):
    def __init__(self, blk):
        super().__init__(blk)
        self.logger = logging.getLogger('jasper-sim.sim_block.noise')
        self.length = 0

    def gen_sim_data(self):
        """
        Generate sim_length noise samples and write them into <dir>/<name>.dat.
        """
        # SimBlock.sim_length is set by the sim block before this runs
        self.length = SimBlock.sim_length
        dist = str(self.val.get('distribution', 'Gaussian')).strip().lower()
        if dist not in NOISE_TYPES:
            raise ValueError('noise %s: distribution must be one of %s, got %r'
                             % (self.name, ', '.join(NOISE_TYPES), self.val.get('distribution')))
        seed = int(float(self.val.get('seed', 0)))
        width = int(self.val['output_bit_width'])
        bin_pt = int(float(self.val.get('bin_pt', 0)))
        arith_type = str(self.val.get('arith_type', 'signed')).strip().lower()
        overflow = str(self.val.get('overflow', 'Saturate')).strip().lower()
        self.logger.info('Generating %s noise data under %s/%s.dat' % (dist, self.dir, self.name))
        self.logger.info('length %d, seed %d, %d bits %s, binary point %d, overflow %s'
                         % (self.length, seed, width, arith_type, bin_pt, overflow))

        rng = np.random.default_rng(seed)
        values = NOISE_TYPES[dist](rng, self.length, self.val)
        words = fixed_point.quantize(values, width, bin_pt, arith_type, overflow,
                                     what='noise %s' % self.name)
        lo, hi = fixed_point.word_range(width, arith_type)
        n_clip = sum(1 for w in words if w in (lo, hi))
        if overflow == 'saturate' and n_clip:
            self.logger.info('%d of %d samples are at the limits of the output range' % (n_clip, len(words)))
        fixed_point.write_dat(self.dir + '/' + self.name + '.dat', words, width)
