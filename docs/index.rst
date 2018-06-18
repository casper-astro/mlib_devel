.. CASPER Block Documentation master file, created by
   sphinx-quickstart on Fri Jun 15 09:16:25 2018.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to CASPER Block Documentation!
======================================================

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
| -  `Signal Processing Blocks <#signal-processing-blocks>`__              |
| -  `Communication Blocks <#communication-blocks>`__                      |
| -  `System Blocks <#system-blocks>`__                                    |
+--------------------------------------------------------------------------+


Signal Processing Blocks 
--------------------------

:doc:`adder_tree <src/Adder_tree>`       (Adder Tree)

:doc:`barrel_switcher <src/Barrel_switcher>`     (Barrel Switcher)

:doc:`bit_reverse <src/Bit_reverse>`     (Bit Reverser)

:doc:`cmult_4bit_br* <src/Cmult_4bit_br*>`       (Conjugating Complex 4-bit Multiplier Implemented in BlockRAM)

:doc:`cmult_4bit_br <src/Cmult_4bit_br>`     (Complex 4-bit Multiplier Implemented in BlockRAM)

:doc:`cmult_4bit_em* <src/Cmult_4bit_em*>`       (Conjugating Complex 4-bit Multiplier Implemented in Dedicated Multipliers)

:doc:`cmult_4bit_em <src/Cmult_4bit_em>`     (Complex 4-bit Multiplier Implemented in Embedded Multipliers)

:doc:`cmult_4bit_sl* <src/Cmult_4bit_sl*>`       (Conjugating Complex 4-bit Multiplier Implemented in Slices)

:doc:`cmult_4bit_sl <src/Cmult_4bit_sl>`     (Complex 4-bit Multiplier Implemented in Slices)

:doc:`complex_addsub <src/Complex_addsub>`       (Complex Adder/Subtractor)

:doc:`c_to_ri <src/C_to_ri>`     (Complex to Real/Imaginary)

:doc:`DDS <src/Dds>`     (Direct Digital Synthesizer)

:doc:`dec_fir <src/Dec_fir>`     (Decimating FIR Filter)

:doc:`delay_bram_en_plus <src/Delay_bram_en_plus>`       (Enabled Delay in BlockRAM))

:doc:`delay_bram_prog <src/Delay_bram_prog>`     (Programmable Delay in BlockRAM)

:doc:`delay_bram <src/Delay_bram>`       (Delay in BlockRAM)

:doc:`delay_complex <src/Delay_complex>`     (Complex Delay)

:doc:`delay_slr <src/Delay_slr>`     (Delay in SLRs)

:doc:`delay_wideband_prog <src/Delay_wideband_prog>`     (Programmable Wideband Delay Implemented in BlockRAM)

:doc:`dram_vacc <src/Dram_vacc>`     (DRAM Vector Accumulator)

:doc:`dram_vacc_tvg <src/Dram_vacc_tvg>`     (DRAM Vector Accumulator Test Vector Generator)

:doc:`edge <src/Edge>`       (Edge Detect Block)

:doc:`fft_biplex_real_2x <src/Fft_biplex_real_2x>`       (Real-sampled Biplex FFT, with Output Demuxed by 2)

:doc:`fft_biplex_real_4x <src/Fft_biplex_real_4x>`       (Real-sampled Biplex FFT, with Output Demuxed by 4)

:doc:`fft <src/Fft>`     (Complex FFT)

:doc:`fft_wideband_real <src/Fft_wideband_real>`     (Real-sampled Wideband FFT)

:doc:`finedelay_fstop_prog <src/Finedelay_fstop_prog>`       (Programmable Fine delay along with Fringe Stop)

:doc:`finedelay_fstop_prog_cordic <src/Finedelay_fstop_prog_cordic>`     (Programmable Fine delay with Fringe Stop using CORDIC block)

:doc:`fir_col <src/Fir_col>`     (PFB FIR Column)

:doc:`fir_dbl_col <src/Fir_dbl_col>`     (PFB FIR Double Column)

:doc:`fir_tap <src/Fir_tap>`     (PFB FIR Tap)

:doc:`freeze_cntr <src/Freeze_cntr>`     (Freeze Counter)

:doc:`lo_const <src/Lo_const>`       (DC Local Oscillator)

:doc:`lo_osc <src/Lo_osc>`       (Local Oscillator)

:doc:`mixer <src/Mixer>`     (Mixer)

:doc:`negedge <src/Negedge>`     (Negative Edge Detector)

:doc:`partial_delay <src/Partial_delay>`     (Partial Delay)

:doc:`pfb_fir_real <src/Pfb_fir_real>`       (Real-sampled Polyphase FIR Filter Frontend for PFB)

