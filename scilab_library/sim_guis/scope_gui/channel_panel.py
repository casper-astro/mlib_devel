"""
The channel list on the left of the scope window: one row per signal with
a show/hide checkbox, its trace color, name, width and number format
(arithmetic type and binary point). The format starts as set on the scope
block and can be changed here for viewing.
"""
from PyQt6 import QtCore, QtGui, QtWidgets

ARITH_TYPES = ['Unsigned', 'Signed']


class ChannelPanel(QtWidgets.QWidget):
    # emitted whenever a channel is shown / hidden or its format changes
    changed = QtCore.pyqtSignal()

    COL_SHOW, COL_NAME, COL_WIDTH, COL_TYPE, COL_BINPT = range(5)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.table = QtWidgets.QTableWidget(0, 5, self)
        self.table.setHorizontalHeaderLabels(['', 'Channel', 'Bits', 'Type', 'Bin pt'])
        self.table.verticalHeader().setVisible(False)
        self.table.setSelectionMode(QtWidgets.QAbstractItemView.SelectionMode.NoSelection)
        self.table.setEditTriggers(QtWidgets.QAbstractItemView.EditTrigger.NoEditTriggers)
        hdr = self.table.horizontalHeader()
        hdr.setSectionResizeMode(self.COL_SHOW, QtWidgets.QHeaderView.ResizeMode.ResizeToContents)
        hdr.setSectionResizeMode(self.COL_NAME, QtWidgets.QHeaderView.ResizeMode.Stretch)
        hdr.setSectionResizeMode(self.COL_WIDTH, QtWidgets.QHeaderView.ResizeMode.ResizeToContents)
        hdr.setSectionResizeMode(self.COL_TYPE, QtWidgets.QHeaderView.ResizeMode.ResizeToContents)
        hdr.setSectionResizeMode(self.COL_BINPT, QtWidgets.QHeaderView.ResizeMode.ResizeToContents)
        self.table.itemChanged.connect(self._item_changed)

        self.mode = QtWidgets.QComboBox(self)
        self.mode.addItems(['Overlay', 'Split'])
        self.mode.setToolTip('Overlay: all channels on one plot; '
                             'Split: one plot per channel, with a shared time axis')
        self.mode.currentIndexChanged.connect(lambda _: self.changed.emit())

        form = QtWidgets.QFormLayout()
        form.addRow('Display', self.mode)
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.addWidget(self.table)
        layout.addLayout(form)
        self._colors = []
        self._types = []
        self._binpts = []

    def set_channels(self, signals, colors):
        """Fill the table; keeps the checked state of channels with the same
        name as before (so a reload keeps the selection)."""
        shown = {self.table.item(r, self.COL_NAME).text(): self._checked(r)
                 for r in range(self.table.rowCount())}
        self.table.blockSignals(True)
        self.table.setRowCount(len(signals))
        self._colors = list(colors)
        self._types = []
        self._binpts = []
        for r, (sig, color) in enumerate(zip(signals, colors)):
            show = QtWidgets.QTableWidgetItem()
            show.setFlags(QtCore.Qt.ItemFlag.ItemIsUserCheckable | QtCore.Qt.ItemFlag.ItemIsEnabled)
            show.setCheckState(QtCore.Qt.CheckState.Checked if shown.get(sig.name, True)
                               else QtCore.Qt.CheckState.Unchecked)
            self.table.setItem(r, self.COL_SHOW, show)
            name = QtWidgets.QTableWidgetItem(sig.name)
            name.setForeground(QtGui.QBrush(color))
            name.setIcon(self._swatch(color))
            self.table.setItem(r, self.COL_NAME, name)
            self.table.setItem(r, self.COL_WIDTH, QtWidgets.QTableWidgetItem(str(sig.width)))
            arith = QtWidgets.QComboBox()
            arith.addItems(ARITH_TYPES)
            arith.setCurrentText(sig.arith_type.capitalize())
            arith.currentIndexChanged.connect(lambda _: self.changed.emit())
            self.table.setCellWidget(r, self.COL_TYPE, arith)
            self._types.append(arith)
            binpt = QtWidgets.QSpinBox()
            binpt.setRange(0, 4096)
            binpt.setValue(sig.bin_pt)
            binpt.valueChanged.connect(lambda _: self.changed.emit())
            self.table.setCellWidget(r, self.COL_BINPT, binpt)
            self._binpts.append(binpt)
        self.table.blockSignals(False)

    def visible_rows(self):
        return [r for r in range(self.table.rowCount()) if self._checked(r)]

    def row_format(self, row):
        """(arith_type, bin_pt) chosen for the row, as Signal.values takes them."""
        return self._types[row].currentText().lower(), self._binpts[row].value()

    def overlay(self):
        return self.mode.currentText() == 'Overlay'

    def _checked(self, row):
        return self.table.item(row, self.COL_SHOW).checkState() == QtCore.Qt.CheckState.Checked

    def _item_changed(self, item):
        if item.column() == self.COL_SHOW:
            self.changed.emit()

    @staticmethod
    def _swatch(color):
        pix = QtGui.QPixmap(12, 12)
        pix.fill(color)
        return QtGui.QIcon(pix)
