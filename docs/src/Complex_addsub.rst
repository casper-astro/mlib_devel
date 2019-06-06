Complex Adder/Subtractor
=========================
| **Block:** Complex Adder/Subtractor (``complex_addsub``)
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
---------
This block does a complex addition and subtraction of 2 complex numbers,
``a`` and ``b``, and spits out 2 complex numbers, ``a+b`` and ``a-b``.

Mask Parameters 
-----------------

+---------------+----------------+------------------------------------------+
| Parameter     | Variable       | Description                              |
+===============+================+==========================================+
| Bit Width     | BitWidth       | The number of bits in its input.         |
+---------------+----------------+------------------------------------------+
| Add Latency   | add\_latency   | The latency of the adders/subtractors.   |
+---------------+----------------+------------------------------------------+

Ports 
------

+--------+-------+---------------------------+--------------------------------------------------------------------------------------------------------------------------+
| Port   | Dir   | Data Type                 | Description                                                                                                              |
+========+=======+===========================+==========================================================================================================================+
| a      | IN    | 2\*BitWidth Fixed point   | The first complex number whose higher BitWidth bits are its real part and lower BitWidth bits are its imaginary part.    |
+--------+-------+---------------------------+--------------------------------------------------------------------------------------------------------------------------+
| b      | IN    | 2\*BitWidth Fixed point   | The second complex number whose higher BitWidth bits are its real part and lower BitWidth bits are its imaginary part.   |
+--------+-------+---------------------------+--------------------------------------------------------------------------------------------------------------------------+
| a+b    | OUT   | 2\*BitWidth Fixed point   | Upper BitWidth bits are real(\ ``a``)+real(\ ``b``). Lower BitWidth bits are imaginary(\ ``a``)-imaginary(\ ``b``).      |
+--------+-------+---------------------------+--------------------------------------------------------------------------------------------------------------------------+
| a-b    | OUT   | 2\*BitWidth Fixed point   | Upper BitWidth bits are imaginary(\ ``a``)+imaginary(\ ``b``). Lower BitWidth bits are real(\ ``b``)-real(\ ``a``).      |
+--------+-------+---------------------------+--------------------------------------------------------------------------------------------------------------------------+

Description 
-------------
Usage 
^^^^^^
The top output, ``a+b``, is a complex output whose real part equals the
sum of the real parts of ``a`` and ``b``. The imaginary part of ``a+b``
equals the difference of the imaginary parts of ``a`` and ``b``. The
bottom output, ``a-b``, is a complex output whose real part equals the
sum of the imaginary parts of ``a`` and ``b``.The imaginary part of
``a-b`` equals the difference of the real parts of ``b`` and ``a``. The
latency of this block is 2\*\ ``add_latency``.