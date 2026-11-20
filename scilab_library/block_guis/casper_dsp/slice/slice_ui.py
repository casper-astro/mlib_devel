# Form implementation for the Slice mask dialog.
# Hand-written after block_guis/casper_dsp/counter/counter_ui.py to match the
# layout in ui/slice.ui -- if PyQt6/pyuic6 is available, regenerate with:
#   pyuic6 ui/slice.ui -o slice_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def _add_row(self, row, key, widget):
        label = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        label.setObjectName("label_" + key)
        label.setWordWrap(True)
        label.setFixedWidth(269)
        setattr(self, "label_" + key, label)
        self.gridLayout.addWidget(label, row, 0, 1, 1)
        widget.setObjectName(key)
        setattr(self, key, widget)
        self.gridLayout.addWidget(widget, row, 1, 1, 2)

    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(669, 520)
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

        self._add_row(0, "name", QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents))

        n_bits_in = QtWidgets.QSpinBox(parent=self.scrollAreaWidgetContents)
        n_bits_in.setRange(1, 4096)
        n_bits_in.setToolTip("Width of the din input. Simulink inherits it from the input "
                             "signal; Xcos needs it here (it is slice.v's NBITS).")
        self._add_row(1, "n_bits_in", n_bits_in)

        nbits = QtWidgets.QSpinBox(parent=self.scrollAreaWidgetContents)
        nbits.setRange(1, 4096)
        nbits.setToolTip("Number of bits taken from din (the width of dout). "
                         "Not used with 'Two Bit Locations'.")
        self._add_row(2, "nbits", nbits)

        mode = QtWidgets.QComboBox(parent=self.scrollAreaWidgetContents)
        for _ in range(3):
            mode.addItem("")
        mode.setToolTip("'Upper Bit Location + Width': the top bit is given, the slice extends "
                        "nbits downward. 'Lower Bit Location + Width': the bottom bit is given, "
                        "the slice extends nbits upward. 'Two Bit Locations': both ends are given.")
        self._add_row(3, "mode", mode)

        bit1 = QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents)
        bit1.setToolTip("Offset of the top bit of the slice from the selected base. "
                        "Relative to 'MSB of Input' it is <= 0 (0 = the MSB, -1 = the bit below); "
                        "relative to 'LSB of Input' it is >= 0 (0 = bit 0).")
        self._add_row(4, "bit1", bit1)

        base1 = QtWidgets.QComboBox(parent=self.scrollAreaWidgetContents)
        base1.addItem("")
        base1.addItem("")
        self._add_row(5, "base1", base1)

        bit0 = QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents)
        bit0.setToolTip("Offset of the bottom bit of the slice from the selected base. "
                        "Relative to 'LSB of Input' it is >= 0 (0 = bit 0); "
                        "relative to 'MSB of Input' it is <= 0 (0 = the MSB).")
        self._add_row(6, "bit0", bit0)

        base0 = QtWidgets.QComboBox(parent=self.scrollAreaWidgetContents)
        base0.addItem("")
        base0.addItem("")
        self._add_row(7, "base0", base0)

        self._add_row(8, "selected_bits", QtWidgets.QLabel(parent=self.scrollAreaWidgetContents))

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
        MainWindow.setWindowTitle(_translate("MainWindow", "Slice"))
        self.title_label.setText(_translate("MainWindow", "Slice"))
        self.desc_label.setText(_translate("MainWindow", "Extracts a given range of bits from each input sample and presents it at the output (unsigned, binary point at zero). In hardware this block costs nothing."))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.label_n_bits_in.setText(_translate("MainWindow", "Input width (number of bits)"))
        self.label_nbits.setText(_translate("MainWindow", "Width of slice (number of bits)"))
        self.label_mode.setText(_translate("MainWindow", "Specify range as"))
        self.mode.setItemText(0, _translate("MainWindow", "Two Bit Locations"))
        self.mode.setItemText(1, _translate("MainWindow", "Upper Bit Location + Width"))
        self.mode.setItemText(2, _translate("MainWindow", "Lower Bit Location + Width"))
        self.label_bit1.setText(_translate("MainWindow", "Offset of top bit"))
        self.label_base1.setText(_translate("MainWindow", "Relative to"))
        self.base1.setItemText(0, _translate("MainWindow", "LSB of Input"))
        self.base1.setItemText(1, _translate("MainWindow", "MSB of Input"))
        self.label_bit0.setText(_translate("MainWindow", "Offset of bottom bit"))
        self.label_base0.setText(_translate("MainWindow", "Relative to"))
        self.base0.setItemText(0, _translate("MainWindow", "LSB of Input"))
        self.base0.setItemText(1, _translate("MainWindow", "MSB of Input"))
        self.label_selected_bits.setText(_translate("MainWindow", "Selected bits"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
