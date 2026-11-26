"""
Oscilloscope-style viewer for the CASPER simulation data, built on PyQt6 +
pyqtgraph: started by CasperScope.ShowSimData (sim_blocks/sim_block.py)
with the casper_simulation.json the simulation wrote.

    python sim_scope.py -f <builddir>/simulation/casper_simulation.json

Each channel is one scope block's signal, sampled once per clock cycle on
the rising edge of user_clk (see scope_gui/data.py), shown as an unsigned
number for now.
"""
import os
import sys
from argparse import ArgumentParser

import numpy as np
import pyqtgraph as pg
from PyQt6 import QtCore, QtGui, QtWidgets

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from scope_gui import data
from scope_gui.channel_panel import ChannelPanel
from scope_gui.plot_area import PlotArea


def channel_color(i):
    return pg.intColor(i, hues=9, values=1, maxValue=255, minValue=200, sat=200)


def value_at(sig, vals, t):
    """The sample shown at time t: the last rising edge at or before t."""
    i = np.searchsorted(sig.t, t, side='right') - 1
    if i < 0:
        return np.nan
    return vals[i]


def fmt_value(v):
    if v is None or np.isnan(v):
        return 'x'
    return '%d' % v if float(v).is_integer() else '%g' % v


class ScopeWindow(QtWidgets.QMainWindow):
    def __init__(self, filename):
        super().__init__()
        self.filename = os.path.abspath(filename)
        self.signals = []
        self.setWindowTitle('CASPER Scope - %s' % os.path.basename(os.path.dirname(os.path.dirname(self.filename))))
        self.resize(1200, 720)
        icon = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'block_guis',
                            'casper_xps', 'swreg', 'icon', 'casper_icon.png')
        if os.path.isfile(icon):
            self.setWindowIcon(QtGui.QIcon(icon))

        # top bar: file name + reload
        self.file_label = QtWidgets.QLabel(self.filename)
        self.file_label.setTextInteractionFlags(QtCore.Qt.TextInteractionFlag.TextSelectableByMouse)
        reload_btn = QtWidgets.QPushButton('Reload')
        reload_btn.setToolTip('Read the file again, e.g. after running the simulation again')
        reload_btn.clicked.connect(self.reload)
        fit_btn = QtWidgets.QPushButton('View All')
        fit_btn.clicked.connect(self.view_all)
        top = QtWidgets.QHBoxLayout()
        top.addWidget(QtWidgets.QLabel('File:'))
        top.addWidget(self.file_label, 1)
        top.addWidget(fit_btn)
        top.addWidget(reload_btn)

        self.panel = ChannelPanel()
        self.panel.changed.connect(self.redraw)
        self.plot = PlotArea()
        self.plot.cursors_moved.connect(self.update_readout)

        # cursor readout under the plot
        self.cursor_label = QtWidgets.QLabel()
        self.readout = QtWidgets.QTableWidget(0, 4)
        self.readout.setHorizontalHeaderLabels(['Channel', 'A', 'B', 'B - A'])
        self.readout.verticalHeader().setVisible(False)
        self.readout.setEditTriggers(QtWidgets.QAbstractItemView.EditTrigger.NoEditTriggers)
        self.readout.horizontalHeader().setSectionResizeMode(QtWidgets.QHeaderView.ResizeMode.Stretch)
        self.readout.setMaximumHeight(160)
        right = QtWidgets.QWidget()
        rl = QtWidgets.QVBoxLayout(right)
        rl.setContentsMargins(0, 0, 0, 0)
        rl.addWidget(self.plot, 1)
        rl.addWidget(self.cursor_label)
        rl.addWidget(self.readout)

        split = QtWidgets.QSplitter()
        split.addWidget(self.panel)
        split.addWidget(right)
        split.setStretchFactor(1, 1)
        split.setSizes([280, 920])

        central = QtWidgets.QWidget()
        cl = QtWidgets.QVBoxLayout(central)
        cl.addLayout(top)
        cl.addWidget(split, 1)
        self.setCentralWidget(central)
        self.reload()

    def reload(self):
        try:
            self.signals = data.load(self.filename)
        except (OSError, ValueError, KeyError) as e:
            QtWidgets.QMessageBox.critical(self, 'CASPER Scope', 'Cannot read %s:\n%s' % (self.filename, e))
            self.signals = []
        colors = [channel_color(i) for i in range(len(self.signals))]
        self.panel.set_channels(self.signals, colors)
        self.redraw()

    def _visible(self):
        out = []
        for r in self.panel.visible_rows():
            sig = self.signals[r]
            out.append((sig, sig.values(self.panel.row_format(r)), channel_color(r)))
        return out

    def redraw(self):
        self.plot.show_channels(self._visible(), self.panel.overlay())

    def view_all(self):
        for p in self.plot._plots:
            p.enableAutoRange()

    def update_readout(self, pos):
        a, b = pos['A'], pos['B']
        if a is None or b is None:
            self.cursor_label.setText('')
            self.readout.setRowCount(0)
            return
        dt = b - a
        freq = ('%.4g MHz' % (1e3 / abs(dt))) if dt else '-'
        self.cursor_label.setText('A: %.3f ns    B: %.3f ns    \u0394T = %.3f ns    1/\u0394T = %s'
                                  % (a, b, dt, freq))
        chans = self._visible()
        self.readout.setRowCount(len(chans))
        for r, (sig, vals, color) in enumerate(chans):
            va, vb = value_at(sig, vals, a), value_at(sig, vals, b)
            name = QtWidgets.QTableWidgetItem(sig.name)
            name.setForeground(QtGui.QBrush(color))
            self.readout.setItem(r, 0, name)
            self.readout.setItem(r, 1, QtWidgets.QTableWidgetItem(fmt_value(va)))
            self.readout.setItem(r, 2, QtWidgets.QTableWidgetItem(fmt_value(vb)))
            self.readout.setItem(r, 3, QtWidgets.QTableWidgetItem(fmt_value(vb - va)))


def main():
    parser = ArgumentParser(prog=os.path.basename(__file__))
    parser.add_argument('-f', '--file', dest='file', type=str, default='casper_simulation.json',
                        help='The simulation data file (casper_simulation.json).')
    args = parser.parse_args()
    app = QtWidgets.QApplication(sys.argv)
    pg.setConfigOptions(antialias=True)
    win = ScopeWindow(args.file)
    win.show()
    sys.exit(app.exec())


if __name__ == '__main__':
    main()
