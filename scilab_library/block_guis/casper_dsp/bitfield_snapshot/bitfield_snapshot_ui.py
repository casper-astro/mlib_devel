# Form implementation for the bitfield_snapshot (bitsnap) mask dialog.
# Hand-written to match the layout in ui/bitfield_snapshot.ui, which follows
# the casper_library_scopes bitfield_snapshot mask: the bitsnap description,
# then the tabs Inputs, Snapshot and Extra Value with the Simulink prompts in
# the Simulink order. snap_provide_outputs is a hidden mask parameter in
# Simulink (Visible off) and has no widget here; the DRAM dimm / clock rows
# are shown only with dram storage (bitsnap_callback.m).
# If PyQt6/pyuic6 is available, regenerate with:
#   pyuic6 ui/bitfield_snapshot.ui -o bitfield_snapshot_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets

STORAGE_ITEMS = ['bram', 'dram']
DRAM_DIMM_ITEMS = ['1', '2', '3', '4']
DRAM_CLOCK_ITEMS = ['200', '250', '266', '300', '333']
DATA_WIDTH_ITEMS = ['8', '16', '32', '64', '128']

DESCRIPTION = ("A wrapped snapshot block. Allows specification of inputs to a snapblock word so the "
               "toolflow can automatically set up the scope.\n"
               "See documentation for snapshot for explanation of parameters.")

# (key, prompt, widget kind, combo items) per tab, in the Simulink order
INPUTS_ROWS = [
    ('io_names', 'Names [msb...lsb]', 'edit', None),
    ('io_widths', 'Bitwidths [msb...lsb]', 'edit', None),
    ('io_bps', 'Binary pts [msb...lsb]', 'edit', None),
    ('io_types', 'Data types [msb...lsb], ufix=0, fix=1, bool=2', 'edit', None),
    ('show_format', 'Print format string?', 'check', None),
]
SNAPSHOT_ROWS = [
    ('snap_storage', 'Storage medium', 'combo', STORAGE_ITEMS),
    ('snap_dram_dimm', 'DRAM dimm', 'combo', DRAM_DIMM_ITEMS),
    ('snap_dram_clock', 'DRAM clock rate', 'combo', DRAM_CLOCK_ITEMS),
    ('snap_nsamples', 'Number of Samples (2^?)', 'edit', None),
    ('snap_data_width', 'Data width', 'combo', DATA_WIDTH_ITEMS),
    ('snap_offset', 'Start delay support ', 'check', None),
    ('snap_circap', 'Circular capture support', 'check', None),
    ('snap_value', 'Extra value capture support', 'check', None),
    ('snap_ext_arm', 'External arm support', 'check', None),
    ('snap_ext_circ', 'External circular capture support', 'check', None),
    ('snap_use_dsp48', 'Use DSP48s to implement counters', 'check', None),
    ('snap_delay', 'Pre-snapshot delay', 'edit', None),
]
EXTRA_ROWS = [
    ('extra_names', 'Names [msb...lsb]', 'edit', None),
    ('extra_widths', 'Widths [msb...lsb]', 'edit', None),
    ('extra_bps', 'Binary pts [msb...lsb]', 'edit', None),
    ('extra_types', 'Data types [msb...lsb], ufix=0, fix=1, bool=2', 'edit', None),
]
TABS = [('inputs_tab', 'Inputs', INPUTS_ROWS), ('snapshot_tab', 'Snapshot', SNAPSHOT_ROWS),
        ('extra_tab', 'Extra Value', EXTRA_ROWS)]


