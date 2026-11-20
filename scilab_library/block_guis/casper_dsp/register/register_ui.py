# Form implementation for the Register mask dialog.
# Hand-written to match the layout in ui/register.ui, which follows the
# Simulink "Xilinx Register" dialog (Vivado data/sysgen/xml/register_gui.xml):
# a Basic tab with "Initial value" and the "Optional Ports" group, the same
# prompts in the same order. If PyQt6/pyuic6 is available, regenerate with:
#   pyuic6 ui/register.ui -o register_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(480, 430)
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

        # type of d (Xcos only: Simulink inherits it from the d signal)
        self.type_box = QtWidgets.QGroupBox(parent=self.centralwidget)
        self.type_box.setObjectName("type_box")
        self.typeLayout = QtWidgets.QGridLayout(self.type_box)
        self.typeLayout.setColumnStretch(1, 1)
        self.label_n_bits = QtWidgets.QLabel(parent=self.type_box)
        self.label_n_bits.setObjectName("label_n_bits")
        self.typeLayout.addWidget(self.label_n_bits, 0, 0, 1, 1)
        self.n_bits = QtWidgets.QSpinBox(parent=self.type_box)
        self.n_bits.setObjectName("n_bits")
        self.n_bits.setRange(1, 4096)
        self.typeLayout.addWidget(self.n_bits, 0, 1, 1, 1)
        self.label_arith_type = QtWidgets.QLabel(parent=self.type_box)
        self.label_arith_type.setObjectName("label_arith_type")
        self.typeLayout.addWidget(self.label_arith_type, 1, 0, 1, 1)
        self.arith_type = QtWidgets.QComboBox(parent=self.type_box)
        self.arith_type.setObjectName("arith_type")
        self.arith_type.addItem("")
        self.arith_type.addItem("")
        self.typeLayout.addWidget(self.arith_type, 1, 1, 1, 1)
        self.label_bin_pt = QtWidgets.QLabel(parent=self.type_box)
        self.label_bin_pt.setObjectName("label_bin_pt")
        self.typeLayout.addWidget(self.label_bin_pt, 2, 0, 1, 1)
        self.bin_pt = QtWidgets.QLineEdit(parent=self.type_box)
        self.bin_pt.setObjectName("bin_pt")
        self.typeLayout.addWidget(self.bin_pt, 2, 1, 1, 1)
        self.verticalLayout.addWidget(self.type_box)

        self.tabWidget = QtWidgets.QTabWidget(parent=self.centralwidget)
        self.tabWidget.setObjectName("tabWidget")
        self.basictab = QtWidgets.QWidget()
        self.basictab.setObjectName("basictab")
        self.basicLayout = QtWidgets.QVBoxLayout(self.basictab)
        self.basicLayout.setObjectName("basicLayout")

        # Initial value
        self.initLayout = QtWidgets.QHBoxLayout()
        self.label_init = QtWidgets.QLabel(parent=self.basictab)
        self.label_init.setObjectName("label_init")
        self.initLayout.addWidget(self.label_init)
        self.init = QtWidgets.QLineEdit(parent=self.basictab)
        self.init.setObjectName("init")
        self.initLayout.addWidget(self.init, 1)
        self.basicLayout.addLayout(self.initLayout)

        # Optional Ports
        self.ports_box = QtWidgets.QGroupBox(parent=self.basictab)
        self.ports_box.setObjectName("ports_box")
        self.portsLayout = QtWidgets.QVBoxLayout(self.ports_box)
        self.rst = QtWidgets.QCheckBox(parent=self.ports_box)
        self.rst.setObjectName("rst")
        self.portsLayout.addWidget(self.rst)
        self.en = QtWidgets.QCheckBox(parent=self.ports_box)
        self.en.setObjectName("en")
        self.portsLayout.addWidget(self.en)
        self.basicLayout.addWidget(self.ports_box)
        self.basicLayout.addStretch(1)

        self.tabWidget.addTab(self.basictab, "")
        self.verticalLayout.addWidget(self.tabWidget)

        self.init.setToolTip("A real value: converted to the type of d with Round and Saturate, "
                             "as Simulink does. It is the power-on value of q and the value "
                             "loaded by rst.")
        self.rst.setToolTip("Adds the 'rst' input port: rst = 1 loads the initial value "
                            "(it takes priority over en).")
        self.en.setToolTip("Adds the 'en' input port: en = 0 holds q.")
        self.bin_pt.setToolTip("Binary point of d: 0 .. number of bits.")

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
        MainWindow.setWindowTitle(_translate("MainWindow", "Register"))
        self.title_label.setText(_translate("MainWindow", "Xilinx Register"))
        self.desc_label.setText(_translate("MainWindow", "D flip-flop based register: q follows d after one clock cycle. The optional synchronous reset loads the initial value and the optional enable holds q."))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.type_box.setTitle(_translate("MainWindow", "Type of d (Simulink inherits it from the input)"))
        self.label_n_bits.setText(_translate("MainWindow", "Number of bits"))
        self.label_arith_type.setText(_translate("MainWindow", "Arithmetic type"))
        self.arith_type.setItemText(0, _translate("MainWindow", "Unsigned"))
        self.arith_type.setItemText(1, _translate("MainWindow", "Signed (2's comp)"))
        self.label_bin_pt.setText(_translate("MainWindow", "Binary point"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.basictab), _translate("MainWindow", "Basic"))
        self.label_init.setText(_translate("MainWindow", "Initial value"))
        self.ports_box.setTitle(_translate("MainWindow", "Optional Ports"))
        self.rst.setText(_translate("MainWindow", "Provide synchronous reset port"))
        self.en.setText(_translate("MainWindow", "Provide enable port"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
