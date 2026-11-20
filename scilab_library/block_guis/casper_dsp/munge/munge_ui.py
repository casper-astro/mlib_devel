# Form implementation for the Munge mask dialog.
# Hand-written to match the layout in ui/munge.ui, which follows the
# casper_library munge mask (Number of divisions, Division size (bits),
# Division packing order, Output arithmetic type, Output binary point).
# If PyQt6/pyuic6 is available, regenerate with:
#   pyuic6 ui/munge.ui -o munge_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


# Simulink popup options of arith_type_out, verbatim (two spaces in "Signed")
ARITH_TYPE_OUT_ITEMS = ['Unsigned', "Signed  (2's comp)", 'Floating-point']


class Ui_MainWindow(object):
    def _row(self, row, name, widget):
        label = QtWidgets.QLabel(parent=self.scrollAreaWidgetContents)
        label.setObjectName('label_' + name)
        label.setWordWrap(True)
        label.setFixedWidth(220)
        self.gridLayout.addWidget(label, row, 0, 1, 1)
        widget.setObjectName(name)
        self.gridLayout.addWidget(widget, row, 1, 1, 2)
        setattr(self, 'label_' + name, label)
        setattr(self, name, widget)
        return widget

    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(640, 360)
        self.centralwidget = QtWidgets.QWidget(parent=MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.centralwidget)
        self.verticalLayout.setObjectName("verticalLayout")

        self.title_label = QtWidgets.QLabel(parent=self.centralwidget)
        self.title_label.setObjectName("title_label")
        self.verticalLayout.addWidget(self.title_label)

        self.desc_label = QtWidgets.QLabel(parent=self.centralwidget)
        self.desc_label.setWordWrap(True)
        self.desc_label.setTextFormat(QtCore.Qt.TextFormat.PlainText)
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
        self._row(0, 'name', QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents))
        self._row(1, 'divisions', QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents))
        self._row(2, 'div_size', QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents))
        self._row(3, 'order', QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents))
        self._row(4, 'arith_type_out', QtWidgets.QComboBox(parent=self.scrollAreaWidgetContents))
        self.arith_type_out.addItems(ARITH_TYPE_OUT_ITEMS)
        self._row(5, 'bin_pt_out', QtWidgets.QLineEdit(parent=self.scrollAreaWidgetContents))
        # read-only: the port widths the current values give
        self._row(6, 'widths', QtWidgets.QLabel(parent=self.scrollAreaWidgetContents))
        self.widths.setTextFormat(QtCore.Qt.TextFormat.PlainText)
        self.gridLayout.setRowStretch(7, 1)
        self.scrollArea.setWidget(self.scrollAreaWidgetContents)
        self.verticalLayout.addWidget(self.scrollArea)

        self.div_size.setToolTip("Bits of each division, MSB division first: one value for every "
                                 "division (e.g. 16) or one per division (e.g. 16*ones(1,16), [32 0 16 16]).")
        self.order.setToolTip("Division of din placed in each output slot, MSB first (division 0 is "
                              "the most significant), e.g. [8 0 9 1 10 2 11 3 12 4 13 5 14 6 15 7]. "
                              "Ignored with one division.")
        self.arith_type_out.setToolTip("Output type only: the output carries the same raw bits.")
        self.bin_pt_out.setToolTip("Output type only: the output carries the same raw bits.")

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
        MainWindow.setWindowTitle(_translate("MainWindow", "Munge"))
        self.title_label.setText(_translate("MainWindow", "munge"))
        self.desc_label.setText(_translate("MainWindow", "Splits an input bus into the specified number of divisions and then recombines them in the order specified (most significant division = 0, least = number divisions-1)"))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.label_divisions.setText(_translate("MainWindow", "Number of divisions"))
        self.label_div_size.setText(_translate("MainWindow", "Division size (bits)"))
        self.label_order.setText(_translate("MainWindow", "Division packing order"))
        self.label_arith_type_out.setText(_translate("MainWindow", "Output arithmetic type"))
        self.label_bin_pt_out.setText(_translate("MainWindow", "Output binary point"))
        self.label_widths.setText(_translate("MainWindow", "Port widths (din / dout)"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