class Ui_MainWindow(object):
    def _rows(self, parent, rows):
        layout = QtWidgets.QGridLayout(parent)
        layout.setColumnStretch(1, 1)
        for r, (key, prompt, kind, items) in enumerate(rows):
            if kind == 'check':
                # Simulink check boxes carry their prompt on the right
                w = QtWidgets.QCheckBox(parent=parent)
                w.setObjectName(key)
                w.setText(prompt)
                layout.addWidget(w, r, 0, 1, 2)
                setattr(self, key, w)
                continue
            label = QtWidgets.QLabel(parent=parent)
            label.setObjectName('label_' + key)
            label.setText(prompt)
            layout.addWidget(label, r, 0, 1, 1)
            if kind == 'combo':
                w = QtWidgets.QComboBox(parent=parent)
                w.addItems(items)
            else:
                w = QtWidgets.QLineEdit(parent=parent)
            w.setObjectName(key)
            layout.addWidget(w, r, 1, 1, 1)
            setattr(self, key, w)
            setattr(self, 'label_' + key, label)
        layout.setRowStretch(len(rows), 1)
        return layout

    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(520, 560)
        self.centralwidget = QtWidgets.QWidget(parent=MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.centralwidget)
        self.verticalLayout.setObjectName("verticalLayout")

        # mask type and description (Simulink's description group)
        self.desc_box = QtWidgets.QGroupBox(parent=self.centralwidget)
        self.desc_box.setObjectName("desc_box")
        self.descLayout = QtWidgets.QVBoxLayout(self.desc_box)
        self.desc_label = QtWidgets.QLabel(parent=self.desc_box)
        self.desc_label.setWordWrap(True)
        self.desc_label.setTextFormat(QtCore.Qt.TextFormat.PlainText)
        self.desc_label.setObjectName("desc_label")
        self.descLayout.addWidget(self.desc_label)
        self.verticalLayout.addWidget(self.desc_box)

        # block name (Xcos only: Simulink takes it from the diagram)
        self.headerLayout = QtWidgets.QGridLayout()
        self.headerLayout.setObjectName("headerLayout")
        self.headerLayout.setColumnStretch(1, 1)
        self.label_name = QtWidgets.QLabel(parent=self.centralwidget)
        self.label_name.setObjectName("label_name")
        self.headerLayout.addWidget(self.label_name, 0, 0, 1, 1)
        self.name = QtWidgets.QLineEdit(parent=self.centralwidget)
        self.name.setObjectName("name")
        self.headerLayout.addWidget(self.name, 0, 1, 1, 1)
        self.verticalLayout.addLayout(self.headerLayout)

        self.tabWidget = QtWidgets.QTabWidget(parent=self.centralwidget)
        self.tabWidget.setObjectName("tabWidget")
        for tab_name, title, rows in TABS:
            tab = QtWidgets.QWidget()
            tab.setObjectName(tab_name)
            self._rows(tab, rows)
            self.tabWidget.addTab(tab, title)
            setattr(self, tab_name, tab)
        self.verticalLayout.addWidget(self.tabWidget, 1)

        self.io_names.setToolTip("One io field only: the casper_dsp HDL takes a single field, e.g. [d].")
        self.snap_storage.setToolTip("Only bram is implemented in casper_dsp snapshot.sv.")
        for key in ('snap_offset', 'snap_circap', 'snap_value', 'snap_ext_arm', 'snap_ext_circ'):
            getattr(self, key).setToolTip("Not implemented in casper_dsp snapshot.sv: must be off.")

        self.buttonLayout = QtWidgets.QHBoxLayout()
        self.buttonLayout.setObjectName("buttonLayout")
        spacerItem = QtWidgets.QSpacerItem(
            40, 20, QtWidgets.QSizePolicy.Policy.Expanding, QtWidgets.QSizePolicy.Policy.Minimum
        )
        self.buttonLayout.addItem(spacerItem)
        self.button_apply = QtWidgets.QPushButton(parent=self.centralwidget)
        self.button_apply.setObjectName("button_apply")
        self.buttonLayout.addWidget(self.button_apply)
        self.button_ok = QtWidgets.QPushButton(parent=self.centralwidget)
        self.button_ok.setObjectName("button_ok")
        self.buttonLayout.addWidget(self.button_ok)
        self.button_cancel = QtWidgets.QPushButton(parent=self.centralwidget)
        self.button_cancel.setObjectName("button_cancel")
        self.buttonLayout.addWidget(self.button_cancel)
        self.verticalLayout.addLayout(self.buttonLayout)

        MainWindow.setCentralWidget(self.centralwidget)
        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Block Parameters: bitfield_snapshot"))
        self.desc_box.setTitle(_translate("MainWindow", "bitsnap"))
        self.desc_label.setText(_translate("MainWindow", DESCRIPTION))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
