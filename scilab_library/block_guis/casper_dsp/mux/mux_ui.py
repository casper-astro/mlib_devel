# Form implementation for the Mux mask dialog.
# Hand-written to match the layout in ui/mux.ui, which follows the Simulink
# "Xilinx Bus Multiplexer" dialog (Vivado data/sysgen/xml/mux_gui.xml): a
# Basic tab (Number of inputs, Optional Ports, Latency) and an Output tab
# (Precision; only Full is implemented by multiplexer.sv). If PyQt6/pyuic6
# is available, regenerate with:
#   pyuic6 ui/mux.ui -o mux_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


# Simulink list box contents (mux_gui.xml)
INPUTS_ITEMS = [str(i) for i in range(2, 33)]


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(480, 420)
        self.centralwidget = QtWidgets.QWidget(parent=MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.centralwidget)
        self.verticalLayout.setObjectName("verticalLayout")

        self.title_label = QtWidgets.QLabel(parent=self.centralwidget)
        self.title_label.setObjectName("title_label")
        self.verticalLayout.addWidget(self.title_label)

        self.desc_label = QtWidgets.QLabel(parent=self.centralwidget)
        self.desc_label.setWordWrap(True)
        # plain text: "d<i>" must not be read as HTML
        self.desc_label.setTextFormat(QtCore.Qt.TextFormat.PlainText)
        self.desc_label.setObjectName("desc_label")
        self.verticalLayout.addWidget(self.desc_label)

        # block name and the data width (Xcos only: Simulink takes the name
        # from the diagram and inherits the width from the data inputs)
        self.headerLayout = QtWidgets.QGridLayout()
        self.headerLayout.setObjectName("headerLayout")
        self.headerLayout.setColumnStretch(1, 1)
        self.label_name = QtWidgets.QLabel(parent=self.centralwidget)
        self.label_name.setObjectName("label_name")
        self.headerLayout.addWidget(self.label_name, 0, 0, 1, 1)
        self.name = QtWidgets.QLineEdit(parent=self.centralwidget)
        self.name.setObjectName("name")
        self.headerLayout.addWidget(self.name, 0, 1, 1, 1)
        self.label_n_bits = QtWidgets.QLabel(parent=self.centralwidget)
        self.label_n_bits.setObjectName("label_n_bits")
        self.headerLayout.addWidget(self.label_n_bits, 1, 0, 1, 1)
        self.n_bits = QtWidgets.QSpinBox(parent=self.centralwidget)
        self.n_bits.setObjectName("n_bits")
        self.n_bits.setRange(1, 4096)
        self.headerLayout.addWidget(self.n_bits, 1, 1, 1, 1)
        self.verticalLayout.addLayout(self.headerLayout)

        self.tabWidget = QtWidgets.QTabWidget(parent=self.centralwidget)
        self.tabWidget.setObjectName("tabWidget")

        # Basic tab
        self.basictab = QtWidgets.QWidget()
        self.basictab.setObjectName("basictab")
        self.basicLayout = QtWidgets.QVBoxLayout(self.basictab)
        self.basicLayout.setObjectName("basicLayout")
        self.inputsLayout = QtWidgets.QHBoxLayout()
        self.label_inputs = QtWidgets.QLabel(parent=self.basictab)
        self.label_inputs.setObjectName("label_inputs")
        self.inputsLayout.addWidget(self.label_inputs)
        self.inputs = QtWidgets.QComboBox(parent=self.basictab)
        self.inputs.setObjectName("inputs")
        self.inputs.addItems(INPUTS_ITEMS)
        self.inputsLayout.addWidget(self.inputs, 1)
        self.basicLayout.addLayout(self.inputsLayout)
        self.oportetch = QtWidgets.QGroupBox(parent=self.basictab)
        self.oportetch.setObjectName("oportetch")
        self.oportLayout = QtWidgets.QVBoxLayout(self.oportetch)
        self.en = QtWidgets.QCheckBox(parent=self.oportetch)
        self.en.setObjectName("en")
        self.oportLayout.addWidget(self.en)
        self.basicLayout.addWidget(self.oportetch)
        self.latencyLayout = QtWidgets.QHBoxLayout()
        self.label_latency = QtWidgets.QLabel(parent=self.basictab)
        self.label_latency.setObjectName("label_latency")
        self.latencyLayout.addWidget(self.label_latency)
        self.latency = QtWidgets.QLineEdit(parent=self.basictab)
        self.latency.setObjectName("latency")
        self.latencyLayout.addWidget(self.latency, 1)
        self.basicLayout.addLayout(self.latencyLayout)
        self.basicLayout.addStretch(1)
        self.tabWidget.addTab(self.basictab, "")

        # Output tab: Simulink's Precision radio group; only Full is
        # implemented, so User defined (and its output type fields) is not
        # offered
        self.otype = QtWidgets.QWidget()
        self.otype.setObjectName("otype")
        self.otypeLayout = QtWidgets.QVBoxLayout(self.otype)
        self.precision = QtWidgets.QGroupBox(parent=self.otype)
        self.precision.setObjectName("precision")
        self.precisionLayout = QtWidgets.QHBoxLayout(self.precision)
        self.precision_full = QtWidgets.QRadioButton(parent=self.precision)
        self.precision_full.setObjectName("precision_full")
        self.precision_full.setChecked(True)
        self.precisionLayout.addWidget(self.precision_full)
        self.precision_user = QtWidgets.QRadioButton(parent=self.precision)
        self.precision_user.setObjectName("precision_user")
        self.precision_user.setEnabled(False)
        self.precisionLayout.addWidget(self.precision_user)
        self.precisionLayout.addStretch(1)
        self.otypeLayout.addWidget(self.precision)
        self.precision_note = QtWidgets.QLabel(parent=self.otype)
        self.precision_note.setObjectName("precision_note")
        self.precision_note.setWordWrap(True)
        self.otypeLayout.addWidget(self.precision_note)
        self.otypeLayout.addStretch(1)
        self.tabWidget.addTab(self.otype, "")
        self.verticalLayout.addWidget(self.tabWidget)

        self.inputs.setToolTip("Number of data inputs d0..d{N-1}; sel = i selects d{i}. "
                               "sel is ceil(log2(N)) bits wide.")
        self.en.setToolTip("Adds an 'en' input port: en = 0 holds the output register "
                           "(no effect when Latency is 0).")
        self.latency.setToolTip("Output register stages, an integer >= 0 (0 = combinational).")
        self.precision_user.setToolTip("Not supported: multiplexer.sv implements Full precision only.")

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
        MainWindow.setWindowTitle(_translate("MainWindow", "Mux"))
        self.title_label.setText(_translate("MainWindow", "Xilinx Bus Multiplexer"))
        self.desc_label.setText(_translate("MainWindow", "Multiplexes the data inputs d0..d{N-1} onto the output: sel = i passes d{i}. All data inputs share one width; the output has the same width (Full precision)."))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.label_n_bits.setText(_translate("MainWindow", "Data width (bits, Simulink inherits it)"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.basictab), _translate("MainWindow", "Basic"))
        self.label_inputs.setText(_translate("MainWindow", "Number of inputs"))
        self.oportetch.setTitle(_translate("MainWindow", "Optional Ports"))
        self.en.setText(_translate("MainWindow", "Provide enable port"))
        self.label_latency.setText(_translate("MainWindow", "Latency"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.otype), _translate("MainWindow", "Output"))
        self.precision.setTitle(_translate("MainWindow", "Precision"))
        self.precision_full.setText(_translate("MainWindow", "Full"))
        self.precision_user.setText(_translate("MainWindow", "User defined"))
        self.precision_note.setText(_translate("MainWindow", "Only Full precision is supported: the output has the data width of the inputs."))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
