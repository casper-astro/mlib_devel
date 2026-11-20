# Form implementation for the Logical mask dialog.
# Hand-written to match the layout in ui/logical.ui (same structure as
# block_guis/casper_dsp/counter/counter_ui.py) -- if PyQt6/pyuic6 is
# available, regenerate with:
#   pyuic6 ui/logical.ui -o logical_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(669, 420)
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

        self.scrollArea = QtWidgets.QScrollArea(parent=self.centralwidget)
        self.scrollArea.setWidgetResizable(True)
        self.scrollArea.setObjectName("scrollArea")
        self.scrollAreaWidgetContents = QtWidgets.QWidget()
        self.scrollAreaWidgetContents.setObjectName("scrollAreaWidgetContents")
        self.gridLayout = QtWidgets.QGridLayout(self.scrollAreaWidgetContents)
        self.gridLayout.setObjectName("gridLayout")
        self.gridLayout.setColumnStretch(1, 1)
        self.label_name = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_name.setObjectName("label_name")
        self.label_name.setWordWrap(True)
        self.label_name.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_name, 0, 0, 1, 1)
        self.name = QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents)
        self.name.setObjectName("name")
        self.gridLayout.addWidget(self.name, 0, 1, 1, 2)
        self.label_logical_function = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_logical_function.setObjectName("label_logical_function")
        self.label_logical_function.setWordWrap(True)
        self.label_logical_function.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_logical_function, 1, 0, 1, 1)
        self.logical_function = QtWidgets.QComboBox(parent=self.scrollAreaWidgetContents)
        self.logical_function.setObjectName("logical_function")
        for _ in range(6):
            self.logical_function.addItem("")
        self.logical_function.setToolTip("Bitwise function applied across all inputs "
                                         "(NAND/NOR/XNOR invert the AND/OR/XOR result).")
        self.gridLayout.addWidget(self.logical_function, 1, 1, 1, 2)
        self.label_inputs = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_inputs.setObjectName("label_inputs")
        self.label_inputs.setWordWrap(True)
        self.label_inputs.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_inputs, 2, 0, 1, 1)
        self.inputs = QtWidgets.QSpinBox(parent=self.scrollAreaWidgetContents)
        self.inputs.setObjectName("inputs")
        self.inputs.setRange(2, 1024)
        self.inputs.setToolTip("Number of data inputs d0..d{N-1} (2 - 1024). Simulink's "
                               "1-input logical reduction is not supported.")
        self.gridLayout.addWidget(self.inputs, 2, 1, 1, 2)
        self.label_en = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_en.setObjectName("label_en")
        self.label_en.setWordWrap(True)
        self.label_en.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_en, 3, 0, 1, 1)
        self.en = QtWidgets.QCheckBox(parent=self.scrollAreaWidgetContents)
        self.en.setObjectName("en")
        self.en.setToolTip("Adds a 1-bit 'en' input port (the last input): en = 0 holds "
                           "the output registers. As in Simulink the port also exists "
                           "with Latency 0, where it has no effect.")
        self.gridLayout.addWidget(self.en, 3, 1, 1, 2)
        self.label_latency = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_latency.setObjectName("label_latency")
        self.label_latency.setWordWrap(True)
        self.label_latency.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_latency, 4, 0, 1, 1)
        self.latency = QtWidgets.QSpinBox(parent=self.scrollAreaWidgetContents)
        self.latency.setObjectName("latency")
        self.latency.setRange(0, 4096)
        self.latency.setToolTip("Output delay in clock cycles; 0 gives a combinational output.")
        self.gridLayout.addWidget(self.latency, 4, 1, 1, 2)
        self.label_n_bits_in = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_n_bits_in.setObjectName("label_n_bits_in")
        self.label_n_bits_in.setWordWrap(True)
        self.label_n_bits_in.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_n_bits_in, 5, 0, 1, 1)
        self.n_bits_in = QtWidgets.QSpinBox(parent=self.scrollAreaWidgetContents)
        self.n_bits_in.setObjectName("n_bits_in")
        self.n_bits_in.setRange(1, 4096)
        self.n_bits_in.setToolTip("Width of every input and of the output (Simulink inherits it "
                                  "from the input signals). All inputs must have this width.")
        self.gridLayout.addWidget(self.n_bits_in, 5, 1, 1, 2)
        self.scrollArea.setWidget(self.scrollAreaWidgetContents)
        self.verticalLayout.addWidget(self.scrollArea)

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
        MainWindow.setWindowTitle(_translate("MainWindow", "Logical"))
        self.title_label.setText(_translate("MainWindow", "Logical"))
        self.desc_label.setText(_translate("MainWindow", "Bitwise logical logical (AND, NAND, OR, NOR, XOR, XNOR) of 2 or more equal-width inputs, with optional latency and enable port (Xilinx Logical block, Full precision)."))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.label_logical_function.setText(_translate("MainWindow", "Logical function"))
        for i, text in enumerate(["AND", "NAND", "OR", "NOR", "XOR", "XNOR"]):
            self.logical_function.setItemText(i, _translate("MainWindow", text))
        self.label_inputs.setText(_translate("MainWindow", "Number of inputs"))
        self.label_en.setText(_translate("MainWindow", "Provide enable port"))
        self.label_latency.setText(_translate("MainWindow", "Latency"))
        self.label_n_bits_in.setText(_translate("MainWindow", "Input/output width (bits)"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
