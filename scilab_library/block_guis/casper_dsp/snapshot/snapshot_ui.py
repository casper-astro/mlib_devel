# Form implementation for the snapshot mask dialog.
# Hand-written to match the layout in ui/snapshot.ui, which follows the
# casper_library_scopes snapshot mask: the snapshot description, then the
# parameters in one list with the Simulink prompts in the Simulink order (the
# mask has no tabs). provide_outputs is a hidden mask parameter in Simulink
# (Visible off) and has no widget here; the DRAM dimm / clock rows are shown
# only with dram storage (snapshot_callback.m). The din width is an Xcos-only
# field: Simulink inherits it from the din signal.
# If PyQt6/pyuic6 is available, regenerate with:
#   pyuic6 ui/snapshot.ui -o snapshot_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets

STORAGE_ITEMS = ['bram', 'dram']
DRAM_DIMM_ITEMS = ['1', '2', '3', '4']
DRAM_CLOCK_ITEMS = ['200', '250', '266', '300', '333']
DATA_WIDTH_ITEMS = ['8', '16', '32', '64', '128']

DESCRIPTION = (
    "Standard snap block, but with the following optional extras;\n"
    " 1) Optionally delay the fabric trigger by a user-specified number of valids.\n"
    " 2) Capture continuously after a trigger until a stop pulse is received. Data is captured into "
    "BRAM continuously, with old data being overwritten until a stop command is received. Then stop "
    "capturing when memory is filled. This enables you to get some data before and some data after the "
    "stop pulse. Use the 'tr_en_cnt' register to determine where you are in your vector. 'Addr' "
    "register's MSb now indicates 'busy capturing'.\n"
    " 3) Optionally capture a value on an input port to a register at the same time as the first data "
    "sample.\n"
    " 4) Implement counters using DSP48Es to save resources.")

# (key, prompt, widget kind, combo items), in the Simulink order
ROWS = [
    ('storage', 'Storage medium', 'combo', STORAGE_ITEMS),
    ('dram_dimm', 'DRAM dimm', 'combo', DRAM_DIMM_ITEMS),
    ('dram_clock', 'DRAM clock rate', 'combo', DRAM_CLOCK_ITEMS),
    ('nsamples', 'Number of Samples (2^?)', 'edit', None),
    ('data_width', 'Data width', 'combo', DATA_WIDTH_ITEMS),
    ('offset', 'Start delay support', 'check', None),
    ('circap', 'Circular capture support', 'check', None),
    ('value', 'Extra value capture support', 'check', None),
    ('ext_arm', 'External arm support', 'check', None),
    ('ext_circ', 'External circular capture support', 'check', None),
    ('use_dsp48', 'Use DSP48s to implement counters', 'check', None),
]


class Ui_MainWindow(object):
    def _rows(self, parent, layout, rows, first=0):
        for r, (key, prompt, kind, items) in enumerate(rows, first):
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
            elif kind == 'spin':
                w = QtWidgets.QSpinBox(parent=parent)
                w.setRange(*items)
            else:
                w = QtWidgets.QLineEdit(parent=parent)
            w.setObjectName(key)
            layout.addWidget(w, r, 1, 1, 1)
            setattr(self, key, w)
            setattr(self, 'label_' + key, label)

    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(520, 600)
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

        # din width (Xcos only: Simulink inherits it from the din signal)
        self.type_box = QtWidgets.QGroupBox(parent=self.centralwidget)
        self.type_box.setObjectName("type_box")
        self.typeLayout = QtWidgets.QGridLayout(self.type_box)
        self.typeLayout.setColumnStretch(1, 1)
        self._rows(self.type_box, self.typeLayout, [('in_width', 'Input (din) bit width', 'spin', (1, 4096))])
        self.verticalLayout.addWidget(self.type_box)

        self.params_box = QtWidgets.QGroupBox(parent=self.centralwidget)
        self.params_box.setObjectName("params_box")
        self.paramsLayout = QtWidgets.QGridLayout(self.params_box)
        self.paramsLayout.setColumnStretch(1, 1)
        self._rows(self.params_box, self.paramsLayout, ROWS)
        self.paramsLayout.setRowStretch(len(ROWS), 1)
        self.verticalLayout.addWidget(self.params_box, 1)

        self.in_width.setToolTip("din is zero-extended or truncated to the data width.")
        self.storage.setToolTip("Only bram is implemented in casper_dsp snapshot.sv.")
        for key in ('offset', 'circap', 'value', 'ext_arm', 'ext_circ'):
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
        MainWindow.setWindowTitle(_translate("MainWindow", "Block Parameters: snapshot"))
        self.desc_box.setTitle(_translate("MainWindow", "snapshot"))
        self.desc_label.setText(_translate("MainWindow", DESCRIPTION))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.type_box.setTitle(_translate("MainWindow", "Input type -- Simulink inherits it from the din signal"))
        self.params_box.setTitle(_translate("MainWindow", "Parameters"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
