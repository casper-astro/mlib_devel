X-Engine TVG
=============
| **Block:** X-Engine TVG (``xeng_tvg``)
| **Block Author**: Jason Manley
| **Document Author**: Jason Manley

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
+--------------------------------------------------------------------------+

Summary 
--------
Basic test vector generator for CASPER X-engines.

Mask Parameters 
----------------

+----------------------------------------+----------------+-----------------------------------------------------+
| Parameter                              | Variable       | Description                                         |
+========================================+================+=====================================================+
| Number of Antennas (2\ :sup:`n`)       | ant\_bits      | Bitwidth of the number of antennas in the system.   |
+----------------------------------------+----------------+-----------------------------------------------------+
| Bitwidth of Samples in                 | bits\_in       | Bitwidth of component of the input.                 |
+----------------------------------------+----------------+-----------------------------------------------------+
| X integration length (2\ :sup:`n`)     | x\_int\_bits   | Bitwidth of X-engine accumulation length.           |
+----------------------------------------+----------------+-----------------------------------------------------+
| Sync Pulse Period (2\ :sup:`n`)        | sync\_period   | Bitwidth of number of valids between sync pulses.   |
+----------------------------------------+----------------+-----------------------------------------------------+

Ports 
------

+--------------+-------+--------------------------+-------------------------------------------------------+
| Port         | Dir   | Data Type                | Description                                           |
+==============+=======+==========================+=======================================================+
| tvg\_sel     | in    | ufix\_2\_0               | TVG selection. 0=off (passthrough), 1-3=TVG select.   |
+--------------+-------+--------------------------+-------------------------------------------------------+
| data\_in     | in    | inherited: bits\_in\*4   | Data in for passthrough.                              |
+--------------+-------+--------------------------+-------------------------------------------------------+
| valid\_in    | in    | boolean                  | Valid in made available for passthrough.              |
+--------------+-------+--------------------------+-------------------------------------------------------+
| sync\_in     | in    | boolean                  | Sync in made available for passthrough.               |
+--------------+-------+--------------------------+-------------------------------------------------------+
| data\_out    | out   | inherited: bits\_in\*4   |  ???                                                  |
+--------------+-------+--------------------------+-------------------------------------------------------+
| sync\_out    | out   | boolean                  |  ???                                                  |
+--------------+-------+--------------------------+-------------------------------------------------------+
| valid\_out   | out   | boolean                  |  ???                                                  |
+--------------+-------+--------------------------+-------------------------------------------------------+

Description 
------------
This block generates data in a format suitable for input to a CASPER
X-engine. The ``tvg_sel`` line selects the TVG. If set to zero, it is
configured for passthrough and all input signals are propagated to the
output (TVG is off). Values one through three select a TVG pattern. In
this case, sync pulses are generated internally and valid data is output
all the time. The three patterns are as follows:

#. Inserts a counter representing the antenna number. All real values
   count up from zero and imaginary values counting down from zero. ie.,
   antenna four would have the value 4 − 4\ *i* inserted.
#. Inserts the same constant for all antennas: Pol\ :sub:`1\ real` =
   0.125, Pol\ :sub:`1\ imag` = − 0.75, Pol\ :sub:`2\ real` = 0.5
   and Pol\ :sub:`2\ imag` = − 0.25
#. User selectable values for each antenna. Input registers named
   ``tv0`` through ``tv7`` are input cyclically. Each value is input for
   ``x_int_bits`` clocks.