import os
from .dsp_block import DSPBlock
from utils.snapshot_check import check_snapshot, onoff, text
from xps_frontend.sw_reg import sw_reg
from xps_frontend.bram import bram


class snapshot(DSPBlock):
    # casper_library_scopes snapshot on casper_dsp's Scopes/snapshot.sv:
    # captures 2^nsamples data_width-bit words of din into a shared BRAM
    # under software control. Xcos ports (the Simulink ones): din, we, trig
    # -> arm_out (= ctrl bit 0).
    #
    # The block's yellow blocks are not drawn in Xcos: the frontend adds them
    # (embedded_yellow_blocks below, see utils/embedded_yellow.py), named as
    # in a Simulink build so that casperfpga finds them:
    #   <name>_ctrl    sw_reg From Processor -> HDL ctrl
    #   <name>_status  sw_reg To Processor   <- HDL status
    #   <name>_bram    shared BRAM (addr_width nsamples, data_width) <- HDL
    #                  bram_addr / bram_data_in / bram_we, -> bram_data_out
    # The shared BRAM's address / word order logic is its dsp interface block
    # (xps_frontend/bram.py), not part of this block.
    #
    # Only BRAM storage with offset, circap, value, ext_arm and ext_circ off
    # is implemented (see utils/snapshot_check.py); provide_outputs has no
    # effect (snapshot's mask initialization always builds it off).

    # casper_dsp RTL files, leaves first (relative to hdl_sources/casper_dsp)
    RTL_FILES = [
        'rtl/BasicModules/register.sv',
        'rtl/Delays/delay_srl.sv',
        'rtl/Delays/pipeline.sv',
        'rtl/BasicModules/delay.sv',
        'rtl/Misc/edge_detect.v',
        'rtl/BasicModules/multiplexer.sv',
        'rtl/BasicModules/inverter.sv',
        'rtl/BasicModules/logical.sv',
        'rtl/BasicModules/counter.sv',
        'rtl/BasicModules/slice.v',
        'rtl/Scopes/snapshot.sv',
    ]
    ENTITY = 'snapshot'
    # prefix of the yellow block names below the block (bitfield_snapshot: _ss)
    SS = ''
    # Simulink input ports -> HDL ports
    IN_PORTS = [('din', 'din'), ('we', 'we'), ('trig', 'trig')]

    def initialize(self):
        for relpath in self.RTL_FILES:
            self.add_source(os.path.join('casper_dsp', relpath))

    @classmethod
    def check(cls, p):
        return check_snapshot(p)

    @classmethod
    def _checked(cls, p, name):
        errors, d = cls.check(p)
        if errors:
            raise ValueError('%s %s: %s' % (cls.__name__, name, ' '.join(errors)))
        return d

    def _params(self):
        # the block's jasper.dsp entry
        return self.blk

    def in_widths(self, d):
        return {'din': d['in_width'], 'we': 1, 'trig': 1}

    def add_parameters(self, inst, d):
        p = self._params()
        inst.add_parameter('STORAGE', '0')
        inst.add_parameter('NSAMPLES', '%d' % d['nsamples'])
        inst.add_parameter('DATA_WIDTH', '%d' % d['data_width'])
        inst.add_parameter('USE_DSP48', '%d' % (onoff(p['use_dsp48']) == 'on'))
        inst.add_parameter('IN_WIDTH', '%d' % d['in_width'])

    def modify_top(self, top):
        # let's populate the parent ports first (Xcos links and the links to
        # the embedded yellow blocks)
        self._populate_parent_ports(top)
        d = self._checked(self._params(), self.fullname)
        inst = top.get_instance(entity=self.ENTITY, name=self.fullname)
        self.add_parameters(inst, d)
        f = self.fullname
        widths = self.in_widths(d)
        inst.add_port('clk', 'user_clk', dir='in')
        for xcos_port, hdl_port in self.IN_PORTS:
            inst.add_port(hdl_port, '%s_%s' % (f, xcos_port), parent_port=False, width=widths[hdl_port], dir='in')
        # ports to / from the embedded yellow blocks
        inst.add_port('ctrl', f + '_ctrl', parent_port=False, width=32, dir='in')
        inst.add_port('bram_data_out', f + '_bram_data_out', parent_port=False, width=d['data_width'], dir='in')
        inst.add_port('status', f + '_status', parent_port=False, width=32, dir='out')
        inst.add_port('bram_addr', f + '_bram_addr', parent_port=False, width=d['nsamples'], dir='out')
        inst.add_port('bram_data_in', f + '_bram_data_in', parent_port=False, width=d['data_width'], dir='out')
        inst.add_port('bram_we', f + '_bram_we', parent_port=False, width=1, dir='out')
        inst.add_port('arm_out', f + '_arm_out', parent_port=False, width=1, dir='out')

    def generate_compile_order(self):
        casper_dsp_root = os.path.join(self.hdl_root, 'casper_dsp')
        co = {
            'lib': 'xil_defaultlib',
            'modules': [os.path.join(casper_dsp_root, relpath) for relpath in self.RTL_FILES],
            'fullpath': True,
        }
        self.compile_order['verilog'].append(co)

    # *******************************************************************
    # embedded yellow blocks (utils/embedded_yellow.py)
    # *******************************************************************
    @classmethod
    def snapshot_design_info(cls, p, d):
        """casper:snapshot entry, the keys / values Simulink writes for the
        snapshot (casperfpga reads data_width and nsamples)."""
        return {'storage': 'bram', 'dram_dimm': text(p.get('dram_dimm', '2')),
                'dram_clock': text(p.get('dram_clock', '250')), 'nsamples': str(d['nsamples']),
                'data_width': str(d['data_width']), 'offset': 'off', 'circap': 'off', 'value': 'off',
                'ext_arm': 'off', 'ext_circ': 'off', 'provide_outputs': 'off',
                'use_dsp48': onoff(p['use_dsp48'])}

    @classmethod
    def own_design_info(cls, blk, d):
        return [dict(name=blk['name'], tag='casper:snapshot', **cls.snapshot_design_info(blk, d))]

    @classmethod
    def embedded_yellow_blocks(cls, blk):
        d = cls._checked(blk, blk['name'])
        ss = blk['name'] + cls.SS
        ns, dw = d['nsamples'], d['data_width']
        return {
            'yellow_blocks': [
                # the swreg settings of the Simulink snapshot's ctrl / status
                {'block': sw_reg.config(ss + '_ctrl', 'From Processor', 32, sim_port='off'),
                 'ports': [('ctrl', 'user_data_out', 32, 'in')]},
                {'block': sw_reg.config(ss + '_status', 'To Processor', 32, sim_port='off'),
                 'ports': [('status', 'user_data_in', 32, 'out')]},
                {'block': bram.config(ss + '_bram', ns, dw),
                 'ports': [('bram_addr', 'addr', ns, 'out'), ('bram_data_in', 'data_in', dw, 'out'),
                           ('bram_we', 'we', 1, 'out'), ('bram_data_out', 'data_out', dw, 'in')]},
            ],
            'design_info': cls.own_design_info(blk, d),
        }
