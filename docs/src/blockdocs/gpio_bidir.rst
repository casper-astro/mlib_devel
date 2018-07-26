Bi-directional GPIO
======================
| **Block:** Bi-directional GPIO (``gpio_bidir``)
| **Block Author**: Brian Bradford
| **Document Author**: Brian Bradford

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
| -  `Notes <#notes>`__                                                    |
+--------------------------------------------------------------------------+

Summary 
--------
The gpio_bidir block provides an Bi-diectional GPIO interface.

Mask Parameters 
----------------

+----------------------------+-------------------+------------------------------------------------------------------------+
| Parameter                  | Variable          | Description                                                            |
+============================+===================+========================================================================+
| I/O group                  | io\_group         | Selects the GPIO header on the board.                                  |
+----------------------------+-------------------+------------------------------------------------------------------------+
| Data bitwidth              | bitwidth          | Specifies data bitwidth.                                               |
+----------------------------+-------------------+------------------------------------------------------------------------+
| GPIO bit index             | bit\_index        | Specifies the pin on the selected GPIO header.                         |
+----------------------------+-------------------+------------------------------------------------------------------------+

Ports 
------

+--------------+------+-------------+----------------------------------------------------------+
| Port         | Dir  | Data Type   | Description                                              |
+==============+======+=============+==========================================================+
| din          | in   | inherited   | Data input (size set by Data bitwidth parameter in bits) |
+--------------+------+-------------+----------------------------------------------------------+
| in\_not\_out | in   | inherited   | The control signal, 1 for input and 0 for output.        |
+--------------+------+-------------+----------------------------------------------------------+
| dout         | out  | inherited   | The data output.                                         |
+--------------+------+-------------+----------------------------------------------------------+

Notes
------------

When using bitwidths greater than one, you should specify a vector of bit indices to use. GPIO bit index should have the same number of elements as the I/O bitwidth. 

Example: If you set Data bitwidth to 4, you might want you use GPIO bit indices [0, 1, 2, 3].