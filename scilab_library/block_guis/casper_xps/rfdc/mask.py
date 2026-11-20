import sys, os
import re
import math
import logging
import json
from argparse import ArgumentParser

from PyQt6.QtWidgets import (QApplication, QMainWindow, QMessageBox, QCheckBox,
                             QComboBox, QDoubleSpinBox)
from PyQt6.QtGui import QIcon
from rfdc_ui import Ui_MainWindow


sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from utils.utils import make_rich_logger, gen_bconfig


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)


# ---------------------------------------------------------------------------
# Device properties (xps_library/get_rfsoc_properties.m)
#
# In Simulink these come from the FPGA part of the System Generator block.
# Nothing about the platform/part reaches this dialog (run_mask.sci only
# passes --template/--target/--log), so the values below are fixed to the
# RFSoC gen3 dual-tile devices (xczu47dr/xczu48dr) used by the supported
# platforms (rfsoc4x2, rfsoc8x8).  To support a quad-tile / gen1 part, the
# part (or platform) has to be passed to this script (e.g. an extra JSON
# parameter written by run_mask.sci from the design's platform block) and
# assigned to the three variables below -- every rule in this file is
# already parameterised on them.
# ---------------------------------------------------------------------------
RFSOC_GEN = 3
ADC_TILE_ARCH = 'DT'
DAC_TILE_ARCH = 'DT'

ADC_TILES = [224, 225, 226, 227]
DAC_TILES = [228, 229, 230, 231]
NSLICES = {'DT': 2, 'QT': 4}
DEC_INTERP_OPTS = {
    1: ['1x', '2x', '4x', '8x'],
    3: ['1x', '2x', '3x', '4x', '5x', '6x', '8x', '10x', '12x', '16x', '20x', '24x', '40x'],
}
# (gen, adc arch) -> (fs_min, fs_max) in Msps, get_rfsoc_properties.m
ADC_FS_LIMITS = {
    (1, 'DT'): (1000.0, 4096.0),
    (1, 'QT'): (500.0, 2058.0),
    (3, 'DT'): (500.0, 5000.0),
    (3, 'QT'): (500.0, 2500.0),
}
AXIS_CLK_MAX_MHZ = 512.0          # update_axis_clk.m
INVALID_AXIS = '*Axis Clocking Invalid*'

# slice fields that have one widget per stacked page
ADC_PAGES = ('real', 'iq', 'iq_coarse')
DAC_PAGES = ('bypassed', 'fine', 'coarse')
ADC_FIELD_SUFFIXES = {
    'enable': ADC_PAGES, 'digital_output': ADC_PAGES, 'dec_mode': ADC_PAGES,
    'sample_per_cycle': ADC_PAGES, 'req_axis_clk': ADC_PAGES,
    'mixer_type': ADC_PAGES, 'mixer_mode': ADC_PAGES,
    'nyquist_zone': ADC_PAGES, 'cal_mode': ADC_PAGES,
    'coarse_freq': (None,), 'nco_freq': ('iq',), 'nco_phase': ('iq',),
}
DAC_FIELD_SUFFIXES = {
    'enable': DAC_PAGES, 'analog_output': DAC_PAGES, 'inter_mode': DAC_PAGES,
    'sample_per_cycle': DAC_PAGES, 'req_axis_clk': DAC_PAGES,
    'mixer_type': DAC_PAGES, 'mixer_mode': DAC_PAGES,
    'nyquist_zone': DAC_PAGES, 'decode_mode': DAC_PAGES,
    'coarse_freq': ('coarse',), 'nco_freq': (None,), 'nco_phase': (None,),
}
FIELD_SUFFIXES = {'adc': ADC_FIELD_SUFFIXES, 'dac': DAC_FIELD_SUFFIXES}

ADC_TILE_KEYS = ['enable_mts', 'sample_rate', 'clk_out', 'enable_pll', 'ref_clk',
                 'axi_stream_clk', 'has_adc_clk', 'adc_clk_src', 'clk_dist']
DAC_TILE_KEYS = ['enable_mts', 'sample_rate', 'clk_out', 'enable_pll', 'ref_clk',
                 'axi_stream_clk', 'output_power', 'has_dac_clk', 'dac_clk_src', 'clk_dist']


# ---------------------------------------------------------------------------
# helpers ported from the MATLAB callbacks
# ---------------------------------------------------------------------------
def mround(v, nd=0):
    """MATLAB round(v, nd): halves round away from zero (Python's round()
    rounds them to even, e.g. 125.0625 -> 125.062 instead of 125.063)."""
    f = 10 ** nd
    return math.copysign(math.floor(abs(v) * f + 0.5) / f, v)


