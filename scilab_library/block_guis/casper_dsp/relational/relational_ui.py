# Form implementation for the Relational mask dialog.
# Hand-written to match the layout in ui/relational.ui, which follows the
# Simulink "Xilinx Arithmetic Relational Operator" dialog (Vivado
# data/sysgen/xml/relational_gui.xml): a Basic tab with the Comparison list
# box, the "Output Type" and "Optional Ports" groups and the Latency edit
# box, with the same prompts in the same order. If PyQt6/pyuic6 is
# available, regenerate with:
#   pyuic6 ui/relational.ui -o relational_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


# Simulink list box / radio group contents (relational_gui.xml)
MODE_ITEMS = ['a=b', 'a!=b', 'a<b', 'a>b', 'a<=b', 'a>=b']
# (mask value, label)
OP_TYPE_ITEMS = [('Bool', 'Bool'), ('Ufix', 'Unsigned Fix')]
# arithmetic type of a and b (Xcos only: Simulink inherits it from the inputs)
ARITH_TYPE_ITEMS = ['Unsigned', "Signed (2's comp)"]


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(480, 460)
        self.centralwidget = QtWidgets.QWidget(parent=MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.centralwidget)
        self.verticalLayout.setObjectName("verticalLayout")

        self.title_label = QtWidgets.QLabel(parent=self.centralwidget)
        self.title_label.setObjectName("title_label")
        self.verticalLayout.addWidget(self.title_label)

        self.desc_label = QtWidgets.QLabel(parent=self.centralwidget)
        self.desc_label.setWordWrap(True)
        self.desc_label.setObjectName("desc_label")
        self.verticalLayout.addWidget(self.desc_label)

        # block name and the input type (Xcos only: Simulink takes the name
        # from the diagram and inherits the width / sign from a and b)
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
        self.label_arith_type = QtWidgets.QLabel(parent=self.centralwidget)
        self.label_arith_type.setObjectName("label_arith_type")
        self.headerLayout.addWidget(self.label_arith_type, 2, 0, 1, 1)
        self.arith_type = QtWidgets.QComboBox(parent=self.centralwidget)
        self.arith_type.setObjectName("arith_type")
        self.arith_type.addItems(ARITH_TYPE_ITEMS)
        self.headerLayout.addWidget(self.arith_type, 2, 1, 1, 1)
        self.verticalLayout.addLayout(self.headerLayout)

        self.tabWidget = QtWidgets.QTabWidget(parent=self.centralwidget)
        self.tabWidget.setObjectName("tabWidget")
        self.basictab = QtWidgets.QWidget()
        self.basictab.setObjectName("basictab")
        self.basicLayout = QtWidgets.QVBoxLayout(self.basictab)
        self.basicLayout.setObjectName("basicLayout")

        # Comparison:
        self.modeLayout = QtWidgets.QHBoxLayout()
        self.label_mode = QtWidgets.QLabel(parent=self.basictab)
        self.label_mode.setObjectName("label_mode")
        self.modeLayout.addWidget(self.label_mode)
        self.mode = QtWidgets.QComboBox(parent=self.basictab)
        self.mode.setObjectName("mode")
        self.mode.addItems(MODE_ITEMS)
        self.modeLayout.addWidget(self.mode, 1)
        self.basicLayout.addLayout(self.modeLayout)

        # Output Type
        self.op_type_box = QtWidgets.QGroupBox(parent=self.basictab)
        self.op_type_box.setObjectName("op_type_box")
        self.opTypeBoxLayout = QtWidgets.QVBoxLayout(self.op_type_box)
        self.op_type = QtWidgets.QGroupBox(parent=self.op_type_box)
        self.op_type.setObjectName("op_type")
        self.opTypeLayout = QtWidgets.QHBoxLayout(self.op_type)
        self.op_type_group = QtWidgets.QButtonGroup(self.op_type)
        self.op_type_buttons = {}
        for value, _ in OP_TYPE_ITEMS:
            button = QtWidgets.QRadioButton(parent=self.op_type)
            button.setObjectName('op_type_' + value.lower())
            self.op_type_group.addButton(button)
            self.opTypeLayout.addWidget(button)
            self.op_type_buttons[value] = button
        self.opTypeLayout.addStretch(1)
        self.opTypeBoxLayout.addWidget(self.op_type)
        self.basicLayout.addWidget(self.op_type_box)

        # Optional Ports
        self.ports_box = QtWidgets.QGroupBox(parent=self.basictab)
        self.ports_box.setObjectName("ports_box")
        self.portsLayout = QtWidgets.QVBoxLayout(self.ports_box)
        self.en = QtWidgets.QCheckBox(parent=self.ports_box)
        self.en.setObjectName("en")
        self.portsLayout.addWidget(self.en)
        self.basicLayout.addWidget(self.ports_box)

        # Latency
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
        self.verticalLayout.addWidget(self.tabWidget)

        self.arith_type.setToolTip("Arithmetic type of both a and b (Simulink inherits it from the "
                                   "inputs; here a and b must share one width and one type).")
        self.op_type.setToolTip("Only the Simulink output type (Bool or UFix_1_0); the generated "
                                "hardware is the same 1-bit result.")
        self.en.setToolTip("Adds an 'en' input port: en = 0 holds the latency registers "
                           "(no effect with latency 0).")
        self.latency.setToolTip("Number of register stages on the result, an integer >= 0.")

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
        MainWindow.setWindowTitle(_translate("MainWindow", "Relational"))
        self.title_label.setText(_translate("MainWindow", "Xilinx Arithmetic Relational Operator"))
        self.desc_label.setText(_translate("MainWindow", "Compares a with b and outputs 1 when the selected relation holds, after the given latency."))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.label_n_bits.setText(_translate("MainWindow", "Input width of a and b (bits, Simulink inherits it)"))
        self.label_arith_type.setText(_translate("MainWindow", "Input arithmetic type (Simulink inherits it)"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.basictab), _translate("MainWindow", "Basic"))
        self.label_mode.setText(_translate("MainWindow", "Comparison:"))
        self.op_type_box.setTitle(_translate("MainWindow", "Output Type"))
        self.op_type.setTitle(_translate("MainWindow", "Output Type"))
        for value, label in OP_TYPE_ITEMS:
            self.op_type_buttons[value].setText(_translate("MainWindow", label))
        self.ports_box.setTitle(_translate("MainWindow", "Optional Ports"))
        self.en.setText(_translate("MainWindow", "Provide enable port"))
        self.label_latency.setText(_translate("MainWindow", "Latency"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
