"""
The channel list on the left of the scope window: one row per signal with
a show/hide checkbox, its trace color, name, width and number format.
"""
from PyQt6 import QtCore, QtGui, QtWidgets

FORMATS = ['unsigned']  # signed / fixed point come with the scope block's dtype


class ChannelPanel(QtWidgets.QWidget):
    # emitted whenever a channel is shown / hidden or its format changes
    changed = QtCore.pyqtSignal()

    COL_SHOW, COL_NAME, COL_WIDTH, COL_FORMAT = range(4)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.table = QtWidgets.QTableWidget(0, 4, self)
        self.table.setHorizontalHeaderLabels(['', 'Channel', 'Bits', 'Format'])
        self.table.verticalHeader().setVisible(False)
        self.table.setSelectionMode(QtWidgets.QAbstractItemView.SelectionMode.NoSelection)
        self.table.setEditTriggers(QtWidgets.QAbstractItemView.EditTrigger.NoEditTriggers)
        hdr = self.table.horizontalHeader()
        hdr.setSectionResizeMode(self.COL_SHOW, QtWidgets.QHeaderView.ResizeMode.ResizeToContents)
        hdr.setSectionResizeMode(self.COL_NAME, QtWidgets.QHeaderView.ResizeMode.Stretch)
        hdr.setSectionResizeMode(self.COL_WIDTH, QtWidgets.QHeaderView.ResizeMode.ResizeToContents)
        hdr.setSectionResizeMode(self.COL_FORMAT, QtWidgets.QHeaderView.ResizeMode.ResizeToContents)
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
        self._formats = []

    def set_channels(self, signals, colors):
        """Fill the table; keeps the checked state of channels with the same
        name as before (so a reload keeps the selection)."""
        shown = {self.table.item(r, self.COL_NAME).text(): self._checked(r)
                 for r in range(self.table.rowCount())}
        self.table.blockSignals(True)
        self.table.setRowCount(len(signals))
        self._colors = list(colors)
        self._formats = []
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
            fmt = QtWidgets.QComboBox()
            fmt.addItems(FORMATS)
            fmt.setEnabled(len(FORMATS) > 1)
            fmt.currentIndexChanged.connect(lambda _: self.changed.emit())
            self.table.setCellWidget(r, self.COL_FORMAT, fmt)
            self._formats.append(fmt)
        self.table.blockSignals(False)

    def visible_rows(self):
        return [r for r in range(self.table.rowCount()) if self._checked(r)]

    def row_format(self, row):
        return self._formats[row].currentText()

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
