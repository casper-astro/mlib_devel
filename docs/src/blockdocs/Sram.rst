SRAM
=====
| **Block:** SRAM (``sram``)
| **Block Author**: Pierre Yves Droz, Henry Chen
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
|    -  `Usage <#usage>`__                                                 |
+--------------------------------------------------------------------------+

Summary 
--------
The sram block represents a 36x512k SRAM chip on the IBOB. It stores
36-bit words and requires 19 bits to access its address space.

Mask Parameters 
----------------

+--------------------------------------+------------------+----------------------------------------------------------------+
| Parameter                            | Variable         | Description                                                    |
+======================================+==================+================================================================+
| SRAM                                 | sram             | Selects which SRAM chip this block represents.                 |
+--------------------------------------+------------------+----------------------------------------------------------------+
| Data Type                            | arith\_type      | Type to which the data is cast on both the input and output.   |
+--------------------------------------+------------------+----------------------------------------------------------------+
| Data binary point (bitwidth is 36)   | bin\_pt          | Position of the binary point of the data.                      |
+--------------------------------------+------------------+----------------------------------------------------------------+
| Sample period                        | sample\_period   | Sets the period with reference to the clock frequency.         |
+--------------------------------------+------------------+----------------------------------------------------------------+
| Simulate SRAM using ModelSim         | use\_sim         | Turns ModelSim simulation on or off.                           |
+--------------------------------------+------------------+----------------------------------------------------------------+

Ports 
------

+---------------+-------+-------------------+--------------------------------------------------------------------------------------------------------------------+
| Port          | Dir   | Data Type         | Description                                                                                                        |
+===============+=======+===================+====================================================================================================================+
| we            | IN    | boolean           | A signal that when high, causes the data on data\_in to be written to address.                                     |
+---------------+-------+-------------------+--------------------------------------------------------------------------------------------------------------------+
| be            | IN    | unsigned\_4\_0    | A signal that enables different 9-bit bytes of data\_in to be written.                                             |
+---------------+-------+-------------------+--------------------------------------------------------------------------------------------------------------------+
| address       | IN    | unsigned\_19\_0   | A signal that specifies the address where either data\_in is to be stored or from where data\_out is to be read.   |
+---------------+-------+-------------------+--------------------------------------------------------------------------------------------------------------------+
| data\_in      | IN    | arith\_type\_36   | A signal that contains the data to be stored.                                                                      |
+---------------+-------+-------------------+--------------------------------------------------------------------------------------------------------------------+
| data\_out     | OUT   | arith\_type\_36   | A signal that contains the data coming out of address.                                                             |
+---------------+-------+-------------------+--------------------------------------------------------------------------------------------------------------------+
| data\_valid   | OUT   | boolean           | A signal that is high when data\_out is valid.                                                                     |
+---------------+-------+-------------------+--------------------------------------------------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
The SRAM block is 36x512k, signifying that its input and output are
36-bit words and it can store 512k words. Each clock cyle, if ``we`` is
high, then each bit of be determines whether each 9-bit chunk will be
written to address. ``be`` is 4 bits with the highest bit corresponding
to the most significant chunk (so if ``be`` is 1100, only the top 18
bits will be written). If ``we`` is low, then the SRAM block ignores
``data_in`` and be and reads the word stored at ``address``.