:doc:`pfb_fir <src/Pfb_fir>`     (Polyphase FIR Filter Frontend for PFB)

:doc:`posedge <src/Posedge>`     (Positive Edge Detector)

:doc:`power <src/Power>`     (Complex Data Power Calculator)

:doc:`pulse_ext <src/Pulse_ext>`     (Pulse Extender)

:doc:`rcmult <src/Rcmult>`       (Real/Complex Multiplier)

:doc:`reorder <src/Reorder>`     (Arbitrary Reorderer)

:doc:`ri_to_c <src/Ri_to_c>`     (Real/Imaginary to Complex)

:doc:`square_transposer <src/Square_transposer>`     (Square Transposer)

:doc:`stopwatch <src/Stopwatch>`     (Stopwatch)

:doc:`sync_delay_en <src/Sync_delay_en>`     (Enabled Sync Delay)

:doc:`sync_delay_proc <src/Sync_delay_prog>`     (Programmable Sync Delay)

:doc:`sync_gen <src/Sync_gen>`       (Parameterized Sync Generator)

:doc:`win_x_engine <src/Win_x_engine>`       (Windowed X-Engine)

:doc:`xeng_tvg <src/Xeng_tvg>`       (X-Engine Test Vector Generator)

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Signal Processing Blocks

    src/Adder_tree
    src/Barrel_switcher
    src/Bit_reverse
    src/Cmult_4bit_br*
    src/Cmult_4bit_br
    src/Cmult_4bit_em*
    src/Cmult_4bit_em
    src/Cmult_4bit_sl*
    src/Cmult_4bit_sl
    src/Complex_addsub
    src/C_to_ri
    src/Dds
    src/Dec_fir
    src/Delay_bram_en_plus
    src/Delay_bram_prog
    src/Delay_bram
    src/Delay_complex
    src/Delay_slr
    src/Delay_wideband_prog
    src/Dram_vacc
    src/Dram_vacc_tvg
    src/Edge
    src/Fft_biplex_real_2x
    src/Fft_biplex_real_4x
    src/Fft
    src/Fft_wideband_real
    src/Finedelay_fstop_prog
    src/Finedelay_fstop_prog_cordic
    src/Fir_col
    src/Fir_dbl_col
    src/Fir_tap
    src/Freeze_cntr
    src/Lo_const
    src/Lo_osc
    src/Mixer
    src/Negedge
    src/Partial_delay
    src/Pfb_fir_real
    src/Pfb_fir
    src/Posedge
    src/Power
    src/Pulse_ext
    src/Rcmult
    src/Reorder
    src/Ri_to_c
    src/Square_transposer
    src/Stopwatch
    src/Sync_delay_en
    src/Sync_delay_prog
    src/Sync_gen
    src/Win_x_engine
    src/Xeng_tvg


Communication Blocks 
----------------------

:doc:`ten_gbe <src/Ten_GbE>`        (10GbE Transceiver)

:doc:`XAUI <src/XAUI>`      (XAUI Transceiver)

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Communication Blocks

    src/Ten_GbE
    src/XAUI

System Blocks 
---------------

:doc:`adc <src/Adc>`     (ADC)

:doc:`x64_adc <src/X64_adc>`     (64 Channel, 12 bit ADC: `64ADCx64-12 <src/64ADCx64-12.html>`__)

:doc:`dac <src/Dac>` (DAC)

:doc:`dram <src/Dram>`       (DRAM)

:doc:`gpio <src/GPIO>`       (GPIO)

:doc:`gpio_bidir <src/gpio_bidir>`      (Bi-directional GPIO)

:doc:`qdr <src/Qdr>`     (QDR)

:doc:`snapshot <src/Snapshot>`       (Snapshot Capture)

:doc:`snap <src/Snap>`       (Snapshot Capture)

:doc:`snap64 <src/Snap64>`       (64-Bit Snapshot Capture)

:doc:`software_register <src/Software_register>`     (Software Register)

:doc:`sram <src/Sram>`       (SRAM)

:doc:`XSG core config <src/XSG_core_config>`     (XSG Core Config)

:doc:`Gaussian Random Number Generator <src/Gaussian_Random_Number_Gen>`     (Gaussian Random Number Generator)

:doc:`Correlation Control Block <src/Correlation_Control_Block>`     (CCB)

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: System Blocks

    src/Adc
    src/X64_adc
    src/64ADCx64-12
    src/Dac
    src/Dram
    src/GPIO
    src/gpio_bidir
    src/Qdr
    src/Snapshot
    src/Snap
    src/Snap64
    src/Software_register
    src/Sram
    src/XSG_core_config
    src/Gaussian_Random_Number_Gen
    src/Correlation_Control_Block