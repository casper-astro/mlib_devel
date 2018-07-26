Snapshot
=========
| **Block:** Snapshot (``snapshot``)
| **Block Author**: Andrew Martens
| **Document Author**: Andrew Martens

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
| -  `Software interface <#software-interface>`__                          |
| -  `Description <#description>`__                                        |
|                                                                          |
|    -  `Usage <#usage>`__                                                 |
+--------------------------------------------------------------------------+

Summary 
--------
The snapshot block is configurable block for capturing blocks of data
with a standard interface supporting generic software drivers. It
combines functionality from (and deprecates) the snap, sc, snap\_64 and
snap\_circ blocks.

Mask Parameters 
----------------

+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Parameter                          | Variable      | Description                                                                                                                           |
+====================================+===============+=======================================================================================================================================+
| Storage medium                     | storage       | Specifies whether to store the data in BRAM or DRAM                                                                                   |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| DRAM dimm                          | dram\_dimm    | Specifies which dimm to use if using DRAM as storage medium.                                                                          |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| DRAM clock rate                    | dram\_clock   | Specifies the DRAM controller clock rate if using DRAM as a storage medium.                                                           |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| No. of Samples (2\ :sup:`?`)       | nsamples      | Specifies the maximum depth of the data storage buffer                                                                                |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Data width                         | data\_width   | The bit width of the input data                                                                                                       |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Start delay support                | offset        | Option to support inserting a programmable number of samples between the trigger for the start of capture, and data capture itself.   |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Circular capture support           | circap        | Option to support continual capture until a signal to stop is received.                                                               |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Extra value capture support        | value         | Option to support the capture of a value to a register as the first data item is captured.                                            |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+
| Use DSP48s to implement counters   | use\_dsp48    | Option to use DSP48s to implement various internal counters to save logic.                                                            |
+------------------------------------+---------------+---------------------------------------------------------------------------------------------------------------------------------------+

Ports 
------

+--------------------+--------------------+--------------------+--------------------+
| Port               | Dir                | Data Type          | Description        |
+====================+====================+====================+====================+
| din                | IN                 | unsigned\_8\_0 OR  | The data to be     |
|                    |                    | unsigned\_16\_0 OR | captured. Data is  |
|                    |                    | unsigned\_32\_0 OR | stored with oldest |
|                    |                    | unsigned\_64\_0 OR | data in the lowest |
|                    |                    | unsigned\_128\_0   | addresses and in   |
|                    |                    |                    | little endian      |
|                    |                    |                    | format.            |
+--------------------+--------------------+--------------------+--------------------+
| we                 | IN                 | boolean            | After a trigger is |
|                    |                    |                    | begun, enables a   |
|                    |                    |                    | write to the data  |
|                    |                    |                    | buffer.            |
+--------------------+--------------------+--------------------+--------------------+
| trig               | IN                 | boolean            | When high,         |
|                    |                    |                    | triggers the       |
|                    |                    |                    | beginning of a     |
|                    |                    |                    | data capture.      |
|                    |                    |                    | Thereafter, every  |
|                    |                    |                    | enabled data is    |
|                    |                    |                    | written to the     |
|                    |                    |                    | data buffer.       |
|                    |                    |                    | If offset capture  |
|                    |                    |                    | is enabled,        |
|                    |                    |                    | capture can be     |
|                    |                    |                    | delayed by a       |
|                    |                    |                    | configurable       |
|                    |                    |                    | number of samples  |
|                    |                    |                    | after the trigger. |
|                    |                    |                    | If circular        |
|                    |                    |                    | capture is         |
|                    |                    |                    | enabled, capture   |
|                    |                    |                    | continues until    |
|                    |                    |                    | the input to the   |
|                    |                    |                    | stop port goes     |
|                    |                    |                    | high.              |
+--------------------+--------------------+--------------------+--------------------+
| stop               | IN                 | boolean            | Triggers the end   |
|                    |                    |                    | of data capture    |
|                    |                    |                    | when in circular   |
|                    |                    |                    | capture mode.      |
+--------------------+--------------------+--------------------+--------------------+
| vin                | IN                 | unsigned\_32\_0    | When extra value   |
|                    |                    |                    | capture is enabled |
|                    |                    |                    | the value on this  |
|                    |                    |                    | port is captured   |
|                    |                    |                    | on the same sample |
|                    |                    |                    | as the first data  |
|                    |                    |                    | item captured.     |
+--------------------+--------------------+--------------------+--------------------+
| ready              | OUT                | boolean            | When using DRAM as |
|                    |                    |                    | a storage buffer,  |
|                    |                    |                    | signals that the   |
|                    |                    |                    | DRAM controller    |
|                    |                    |                    | has finished       |
|                    |                    |                    | calibration and is |
|                    |                    |                    | ready to receive   |
|                    |                    |                    | data.              |
+--------------------+--------------------+--------------------+--------------------+

Software interface 
-------------------

+--------------------+--------------------+--------------------+
| Name               | Dir                | Data Type          |
+====================+====================+====================+
| ctrl               | Write              | unsigned\_32\_0    |
+--------------------+--------------------+--------------------+
| trig\_offset       | Write              | unsigned\_32\_0    |
+--------------------+--------------------+--------------------+
| val                | Read               | unsigned\_32\_0    |
+--------------------+--------------------+--------------------+
| status             | Read               | unsigned\_32\_0    |
+--------------------+--------------------+--------------------+
| tr\_en\_cnt        | Read               | unsigned\_32\_0    |
+--------------------+--------------------+--------------------+
| bram               | Read               | unsigned\_32\_0    |
+--------------------+--------------------+--------------------+
| dram               | Read               | unsigned\_32\_0    |
+--------------------+--------------------+--------------------+

Description 
------------
Usage 
^^^^^^^
Under TinySH/BORPH, this device will have 3 sub-devices: ``ctrl``,
``bram``, and ``addr``. ``ctrl`` is an input register. Bit 0, when
driven from low to high, enables a trigger/data capture to occur. Bit 1,
when high, overrides ``trig`` to trigger instantly. Bit 2, when high,
overrides ``we`` to always write data to bram. ``addr`` is an output
register and records the last address of ``bram`` to which data was
written. ``bram`` is a 32 bit wide Shared BRAM of the depth specified in
``Parameters``.