from .snapshot import snapshot
from utils.snapshot_check import check_bitsnap, onoff, text


class bitfield_snapshot(snapshot):
    # casper_library_scopes bitfield_snapshot (mask type bitsnap) on
    # casper_dsp's Scopes/bitfield_snapshot.sv: a snapshot (named ss inside)
    # behind snap_delay registers on the data, we and trig. Xcos ports (the
    # Simulink ones): in_<io name> (one io field, io_widths bits), we, trig
    # -> arm_out.
    #
    # Its yellow blocks are the inner snapshot's, named
    # <name>_ss_ctrl / _ss_status / _ss_bram as in a Simulink build (see
    # dsp_blocks/snapshot.py). design_info gets a casper:bitsnap entry for
    # the block and a casper:snapshot entry for <name>_ss, which casperfpga
    # pairs to name the captured field.

    RTL_FILES = snapshot.RTL_FILES + ['rtl/Scopes/bitfield_snapshot.sv']
    ENTITY = 'bitfield_snapshot'
    SS = '_ss'

    @classmethod
    def check(cls, p):
        return check_bitsnap(p)

    @property
    def IN_PORTS(self):
        d = self._checked(self._params(), self.fullname)
        return [('in_' + d['io_name'], 'din'), ('we', 'we'), ('trig', 'trig')]

    def in_widths(self, d):
        return {'din': d['io_width'], 'we': 1, 'trig': 1}

    def add_parameters(self, inst, d):
        p = self._params()
        inst.add_parameter('IO_WIDTH', '%d' % d['io_width'])
        inst.add_parameter('SNAP_STORAGE', '0')
        inst.add_parameter('SNAP_NSAMPLES', '%d' % d['nsamples'])
        inst.add_parameter('SNAP_DATA_WIDTH', '%d' % d['data_width'])
        inst.add_parameter('SNAP_USE_DSP48', '%d' % (onoff(p['snap_use_dsp48']) == 'on'))
        inst.add_parameter('SNAP_DELAY', '%d' % d['delay'])

    @classmethod
    def own_design_info(cls, blk, d):
        # the bitsnap's mask values as typed (casperfpga reads io_names,
        # io_widths, io_types, io_bps, snap_data_width and snap_nsamples)
        keys = ['io_names', 'io_widths', 'io_bps', 'io_types', 'show_format', 'snap_storage',
                'snap_dram_dimm', 'snap_dram_clock', 'snap_nsamples', 'snap_data_width', 'snap_offset',
                'snap_circap', 'snap_value', 'snap_ext_arm', 'snap_ext_circ', 'snap_provide_outputs',
                'snap_use_dsp48', 'snap_delay', 'extra_names', 'extra_widths', 'extra_bps', 'extra_types']
        bitsnap = dict(name=blk['name'], tag='casper:bitsnap')
        bitsnap.update({k: text(blk[k]) for k in keys})
        # the inner snapshot, as bitsnap_init.m sets it up
        ss = {'storage': text(blk['snap_storage']), 'dram_dimm': text(blk['snap_dram_dimm']),
              'dram_clock': text(blk['snap_dram_clock']), 'use_dsp48': blk['snap_use_dsp48']}
        return [bitsnap, dict(name=blk['name'] + cls.SS, tag='casper:snapshot',
                              **cls.snapshot_design_info(ss, d))]
