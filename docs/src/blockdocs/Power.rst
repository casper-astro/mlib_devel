Power
======
| **Block:** Power (``power``)
| **Block Author**: Aaron Parsons
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
Computes the power of a complex number.

Mask Parameters 
----------------

+-------------+------------+------------------------------------+
| Parameter   | Variable   | Description                        |
+=============+============+====================================+
| Bit Width   | BitWidth   | The number of bits in its input.   |
+-------------+------------+------------------------------------+

Ports 
------

+---------+-------+----------------------------------------+-----------------------------------------------------------------------------------------------------------------+
| Port    | Dir   | Data Type                              | Description                                                                                                     |
+=========+=======+========================================+=================================================================================================================+
| c       | IN    | 2\*BitWidth Fixed point                | A complex number whose higher BitWidth bits are its real part and lower BitWidth bits are its imaginary part.   |
+---------+-------+----------------------------------------+-----------------------------------------------------------------------------------------------------------------+
| power   | OUT   | UFix\_(2\*BitWidth)\_(2\*BitWidth-1)   | The computed power of the input complex number.                                                                 |
+---------+-------+----------------------------------------+-----------------------------------------------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
The power block typically has a latency of 5 and will compute the power
of its input by taking the sum of the squares of its real and imaginary
components.