"""
The waveform area of the scope window (pyqtgraph): the channels drawn as
step traces, either all on one plot (overlay) or one plot per channel with
a shared sample axis (split), plus two movable cursors A and B, which
snap to whole samples.

Mouse: wheel zooms, drag pans, right click -> View All; drag a cursor line
to move it.
"""
import numpy as np
import pyqtgraph as pg
from PyQt6 import QtCore

CURSOR_PENS = {'A': pg.mkPen('#FFD400', width=1, style=QtCore.Qt.PenStyle.DashLine),
               'B': pg.mkPen('#00E5FF', width=1, style=QtCore.Qt.PenStyle.DashLine)}


class PlotArea(pg.GraphicsLayoutWidget):
    # emitted with {'A': t, 'B': t} whenever a cursor moves
    cursors_moved = QtCore.pyqtSignal(dict)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setBackground('k')
        self.cursor_pos = {'A': None, 'B': None}
        self._plots = []
        self._lines = []   # (name, InfiniteLine)
        self._syncing = False

    def show_channels(self, channels, overlay):
        """channels: list of (Signal, values, QColor). Redraws everything."""
        self.clear()
        self._plots = []
        self._lines = []
        if not channels:
            return
        n_min = min(sig.n[0] for sig, _, _ in channels if len(sig.n))
        n_max = max(sig.n[-1] for sig, _, _ in channels if len(sig.n))
        for name in ('A', 'B'):
            if self.cursor_pos[name] is None or not n_min <= self.cursor_pos[name] <= n_max:
                frac = 0.25 if name == 'A' else 0.75
                self.cursor_pos[name] = float(round(n_min + frac * (n_max - n_min)))
        if overlay:
            plot = self._new_plot(None)
            plot.addLegend(offset=(10, 10))
            for sig, vals, color in channels:
                self._add_trace(plot, sig, vals, color, sig.name)
            plot.setLabel('bottom', 'Samples')
        else:
            for i, (sig, vals, color) in enumerate(channels):
                plot = self._new_plot(self._plots[0] if self._plots else None)
                self._add_trace(plot, sig, vals, color, None)
                plot.setLabel('left', sig.name, color=color.name())
                if i < len(channels) - 1:
                    plot.getAxis('bottom').setStyle(showValues=False)
                else:
                    plot.setLabel('bottom', 'Samples')
                self.nextRow()
        for plot in self._plots:
            plot.setXRange(n_min, n_max + 1, padding=0.02)
            for name in ('A', 'B'):
                line = pg.InfiniteLine(pos=self.cursor_pos[name], angle=90, movable=True,
                                       pen=CURSOR_PENS[name], label=name,
                                       labelOpts={'position': 0.95, 'color': CURSOR_PENS[name].color()})
                line.sigPositionChanged.connect(lambda l, n=name: self._cursor_dragged(n, l))
                plot.addItem(line)
                self._lines.append((name, line))
        self.cursors_moved.emit(dict(self.cursor_pos))

    def _new_plot(self, xlink):
        plot = self.addPlot()
        plot.showGrid(x=True, y=True, alpha=0.3)
        # show the values as they are, e.g. 0.5, not 500 with a 'x0.001'
        # SI prefix on the axis label
        plot.getAxis('left').enableAutoSIPrefix(False)
        plot.getAxis('bottom').enableAutoSIPrefix(False)
        plot.setMouseEnabled(x=True, y=True)
        if xlink is not None:
            plot.setXLink(xlink)
        self._plots.append(plot)
        return plot

    @staticmethod
    def _add_trace(plot, sig, vals, color, name):
        # sample k is held from k to k + 1: a step trace; stepMode 'center'
        # wants one more x than y. NaN (x / z) leaves a gap.
        edges = np.append(sig.n, sig.n[-1] + 1.0) if len(sig.n) else sig.n
        plot.plot(edges, vals, stepMode='center', pen=pg.mkPen(color, width=1.5),
                  name=name, connect='finite')

    def _cursor_dragged(self, name, line):
        if self._syncing:
            return
        self._syncing = True
        # snap to the start of a sample
        pos = float(round(line.value()))
        if pos != line.value():
            self._syncing = False
            line.setValue(pos)   # re-enters with the snapped value
            return
        self.cursor_pos[name] = pos
        for n, other in self._lines:
            if n == name and other is not line:
                other.setValue(pos)
        self._syncing = False
        self.cursors_moved.emit(dict(self.cursor_pos))