def fmt_num(v, nd=3):
    """round to `nd` decimals and print without trailing zeros (MATLAB
    num2str/%g style: 2000 -> '2000', 245.76 -> '245.76')."""
    s = f'{mround(float(v), nd):.{nd}f}'.rstrip('0').rstrip('.')
    return '0' if s in ('', '-0') else s


def to_float(v, default=0.0):
    try:
        return float(v)
    except (TypeError, ValueError):
        return default


def parse_factor(s):
    """'8x' -> 8 (regexp '([0-9]*)x' in update_axis_clk.m)"""
    m = re.match(r'\s*([0-9]+)\s*x', str(s))
    return int(m.group(1)) if m else None


def calc_rfpll_vco(gen, sample_rate_mhz):
    """calc_rfpll_vco.m"""
    vco_min = 8500.0
    vco_max = 13112.0 if gen < 2 else 13200.0
    M, VCO = [], []
    for m in [2, 3] + list(range(4, 65, 2)):
        vco = sample_rate_mhz * m
        if vco >= vco_min:
            if vco <= vco_max:
                VCO.append(vco)
                M.append(m)
            else:
                break
    return M, VCO


def calc_refclk(vco, R=1):
    """calc_refclk.m"""
    refclk_min = 102.406
    refclk_max = 1230.0
    refclk, fbdiv = [], []
    n = 13
    while n < 256:
        fin = mround(vco * (R / n), 3)
        if fin <= refclk_max:
            if fin >= refclk_min:
                refclk.append(fin)
                fbdiv.append(n)
            else:
                break
        n += 1
    return fbdiv, refclk


def calc_clkout(sample_rate_mhz, fs_max):
    """update_adc_clkout.m (note: fs_max is in Msps so `fs_max >= 4.0` is
    always true there, i.e. the dividers are always 16/32/64/128)."""
    div = [2 ** k for k in range(3, 7)]
    if fs_max >= 4.0:
        div = [d * 2 for d in div]
    out = []
    for d in div:
        c = mround(sample_rate_mhz / d, 3)
        if c > 10.0:
            out.append(c)
    return out


