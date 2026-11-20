# Form implementation for the FIFO mask dialog.
# Hand-written to match the layout in ui/fifo.ui, which follows the Simulink
# "Xilinx FIFO Block" dialog (Vivado data/sysgen/xml/fifo_gui.xml): a Basic
# tab with the "FIFO Implementation" and "Optional Ports" groups, the same
# prompts, radio groups and list boxes, in the same order. If PyQt6/pyuic6
# is available, regenerate with:
#   pyuic6 ui/fifo.ui -o fifo_ui.py
# and keep both in sync by hand otherwise.

from PyQt6 import QtCore, QtGui, QtWidgets


# Simulink list box contents (fifo_gui.xml)
DEPTH_ITEMS = ['16', '32', '64', '128', '256', '512', '1K', '2K', '4K', '8K', '16K',
               '32K', '64K', '128K', '256K', '512K', '1M', '2M', '4M']
PERCENT_NBITS_ITEMS = [str(i) for i in range(1, 23)]
RST_LATENCY_ITEMS = [str(i) for i in range(0, 6)]
# (mask value, label) of the radio groups
MEM_TYPE_ITEMS = [('Block RAM', 'Block RAM'), ('Distributed RAM', 'Distributed RAM'),
                  ('Shift Register', 'Shift Register'), ('Built-in FIFO', 'Built-in FIFO')]
PERFORMANCE_OPTIONS_ITEMS = [('Standard_FIFO', 'Standard FIFO'),
                             ('First_Word_Fall_Through', 'First Word Fall Through')]


