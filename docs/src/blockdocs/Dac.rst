DAC
====
| **Block:** DAC (``dac``)
| **Block Author**: Henry Chen
| **Document Author**: Ben Blackman

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div id="toctitle">                                                   |
|                                                                          |
| .. rubric:: Contents                                                     |
|    :name: contents                                                       |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
|                                                                          |
| -  `Summary <#summary>`__                                                |
| -  `Mask Parameters <#mask-parameters>`__                                |
| -  `Ports <#ports>`__                                                    |
| -  `Description <#description>`__                                        |
|                                                                          |
|    -  `Usage <uUsage>`__                                                 |
+--------------------------------------------------------------------------+

Summary 
---------
The DAC block converts 4 digital inputs to 1 analog output. The ``dac``
runs at 4x FPGA clock frequency, outputting analog converted samples 0
through 3 each FPGA clock cycle.

Mask Parameters 
-----------------

+----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+
| Parameter                        | Variable         | Description                                                                                                                                       |
+==================================+==================+===================================================================================================================================================+
| DAC board                        | dac\_brd         | Select which IBOB port to run this ``dac``.                                                                                                       |
+----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+
| DAC clock rate (MHz)             | dac\_clk\_rate   | The clock rate to run the ``dac``. Must be 4x FPGA clock rate.                                                                                    |
+----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+
| Sample period                    | sample\_period   | Sets the period at which the ``dac`` outputs samples (ie 2 means every other cycle).                                                              |
+----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+
| Show Implementation Parameters   | show\_param      | Allows the user to set the implementation parameters.                                                                                             |
+----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+
| Invert output clock phase        | invert\_clock    | When unchecked, the ``dac`` samples the data aligned with the clock. When checked, the ``dac`` samples the data aligned with an inverted clock.   |
+----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+

Ports 
-------

+------------+-------+-------------+--------------------------------------------------------+
| Port       | Dir   | Data Type   | Description                                            |
+============+=======+=============+========================================================+
| dataX      | IN    | Fix\_9\_8   | One of 4 digital inputs to be converted to analog.     |
+------------+-------+-------------+--------------------------------------------------------+
| sim\_out   | OUT   | double      | Analog output of ``dac``. Note: For simulation only.   |
+------------+-------+-------------+--------------------------------------------------------+

Description 
------------
Usage 
^^^^^^^
The ``dac`` takes 4 ``Fix_9_8`` inputs and outputs an analog stream. The
``dac`` runs at 4x the FPGA clock speed.

To be updated.