class RFDCOperations(object):
    def __init__(self, winobj, template_config='rfdc.json', target_config='rfdc.json', logdir='.', debug=False):
        level = logging.DEBUG if debug else logging.ERROR
        self.logger = make_rich_logger('rfdc.log', level, mode='a', logdir=logdir)
        self.logger.info('RFDC Mask started.')
        self.logger.info(f'Template config file is {template_config}.')
        self.logger.info(f'Target config file is {target_config}.')
        self.template_config = template_config
        self.target_config = target_config
        self.winobj = winobj
        self.ui = winobj.ui
        self.gen = RFSOC_GEN
        self.arch = {'adc': ADC_TILE_ARCH, 'dac': DAC_TILE_ARCH}
        self.params = {}      # full flat parameter dict (pass-through for unknown keys)
        self.tiles = {}       # tile -> dict of tile level values (strings)
        self.slices = {}      # (kind, tile, DQ, slice) -> dict of slice values (strings)
        self.opts = {}        # (kind, tile, DQ, slice) -> dict field -> option list (active arch only)
        self.forced = {}      # (kind, tile, DQ, slice) -> odd slice slaved to its even neighbour
        self.ref_opts = {}    # tile -> ref clk option list ([] = PLL unresolvable)
        self.clkout_opts = {}
        self._setup_widgets()
        self.load_config()
        self.setup_signal_functions()

    # -------------------------------------------------------------------
    # generic widget access
    # -------------------------------------------------------------------
    @staticmethod
    def _kind(tile):
        return 'adc' if tile in ADC_TILES else 'dac'

    def _tile_w(self, tile, name):
        return getattr(self.ui, f't{tile}_{name}', None)

    def _slice_ws(self, kind, tile, DQ, a, field):
        """all existing widgets (one per stacked page) of a slice field;
        a handful of tile/slice/page combinations have no widget in
        rfdc_ui.py at all and are simply skipped."""
        out = []
        for suf in FIELD_SUFFIXES[kind][field]:
            name = f't{tile}_{DQ}_{kind}{a}_{field}' + (f'_{suf}' if suf else '')
            w = getattr(self.ui, name, None)
            if w is not None:
                out.append(w)
        return out

    def _all_slice_keys(self):
        for kind, tiles in (('adc', ADC_TILES), ('dac', DAC_TILES)):
            for tile in tiles:
                for DQ in ('DT', 'QT'):
                    for a in range(NSLICES[DQ]):
                        yield (kind, tile, DQ, a)

    @staticmethod
    def _set_combo(w, value, items=None):
        w.blockSignals(True)
        if items is not None:
            cur = [w.itemText(i) for i in range(w.count())]
            if cur != list(items):
                w.clear()
                w.addItems(list(items))
        value = str(value)
        if w.findText(value) < 0:
            w.addItem(value)
        w.setCurrentText(value)
        w.blockSignals(False)

    @staticmethod
    def _set_spin(w, value):
        w.blockSignals(True)
        w.setValue(to_float(value))
        w.blockSignals(False)

    @staticmethod
    def _set_check(w, on):
        w.blockSignals(True)
        w.setChecked(on)
        w.blockSignals(False)

    def _setup_widgets(self):
        """ranges/decimals that rfdc_ui.py leaves at the Qt defaults
        (2 decimals, max 99.99 / 3932.16)."""
        for tile in ADC_TILES + DAC_TILES:
            w = self._tile_w(tile, 'sample_rate')
            w.setDecimals(3)
            w.setRange(0.0, 100000.0)
            w = self._tile_w(tile, 'axi_stream_clk')
            w.setDecimals(3)
            w.setRange(0.0, 100000.0)
            # value 0 (= minimum) is used to show the invalid marker
            w.setSpecialValueText(INVALID_AXIS)
            w.setReadOnly(True)
            w = self._tile_w(tile, 'output_power')
            if w is not None:
                w.setDecimals(0)
                w.setRange(0.0, 100000.0)
        for key in self._all_slice_keys():
            kind = key[0]
            for w in self._slice_ws(*key, 'req_axis_clk'):
                w.setDecimals(3)
                w.setRange(0.0, 100000.0)
                w.setReadOnly(True)
                w.setEnabled(False)
            for w in self._slice_ws(*key, 'nco_freq'):
                w.setDecimals(6)            # GHz -> 1 kHz resolution
                w.setRange(-100.0, 100.0)
                w.setReadOnly(False)
            for w in self._slice_ws(*key, 'nco_phase'):
                w.setDecimals(6)
                w.setRange(-1.0e6, 1.0e6)
                w.setReadOnly(False)
        # only the architecture of the device can be configured
        for tile in ADC_TILES:
            getattr(self.ui, f't{tile}_adcs_stackedwidget').setCurrentIndex(0 if self.arch['adc'] == 'DT' else 1)
        for tile in DAC_TILES:
            getattr(self.ui, f't{tile}_dacs_stackedwidget').setCurrentIndex(0 if self.arch['dac'] == 'DT' else 1)

    def _status(self, msg):
        self.logger.warning(msg)
        try:
            self.winobj.statusBar().showMessage(msg, 10000)
        except Exception:
            pass

    # -------------------------------------------------------------------
    # tile level derived values
    # -------------------------------------------------------------------
    def _fs(self, tile):
        return to_float(self.tiles[tile]['sample_rate'])

    def _adc_fs_limits(self):
        return ADC_FS_LIMITS[(self.gen, self.arch['adc'])]

    def update_pll(self, tile, initial=False):
        """update_pll.m"""
        t = self.tiles[tile]
        fs = self._fs(tile)
        w = self._tile_w(tile, 'ref_clk')
        if t['enable_pll'] != 'on':
            opts = [fmt_num(fs)]
            t['ref_clk'] = opts[0]
            w.setEnabled(False)
        else:
            w.setEnabled(True)
            M, VCO = calc_rfpll_vco(self.gen, fs)
            if not VCO:
                opts = []
                self._status(f'Tile{tile}: RFPLL parameters could not be resolved to determine a valid ref. clock freq.')
            else:
                fbdiv, refclk = calc_refclk(VCO[0], 1)
                opts = [fmt_num(r) for r in refclk]
                sel = [r for r in refclk if r <= fs / 8.0] or [r for r in refclk if r <= 130.0] or refclk[-1:]
                default = fmt_num(sel[0])
                if initial:
                    match = [o for o in opts if abs(to_float(o) - to_float(t['ref_clk'], -1)) < 1e-6]
                    if match:
                        t['ref_clk'] = match[0]
                    else:
                        self.logger.warning(f'Tile{tile}: ref_clk {t["ref_clk"]} is not a valid RF-PLL reference, using {default}.')
                        t['ref_clk'] = default
                elif opts != self.ref_opts.get(tile):
                    t['ref_clk'] = default
        self.ref_opts[tile] = opts
        self._set_combo(w, t['ref_clk'], opts if opts else None)

    def update_clkout(self, tile, initial=False):
        """update_adc_clkout.m"""
        t = self.tiles[tile]
        opts = [fmt_num(c) for c in calc_clkout(self._fs(tile), self._adc_fs_limits()[1])]
        if opts:
            if initial:
                match = [o for o in opts if abs(to_float(o) - to_float(t['clk_out'], -1)) < 1e-6]
                if match:
                    t['clk_out'] = match[0]
                else:
                    self.logger.warning(f'Tile{tile}: clk_out {t["clk_out"]} not available, using {opts[0]}.')
                    t['clk_out'] = opts[0]
            elif opts != self.clkout_opts.get(tile):
                t['clk_out'] = opts[0]
        self.clkout_opts[tile] = opts
        self._set_combo(self._tile_w(tile, 'clk_out'), t['clk_out'], opts if opts else None)

    def enable_mts_opt(self):
        """enable_mts_opt.m (only tile 224 in the MATLAB mask)"""
        w = self._tile_w(224, 'enable_mts')
        if self.tiles[224]['enable'] == 'on':
            w.setEnabled(True)
        else:
            self.tiles[224]['enable_mts'] = 'off'
            self._set_check(w, False)
            w.setEnabled(False)

    # -------------------------------------------------------------------
    # slice rules (validate_digital_data.m, validate_analog_data.m,
    # mixer_callback.m, mixertype_callback.m, dec_interp_opts.m,
    # enable_adc_opt.m, enable_dac_opt.m, update_axis_clk.m,
    # update_axis_clk_label.m, validate_tile_clocking.m)
    # -------------------------------------------------------------------
    @staticmethod
    def _coerce(s, field, opts, prefer=None):
        if opts and s.get(field) not in opts:
            s[field] = prefer if prefer in opts else opts[0]

    def _spc_options(self, fs, factor, wmax, quad_iq):
        w = list(range(1, (8 if self.gen < 2 else wmax) + 1))
        if quad_iq:
            w = w[1::2]
        out = []
        for x in w:
            clk = fs / factor / x
            if quad_iq:
                clk = 2 * clk
            if mround(clk, 3) <= AXIS_CLK_MAX_MHZ:
                out.append(str(x))
        return out

    def apply_rules(self, tile):
        kind = self._kind(tile)
        DQ = self.arch[kind]
        fs = self._fs(tile)
        for a in range(NSLICES[DQ]):
            key = (kind, tile, DQ, a)
            if kind == 'adc':
                self._adc_slice_rules(key, fs)
            else:
                self._dac_slice_rules(key, fs)
        self._tile_axis(tile)

    def _adc_slice_rules(self, key, fs):
        kind, tile, DQ, a = key
        s = self.slices[key]
        o = {}
        forced = False
        if a % 2 == 1:
            e = self.slices[(kind, tile, DQ, a - 1)]
            forced = (e['enable'] == 'on' and e['digital_output'] == 'I/Q'
                      and e['mixer_mode'] == 'I/Q -> I/Q')
        if forced:
            s.update(enable='on', digital_output='I/Q', mixer_type='Off', mixer_mode='I/Q -> I/Q')
            for f in ('dec_mode', 'sample_per_cycle', 'nyquist_zone', 'cal_mode'):
                s[f] = e[f]
        o['digital_output'] = ['I/Q'] if forced else ['Real', 'I/Q']
        self._coerce(s, 'digital_output', o['digital_output'])
        if s['digital_output'] == 'Real':
            o['mixer_type'], o['mixer_mode'] = ['Bypassed'], ['Real -> Real']
        elif forced:
            o['mixer_type'], o['mixer_mode'] = ['Off'], ['I/Q -> I/Q']
        elif a % 2 == 0:
            o['mixer_type'], o['mixer_mode'] = ['Fine', 'Coarse'], ['Real -> I/Q', 'I/Q -> I/Q']
        else:
            o['mixer_type'], o['mixer_mode'] = ['Fine', 'Coarse'], ['Real -> I/Q']
        self._coerce(s, 'mixer_type', o['mixer_type'])
        self._coerce(s, 'mixer_mode', o['mixer_mode'])
        if s['mixer_type'] == 'Bypassed':
            s.update(nco_freq='0', nco_phase='0', coarse_freq='0')
            o['coarse_freq'] = ['0']
        elif s['mixer_type'] == 'Coarse':
            s.update(nco_freq='0', nco_phase='0')
            o['coarse_freq'] = ['Fs/2', 'Fs/4', '-Fs/4']
            self._coerce(s, 'coarse_freq', o['coarse_freq'])
        else:   # Fine / Off: coarse freq not used, keep the value
            o['coarse_freq'] = [s['coarse_freq']]
        o['dec_mode'] = DEC_INTERP_OPTS[self.gen]
        self._coerce(s, 'dec_mode', o['dec_mode'])
        factor = parse_factor(s['dec_mode'])
        quad_iq = (DQ == 'QT' and s['digital_output'] == 'I/Q')
        o['sample_per_cycle'] = self._spc_options(fs, factor, 12, quad_iq)
        self._coerce(s, 'sample_per_cycle', o['sample_per_cycle'])
        clk = fs / factor / to_float(s['sample_per_cycle'], 1)
        if quad_iq:
            clk = 2 * clk
        s['req_axis_clk'] = fmt_num(clk)
        self.opts[key] = o
        self.forced[key] = forced

    def _dac_slice_rules(self, key, fs):
        kind, tile, DQ, a = key
        s = self.slices[key]
        o = {}
        forced = False
        if a % 2 == 1:
            e = self.slices[(kind, tile, DQ, a - 1)]
            forced = (e['enable'] == 'on' and e['analog_output'] == 'I/Q'
                      and e['mixer_mode'] == 'I/Q -> I/Q')
        if forced:
            s.update(enable='on', analog_output='I/Q', mixer_type='Off', mixer_mode='I/Q -> I/Q')
            for f in ('inter_mode', 'sample_per_cycle', 'nyquist_zone', 'decode_mode'):
                s[f] = e[f]
            o['analog_output'] = ['I/Q']
        elif a % 2 == 0:
            o['analog_output'] = ['Real', 'I/Q']
        else:
            o['analog_output'] = ['Real']      # odd slice can only be I/Q through its even neighbour
        self._coerce(s, 'analog_output', o['analog_output'])
        if forced:
            o['mixer_type'], o['mixer_mode'] = ['Off'], ['I/Q -> I/Q']
        else:
            o['mixer_type'] = ['Fine', 'Coarse']
            # the DAC has no 'Bypassed' mixer in the MATLAB mask; the backend maps
            # 'Bypassed' to the same value as 'Coarse' on gen3
            self._coerce(s, 'mixer_type', o['mixer_type'], prefer='Coarse')
            if s['analog_output'] == 'I/Q':
                o['mixer_mode'] = ['I/Q -> I/Q']
            elif s['mixer_type'] == 'Fine':
                o['mixer_mode'] = ['I/Q -> Real']
            else:
                o['mixer_mode'] = ['Real -> Real', 'I/Q -> Real']
        self._coerce(s, 'mixer_type', o['mixer_type'])
        self._coerce(s, 'mixer_mode', o['mixer_mode'])
        if s['mixer_type'] == 'Coarse':
            s.update(nco_freq='0', nco_phase='0')
            if s['mixer_mode'] == 'I/Q -> Real':
                o['coarse_freq'] = ['Fs/2', 'Fs/4', '-Fs/4']
            elif s['mixer_mode'] == 'I/Q -> I/Q':
                # validate_analog_data.m: I/Q output with the coarse mixer has no '0'
                o['coarse_freq'] = ['Fs/2', 'Fs/4', '-Fs/4']
            else:
                o['coarse_freq'] = ['0']
            self._coerce(s, 'coarse_freq', o['coarse_freq'])
        else:
            o['coarse_freq'] = [s['coarse_freq']]
        o['inter_mode'] = list(DEC_INTERP_OPTS[self.gen])
        if s['mixer_mode'] != 'Real -> Real':
            o['inter_mode'] = o['inter_mode'][1:]
        self._coerce(s, 'inter_mode', o['inter_mode'])
        factor = parse_factor(s['inter_mode'])
        quad_iq = (DQ == 'QT' and s['analog_output'] == 'I/Q')
        o['sample_per_cycle'] = self._spc_options(fs, factor, 16, quad_iq)
        self._coerce(s, 'sample_per_cycle', o['sample_per_cycle'])
        clk = fs / factor / to_float(s['sample_per_cycle'], 1)
        if s['analog_output'] == 'I/Q' or s['mixer_mode'] == 'I/Q -> Real':
            clk = 2 * clk
        s['req_axis_clk'] = fmt_num(clk)
        self.opts[key] = o
        self.forced[key] = forced

    def _tile_axis(self, tile):
        """validate_tile_clocking.m: only enabled slices of the device arch"""
        kind = self._kind(tile)
        DQ = self.arch[kind]
        clks = [to_float(self.slices[(kind, tile, DQ, a)]['req_axis_clk'])
                for a in range(NSLICES[DQ]) if self.slices[(kind, tile, DQ, a)]['enable'] == 'on']
        if clks:
            if all(c == clks[0] for c in clks):
                self.tiles[tile]['axi_stream_clk'] = fmt_num(clks[0])
            else:
                self.tiles[tile]['axi_stream_clk'] = INVALID_AXIS

    # -------------------------------------------------------------------
    # rendering state -> widgets
    # -------------------------------------------------------------------
    def _page_of(self, kind, s):
        if kind == 'adc':
            if s['digital_output'] == 'Real' or s['mixer_type'] == 'Bypassed':
                return 'real'
            return 'iq_coarse' if s['mixer_type'] == 'Coarse' else 'iq'
        # the DAC mixer is never bypassed in the MATLAB mask
        return 'coarse' if s['mixer_type'] == 'Coarse' else 'fine'

    def render_slice(self, key):
        kind, tile, DQ, a = key
        s = self.slices[key]
        o = self.opts.get(key)
        active = (DQ == self.arch[kind])
        forced = self.forced.get(key, False)
        for field in FIELD_SUFFIXES[kind]:
            for w in self._slice_ws(*key, field):
                if isinstance(w, QCheckBox):
                    self._set_check(w, s.get('enable') == 'on')
                elif isinstance(w, QComboBox):
                    self._set_combo(w, s.get(field, ''), o.get(field) if (active and o) else None)
                elif isinstance(w, QDoubleSpinBox):
                    self._set_spin(w, s.get(field, 0))
                if active:
                    if field == 'req_axis_clk':
                        w.setEnabled(False)
                    elif forced:
                        w.setEnabled(False)
                    elif field == 'enable':
                        w.setEnabled(True)
                    elif s.get('enable') != 'on':
                        w.setEnabled(False)
                    elif field in ('nco_freq', 'nco_phase'):
                        w.setEnabled(s['mixer_type'] == 'Fine')
                    else:
                        w.setEnabled(True)
        stack = getattr(self.ui, f't{tile}_{DQ}_{kind}{a}_stackedwidget', None)
        frame = getattr(self.ui, f't{tile}_{DQ}_{kind}{a}_frame_{self._page_of(kind, s)}', None)
        if stack is not None and frame is not None:
            idx = stack.indexOf(frame.parentWidget())
            if idx >= 0:
                stack.setCurrentIndex(idx)

    def render_tile(self, tile):
        kind = self._kind(tile)
        t = self.tiles[tile]
        self._set_check(getattr(self.ui, f'Tile{tile}_enable'), t['enable'] == 'on')
        self._set_check(self._tile_w(tile, 'enable_mts'), t['enable_mts'] == 'on')
        self._set_check(self._tile_w(tile, 'enable_pll'), t['enable_pll'] == 'on')
        self._set_spin(self._tile_w(tile, 'sample_rate'), t['sample_rate'])
        self._set_combo(self._tile_w(tile, 'clk_out'), t['clk_out'], self.clkout_opts.get(tile) or None)
        self._set_combo(self._tile_w(tile, 'ref_clk'), t['ref_clk'], self.ref_opts.get(tile) or None)
        axi = t['axi_stream_clk']
        self._set_spin(self._tile_w(tile, 'axi_stream_clk'), 0 if axi == INVALID_AXIS else axi)
        hk, sk = ('has_adc_clk', 'adc_clk_src') if kind == 'adc' else ('has_dac_clk', 'dac_clk_src')
        self._set_check(self._tile_w(tile, hk), t[hk] == 'on')
        self._set_combo(self._tile_w(tile, sk), t[sk])
        self._set_combo(self._tile_w(tile, 'clk_dist'), t['clk_dist'])
        if kind == 'dac':
            self._set_spin(self._tile_w(tile, 'output_power'), t['output_power'])
        for DQ in ('DT', 'QT'):
            for a in range(NSLICES[DQ]):
                self.render_slice((kind, tile, DQ, a))

    def refresh_tile(self, tile):
        self.apply_rules(tile)
        self.render_tile(tile)

    # -------------------------------------------------------------------
    # load / collect
    # -------------------------------------------------------------------
    def load_config(self):
        self.logger.info(f'Loading config from {self.target_config}...')
        with open(self.target_config, 'r', encoding='utf-8') as f:
            config = json.load(f)
        self.params = {k: v for k, v in config['parameters'].items()}
        p = self.params
        self.bad_power = set()
        for tile in ADC_TILES + DAC_TILES:
            keys = ADC_TILE_KEYS if tile in ADC_TILES else DAC_TILE_KEYS
            t = {k: str(p.get(f't{tile}_{k}', '')) for k in keys}
            t['enable'] = str(p.get(f'Tile{tile}_enable', 'off'))
            if 'output_power' in t:
                # a popup in the MATLAB mask: anything but a single number is invalid
                if to_float(t['output_power'], None) is None:
                    self.bad_power.add(tile)
                t['output_power'] = str(int(round(to_float(t['output_power']))))
            self.tiles[tile] = t
        for key in self._all_slice_keys():
            kind, tile, DQ, a = key
            prefix = f't{tile}_{DQ}_{kind}{a}_'
            self.slices[key] = {k[len(prefix):]: str(v) for k, v in p.items() if k.startswith(prefix)}
        for tile in ADC_TILES + DAC_TILES:
            self.update_pll(tile, initial=True)
            self.update_clkout(tile, initial=True)
            self.apply_rules(tile)
        self.enable_mts_opt()
        for tile in ADC_TILES + DAC_TILES:
            self.render_tile(tile)

    def validate(self):
        """checks from rfdc_mask.m / update_rfdc_clocking.m / update_pll.m"""
        errors = []
        if not any(self.tiles[t]['enable'] == 'on' for t in ADC_TILES + DAC_TILES):
            errors.append('At least one ADC or DAC tile must be enabled')
        fs_min, fs_max = self._adc_fs_limits()
        for tile in ADC_TILES + DAC_TILES:
            t = self.tiles[tile]
            if t['enable'] != 'on':
                continue
            kind = self._kind(tile)
            DQ = self.arch[kind]
            keys = [(kind, tile, DQ, a) for a in range(NSLICES[DQ])]
            enabled = [k for k in keys if self.slices[k]['enable'] == 'on']
            if not enabled:
                errors.append(f'Tile{tile}: at least one {kind.upper()} slice must be enabled on each enabled {kind.upper()} tile')
            fs = self._fs(tile)
            if kind == 'adc':
                if fs > fs_max:
                    errors.append(f'Tile{tile}: maximum sample rate for this ADC is {fmt_num(fs_max)} Msps')
                elif fs < fs_min:
                    errors.append(f'Tile{tile}: minimum sample rate for this ADC is {fmt_num(fs_min)} Msps')
            elif fs <= 0:
                errors.append(f'Tile{tile}: invalid sample rate')
            if tile in getattr(self, 'bad_power', ()):
                errors.append(f'Tile{tile}: invalid output power setting')
            if t['enable_pll'] == 'on' and not self.ref_opts.get(tile):
                errors.append(f'Tile{tile}: RFPLL parameters could not be resolved to determine a valid ref. clock freq.')
            for k in enabled:
                if not self.opts[k]['sample_per_cycle']:
                    errors.append(f'Tile{tile} slice {k[3]}: no samples per cycle setting gives an AXI4-Stream clock <= {fmt_num(AXIS_CLK_MAX_MHZ)} MHz')
            if t['axi_stream_clk'] == INVALID_AXIS:
                errors.append(f'Tile{tile}: required AXI4-Stream clock differs between enabled slices ({INVALID_AXIS})')
        # rfdc_mask.m only rejects MTS turned on for 224 (228) while that tile
        # itself is disabled
        for ref in (224, 228):
            if self.tiles[ref]['enable_mts'] == 'on' and self.tiles[ref]['enable'] != 'on':
                errors.append(f'Tile {ref} must be enabled with Multi-Tile Synchronization on when using MTS on '
                              f'{"ADC" if ref == 224 else "DAC"} tiles')
        return errors

    def collect_config(self):
        try:
            with open(self.target_config, 'r', encoding='utf-8') as f:
                config = json.load(f)
        except Exception:
            config = {'parameters': {'name': '', 'fullpath': '', 'tag': 'xps:rfdc'}}
        # "name" is deliberately not read from any widget here (rfdc has no
        # editable Block name field).
        p = config['parameters']
        for tile in ADC_TILES + DAC_TILES:
            t = self.tiles[tile]
            p[f'Tile{tile}_enable'] = t['enable']
            for k, v in t.items():
                if k != 'enable' and f't{tile}_{k}' in self.params:
                    p[f't{tile}_{k}'] = v
        for key, s in self.slices.items():
            kind, tile, DQ, a = key
            for k, v in s.items():
                p[f't{tile}_{DQ}_{kind}{a}_{k}'] = v
        with open(self.target_config, 'w', encoding='utf-8') as f:
            json.dump(config, f, ensure_ascii=False, indent=4)

    # -------------------------------------------------------------------
    # signal handlers
    # -------------------------------------------------------------------
    def on_sample_rate(self, tile):
        t = self.tiles[tile]
        t['sample_rate'] = fmt_num(self._tile_w(tile, 'sample_rate').value())
        if tile in ADC_TILES:
            fs, (fs_min, fs_max) = self._fs(tile), self._adc_fs_limits()
            if fs > fs_max:
                self._status(f'Maximum sample rate for this ADC is {fmt_num(fs_max)} Msps')
            elif fs < fs_min:
                self._status(f'Minimum sample rate for this ADC is {fmt_num(fs_min)} Msps')
        self.update_pll(tile)
        self.update_clkout(tile)
        self.refresh_tile(tile)

    def on_tile_check(self, tile, key, checked):
        self.tiles[tile][key] = 'on' if checked else 'off'
        if key == 'enable_pll':
            self.update_pll(tile)
        if key == 'enable' and tile == 224:
            self.enable_mts_opt()
        self.render_tile(tile)

    def on_tile_combo(self, tile, key):
        self.tiles[tile][key] = self._tile_w(tile, key).currentText()

    def on_output_power(self, tile):
        self.bad_power.discard(tile)
        self.tiles[tile]['output_power'] = str(int(round(self._tile_w(tile, 'output_power').value())))

    def on_slice_changed(self, key, field, w):
        s = self.slices[key]
        if isinstance(w, QCheckBox):
            s['enable'] = 'on' if w.isChecked() else 'off'
        elif isinstance(w, QComboBox):
            s[field] = w.currentText()
        elif isinstance(w, QDoubleSpinBox):
            s[field] = fmt_num(w.value(), 6)
        tile = key[1]
        self.refresh_tile(tile)

    def ButtonOK_clicked(self):
        errors = self.validate()
        if errors:
            for e in errors:
                self.logger.error(e)
            QMessageBox.critical(self.winobj, 'RFDC configuration error', '\n'.join(errors))
            return
        self.collect_config()
        self.winobj.close()

    def ButtonCancel_clicked(self):
        self.winobj.close()

    def setup_signal_functions(self):
        for tile in ADC_TILES + DAC_TILES:
            kind = self._kind(tile)
            self._tile_w(tile, 'sample_rate').editingFinished.connect(lambda tile=tile: self.on_sample_rate(tile))
            getattr(self.ui, f'Tile{tile}_enable').toggled.connect(
                lambda c, tile=tile: self.on_tile_check(tile, 'enable', c))
            hk, sk = ('has_adc_clk', 'adc_clk_src') if kind == 'adc' else ('has_dac_clk', 'dac_clk_src')
            for key in ('enable_mts', 'enable_pll', hk):
                self._tile_w(tile, key).toggled.connect(
                    lambda c, tile=tile, key=key: self.on_tile_check(tile, key, c))
            for key in ('clk_out', 'ref_clk', sk, 'clk_dist'):
                self._tile_w(tile, key).activated.connect(
                    lambda *args, tile=tile, key=key: self.on_tile_combo(tile, key))
            if kind == 'dac':
                self._tile_w(tile, 'output_power').editingFinished.connect(lambda tile=tile: self.on_output_power(tile))
        for key in self._all_slice_keys():
            for field in FIELD_SUFFIXES[key[0]]:
                if field == 'req_axis_clk':
                    continue
                for w in self._slice_ws(*key, field):
                    if isinstance(w, QCheckBox):
                        w.toggled.connect(lambda *args, key=key, field=field, w=w: self.on_slice_changed(key, field, w))
                    elif isinstance(w, QComboBox):
                        w.activated.connect(lambda *args, key=key, field=field, w=w: self.on_slice_changed(key, field, w))
                    elif isinstance(w, QDoubleSpinBox):
                        w.editingFinished.connect(lambda key=key, field=field, w=w: self.on_slice_changed(key, field, w))
        self.ui.ButtonOK.clicked.connect(self.ButtonOK_clicked)
        self.ui.ButtonCANCEL.clicked.connect(self.ButtonCancel_clicked)


if __name__ == "__main__":
    parser = ArgumentParser(description="Usage for RFDC Mask.")
    parser.add_argument('--template', type=str, dest='template', default=None, help='template config file.')
    parser.add_argument('--target', type=str, dest='target', default='rfdc.json', help='target config file.')
    parser.add_argument('-l', '--log', type=str, dest='log', default='.', help='The directory for log files.')
    parser.add_argument('-v', '--verbose', dest='debug', action='store_true', default=False, help='Turn on verbose.')
    opts = parser.parse_args()
    # generate the bconfig file
    gen_bconfig(opts.template, opts.target)

    app = QApplication(sys.argv)
    script_path = os.path.realpath(__file__)
    curdir = os.path.dirname(script_path)
    app.setWindowIcon(QIcon(f"{curdir}/icon/casper_icon.png"))
    win = MainWindow()
    op = RFDCOperations(win, opts.template, opts.target, opts.log, opts.debug)
    win.show()
    sys.exit(app.exec())