class Ui_MainWindow(object):
    def _radio_group(self, parent, name, items):
        """A group box of radio buttons (a Simulink radiogroup); the buttons
        are kept in self.<name>_buttons as {mask value: QRadioButton}."""
        box = QtWidgets.QGroupBox(parent=parent)
        box.setObjectName(name)
        layout = QtWidgets.QHBoxLayout(box)
        group = QtWidgets.QButtonGroup(box)
        buttons = {}
        for value, _ in items:
            button = QtWidgets.QRadioButton(parent=box)
            button.setObjectName(name + '_' + value.lower().replace(' ', '_').replace('-', '_'))
            group.addButton(button)
            layout.addWidget(button)
            buttons[value] = button
        layout.addStretch(1)
        setattr(self, name + '_group', group)
        setattr(self, name + '_buttons', buttons)
        return box

    def _checkbox(self, parent, layout, name):
        widget = QtWidgets.QCheckBox(parent=parent)
        widget.setObjectName(name)
        layout.addWidget(widget)
        setattr(self, name, widget)
        return widget

    def _labelled(self, parent, layout, name, widget):
        """A row with its prompt on the left, as Simulink's list boxes."""
        row = QtWidgets.QHBoxLayout()
        label = QtWidgets.QLabel(parent=parent)
        label.setObjectName('label_' + name)
        row.addWidget(label)
        widget.setObjectName(name)
        row.addWidget(widget, 1)
        layout.addLayout(row)
        setattr(self, 'label_' + name, label)
        setattr(self, name, widget)
        return widget

    def _top_labelled(self, parent, layout, name, widget):
        """A prompt above its edit box (Simulink's top_label="true")."""
        label = QtWidgets.QLabel(parent=parent)
        label.setObjectName('label_' + name)
        layout.addWidget(label)
        widget.setObjectName(name)
        layout.addWidget(widget)
        setattr(self, 'label_' + name, label)
        setattr(self, name, widget)
        return widget

    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(560, 760)
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

        # block name and the data width (Xcos only: Simulink takes the name
        # from the diagram and inherits the width from din)
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
        self.basictab = QtWidgets.QWidget()
        self.basictab.setObjectName("basictab")
        self.basicLayout = QtWidgets.QVBoxLayout(self.basictab)
        self.basicLayout.setObjectName("basicLayout")

        # FIFO Implementation
        self.implementation_box = QtWidgets.QGroupBox(parent=self.basictab)
        self.implementation_box.setObjectName("implementation_box")
        self.implementationLayout = QtWidgets.QVBoxLayout(self.implementation_box)
        self.mem_type = self._radio_group(self.implementation_box, 'mem_type', MEM_TYPE_ITEMS)
        self.implementationLayout.addWidget(self.mem_type)
        self.performance_options = self._radio_group(self.implementation_box, 'performance_options',
                                                     PERFORMANCE_OPTIONS_ITEMS)
        self.implementationLayout.addWidget(self.performance_options)
        self.impl_options_box = QtWidgets.QGroupBox(parent=self.implementation_box)
        self.impl_options_box.setObjectName("impl_options_box")
        self.implOptionsLayout = QtWidgets.QVBoxLayout(self.impl_options_box)
        self._checkbox(self.impl_options_box, self.implOptionsLayout, 'embedded_registers')
        self.implementationLayout.addWidget(self.impl_options_box)
        self.basicLayout.addWidget(self.implementation_box)

        # Depth / %full precision
        self.depth = self._labelled(self.basictab, self.basicLayout, 'depth',
                                    QtWidgets.QComboBox(parent=self.basictab))
        self.depth.addItems(DEPTH_ITEMS)
        self.percent_nbits = self._labelled(self.basictab, self.basicLayout, 'percent_nbits',
                                            QtWidgets.QComboBox(parent=self.basictab))
        self.percent_nbits.addItems(PERCENT_NBITS_ITEMS)

        # Optional Ports
        self.ports_box = QtWidgets.QGroupBox(parent=self.basictab)
        self.ports_box.setObjectName("ports_box")
        self.portsLayout = QtWidgets.QVBoxLayout(self.ports_box)
        self._checkbox(self.ports_box, self.portsLayout, 'rst')
        self.rst_latency = self._labelled(self.ports_box, self.portsLayout, 'rst_latency',
                                          QtWidgets.QComboBox(parent=self.ports_box))
        self.rst_latency.addItems(RST_LATENCY_ITEMS)
        self._checkbox(self.ports_box, self.portsLayout, 'en')
        self._checkbox(self.ports_box, self.portsLayout, 'use_dcount')
        self._checkbox(self.ports_box, self.portsLayout, 'use_percent_full_port')
        self._checkbox(self.ports_box, self.portsLayout, 'use_almost_empty')
        self._top_labelled(self.ports_box, self.portsLayout, 'almost_empty_thresh',
                           QtWidgets.QLineEdit(parent=self.ports_box))
        self._checkbox(self.ports_box, self.portsLayout, 'use_almost_full')
        self._checkbox(self.ports_box, self.portsLayout, 'use_rd_rst_busy')
        self._checkbox(self.ports_box, self.portsLayout, 'use_wr_rst_busy')
        self._top_labelled(self.ports_box, self.portsLayout, 'almost_full_thresh',
                           QtWidgets.QLineEdit(parent=self.ports_box))
        self.basicLayout.addWidget(self.ports_box)
        self.basicLayout.addStretch(1)

        self.scrollArea = QtWidgets.QScrollArea()
        self.scrollArea.setWidgetResizable(True)
        self.scrollArea.setObjectName("scrollArea")
        self.scrollArea.setWidget(self.basictab)
        self.tabWidget.addTab(self.scrollArea, "")
        self.verticalLayout.addWidget(self.tabWidget)

        self.rst_latency.setToolTip("Cycles from rst to the reset taking effect. Simulink cannot "
                                    "simulate a reset port with Reset Latency 0, and on UltraScale(+) "
                                    "parts needs the reset port on with a latency of at least 2.")
        self.embedded_registers.setToolTip("Standard FIFO: adds a second output register, so dout "
                                           "follows re by two cycles. No effect in First Word Fall "
                                           "Through mode.")
        self.use_dcount.setToolTip("dcount: the stored word count, log2(depth) bits (one more in "
                                   "First Word Fall Through mode).")
        self.use_percent_full_port.setToolTip("percent_full (Simulink's %full): the fill level as an "
                                              "unsigned fraction UFix_n_n, n = the bits of precision.")
        tip = "Must be between 3 and depth - 3 (Standard FIFO) or 5 and depth - 5 (First Word Fall Through)."
        self.almost_empty_thresh.setToolTip(tip)
        self.almost_full_thresh.setToolTip(tip)
        tip = "Simulink provides this port only for Versal parts; its behaviour is not verified against Simulink."
        self.use_rd_rst_busy.setToolTip(tip)
        self.use_wr_rst_busy.setToolTip(tip)
        self.mem_type_buttons['Built-in FIFO'].setToolTip(
            "Modelled as Block RAM (Simulink has no usable model of the built-in FIFO).")

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
        MainWindow.setWindowTitle(_translate("MainWindow", "FIFO"))
        self.title_label.setText(_translate("MainWindow", "Xilinx FIFO Block"))
        self.desc_label.setText(_translate("MainWindow", "Synchronous FIFO memory queue. Values written with we are read back in order with re; empty / full, %full, the data count and the almost empty / full flags follow the Xilinx FIFO block."))
        self.label_name.setText(_translate("MainWindow", "Block name"))
        self.label_n_bits.setText(_translate("MainWindow", "Data width (bits, Simulink inherits it)"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.scrollArea), _translate("MainWindow", "Basic"))
        self.implementation_box.setTitle(_translate("MainWindow", "FIFO Implementation"))
        self.mem_type.setTitle(_translate("MainWindow", "Memory Type"))
        for value, label in MEM_TYPE_ITEMS:
            self.mem_type_buttons[value].setText(_translate("MainWindow", label))
        self.performance_options.setTitle(_translate("MainWindow", "Performance Options"))
        for value, label in PERFORMANCE_OPTIONS_ITEMS:
            self.performance_options_buttons[value].setText(_translate("MainWindow", label))
        self.impl_options_box.setTitle(_translate("MainWindow", "Implementation Options"))
        self.embedded_registers.setText(_translate("MainWindow", "Use Embedded Registers(when possible)"))
        self.label_depth.setText(_translate("MainWindow", "Depth"))
        self.label_percent_nbits.setText(_translate("MainWindow", "Bits of precision to use for %full signal"))
        self.ports_box.setTitle(_translate("MainWindow", "Optional Ports"))
        self.rst.setText(_translate("MainWindow", "Provide reset port"))
        self.label_rst_latency.setText(_translate("MainWindow", "Reset Latency"))
        self.en.setText(_translate("MainWindow", "Provide enable port"))
        self.use_dcount.setText(_translate("MainWindow", "Provide data count port"))
        self.use_percent_full_port.setText(_translate("MainWindow", "Provide percent full port"))
        self.use_almost_empty.setText(_translate("MainWindow", "Provide almost empty port"))
        self.label_almost_empty_thresh.setText(_translate("MainWindow", "Almost empty threshold"))
        self.use_almost_full.setText(_translate("MainWindow", "Provide almost full port"))
        self.use_rd_rst_busy.setText(_translate("MainWindow", "Provide read reset busy port"))
        self.use_wr_rst_busy.setText(_translate("MainWindow", "Provide write reset busy port"))
        self.label_almost_full_thresh.setText(_translate("MainWindow", "Almost full threshold"))
        self.button_apply.setText(_translate("MainWindow", "Apply"))
        self.button_ok.setText(_translate("MainWindow", "OK"))
        self.button_cancel.setText(_translate("MainWindow", "Cancel"))
