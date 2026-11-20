# Form implementation for the Delay mask dialog.
# Hand-written after block_guis/casper_dsp/counter/counter_ui.py to match the
# layout in ui/delay.ui -- if PyQt6/pyuic6 is available, regenerate with:
#   pyuic6 ui/delay.ui -o delay_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(669, 360)
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
        self.label_rst = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_rst.setObjectName("label_rst")
        self.label_rst.setWordWrap(True)
        self.label_rst.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_rst, 1, 0, 1, 1)
        self.rst = QtWidgets.QCheckBox(parent=self.scrollAreaWidgetContents)
        self.rst.setObjectName("rst")
        self.rst.setToolTip("Adds a 1-bit 'rst' input port: rst = 1 clears every delay stage to 0 "
                            "on the next clock edge (it overrides en). No effect when Latency is 0.")
        self.gridLayout.addWidget(self.rst, 1, 1, 1, 2)
        self.label_en = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_en.setObjectName("label_en")
        self.label_en.setWordWrap(True)
        self.label_en.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_en, 2, 0, 1, 1)
        self.en = QtWidgets.QCheckBox(parent=self.scrollAreaWidgetContents)
        self.en.setObjectName("en")
        self.en.setToolTip("Adds a 1-bit 'en' input port: the delay line only shifts on clock edges "
                           "where en = 1 and holds its contents otherwise. No effect when Latency is 0.")
        self.gridLayout.addWidget(self.en, 2, 1, 1, 2)
        self.label_latency = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_latency.setObjectName("label_latency")
        self.label_latency.setWordWrap(True)
        self.label_latency.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_latency, 3, 0, 1, 1)
        self.latency = QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents)
        self.latency.setObjectName("latency")
        self.latency.setToolTip("Number of clock cycles din is delayed by (integer >= 0); "
                                "0 gives a plain wire.")
        self.gridLayout.addWidget(self.latency, 3, 1, 1, 2)
        self.label_n_bits = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        self.label_n_bits.setObjectName("label_n_bits")
        self.label_n_bits.setWordWrap(True)
        self.label_n_bits.setFixedWidth(269)
        self.gridLayout.addWidget(self.label_n_bits, 4, 0, 1, 1)
        self.n_bits = QtWidgets.QSpinBox(parent=self.scrollAreaWidgetContents)
        self.n_bits.setObjectName("n_bits")
        self.n_bits.setRange(1, 4096)
        self.n_bits.setToolTip("Width of din and dout. Simulink inherits it from the input signal; "
                               "Xcos needs it here.")
        self.gridLayout.addWidget(self.n_bits, 4, 1, 1, 2)
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
        MainWindow.setWindowTitle(_translate("MainWindow", "Delay"))
        self.title_label.setText(_translate("MainWindow", "Delay"))
        self.desc_label.setText(_translate("MainWindow", "Delays din by a number of clock cycles (Xilinx Delay block). Optional synchronous reset and enable ports control the delay line."))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.label_rst.setText(_translate("MainWindow", "Provide synchronous reset port"))
        self.label_en.setText(_translate("MainWindow", "Provide enable port"))
        self.label_latency.setText(_translate("MainWindow", "Latency"))
        self.label_n_bits.setText(_translate("MainWindow", "Data width (bits, Simulink inherits it)"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
