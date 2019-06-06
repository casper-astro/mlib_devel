Block Documentation
====================

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

:doc:`adder_tree <src/blockdocs/Adder_tree>`       (Adder Tree)

:doc:`barrel_switcher <src/blockdocs/Barrel_switcher>`     (Barrel Switcher)

:doc:`bit_reverse <src/blockdocs/Bit_reverse>`     (Bit Reverser)

:doc:`cmult_4bit_br* <src/blockdocs/Cmult_4bit_br*>`       (Conjugating Complex 4-bit Multiplier Implemented in BlockRAM)

:doc:`cmult_4bit_br <src/blockdocs/Cmult_4bit_br>`     (Complex 4-bit Multiplier Implemented in BlockRAM)

:doc:`cmult_4bit_em* <src/blockdocs/Cmult_4bit_em*>`       (Conjugating Complex 4-bit Multiplier Implemented in Dedicated Multipliers)

:doc:`cmult_4bit_em <src/blockdocs/Cmult_4bit_em>`     (Complex 4-bit Multiplier Implemented in Embedded Multipliers)

:doc:`cmult_4bit_sl* <src/blockdocs/Cmult_4bit_sl*>`       (Conjugating Complex 4-bit Multiplier Implemented in Slices)

:doc:`cmult_4bit_sl <src/blockdocs/Cmult_4bit_sl>`     (Complex 4-bit Multiplier Implemented in Slices)

:doc:`complex_addsub <src/blockdocs/Complex_addsub>`       (Complex Adder/Subtractor)

:doc:`c_to_ri <src/blockdocs/C_to_ri>`     (Complex to Real/Imaginary)

:doc:`DDS <src/blockdocs/Dds>`     (Direct Digital Synthesizer)

:doc:`dec_fir <src/blockdocs/Dec_fir>`     (Decimating FIR Filter)

:doc:`delay_bram_en_plus <src/blockdocs/Delay_bram_en_plus>`       (Enabled Delay in BlockRAM))

:doc:`delay_bram_prog <src/blockdocs/Delay_bram_prog>`     (Programmable Delay in BlockRAM)

:doc:`delay_bram <src/blockdocs/Delay_bram>`       (Delay in BlockRAM)

:doc:`delay_complex <src/blockdocs/Delay_complex>`     (Complex Delay)

:doc:`delay_slr <src/blockdocs/Delay_slr>`     (Delay in SLRs)

:doc:`delay_wideband_prog <src/blockdocs/Delay_wideband_prog>`     (Programmable Wideband Delay Implemented in BlockRAM)

:doc:`dram_vacc <src/blockdocs/Dram_vacc>`     (DRAM Vector Accumulator)

:doc:`dram_vacc_tvg <src/blockdocs/Dram_vacc_tvg>`     (DRAM Vector Accumulator Test Vector Generator)

:doc:`edge <src/blockdocs/Edge>`       (Edge Detect Block)

:doc:`fft_biplex_real_2x <src/blockdocs/Fft_biplex_real_2x>`       (Real-sampled Biplex FFT, with Output Demuxed by 2)

:doc:`fft_biplex_real_4x <src/blockdocs/Fft_biplex_real_4x>`       (Real-sampled Biplex FFT, with Output Demuxed by 4)

:doc:`fft <src/blockdocs/Fft>`     (Complex FFT)

:doc:`fft_wideband_real <src/blockdocs/Fft_wideband_real>`     (Real-sampled Wideband FFT)

:doc:`finedelay_fstop_prog <src/blockdocs/Finedelay_fstop_prog>`       (Programmable Fine delay along with Fringe Stop)

:doc:`finedelay_fstop_prog_cordic <src/blockdocs/Finedelay_fstop_prog_cordic>`     (Programmable Fine delay with Fringe Stop using CORDIC block)

:doc:`fir_col <src/blockdocs/Fir_col>`     (PFB FIR Column)

:doc:`fir_dbl_col <src/blockdocs/Fir_dbl_col>`     (PFB FIR Double Column)

:doc:`fir_tap <src/blockdocs/Fir_tap>`     (PFB FIR Tap)

:doc:`freeze_cntr <src/blockdocs/Freeze_cntr>`     (Freeze Counter)

:doc:`lo_const <src/blockdocs/Lo_const>`       (DC Local Oscillator)

:doc:`lo_osc <src/blockdocs/Lo_osc>`       (Local Oscillator)

:doc:`mixer <src/blockdocs/Mixer>`     (Mixer)

:doc:`negedge <src/blockdocs/Negedge>`     (Negative Edge Detector)

:doc:`partial_delay <src/blockdocs/Partial_delay>`     (Partial Delay)

:doc:`pfb_fir_real <src/blockdocs/Pfb_fir_real>`       (Real-sampled Polyphase FIR Filter Frontend for PFB)

:doc:`pfb_fir <src/blockdocs/Pfb_fir>`     (Polyphase FIR Filter Frontend for PFB)

:doc:`posedge <src/blockdocs/Posedge>`     (Positive Edge Detector)

:doc:`power <src/blockdocs/Power>`     (Complex Data Power Calculator)

:doc:`pulse_ext <src/blockdocs/Pulse_ext>`     (Pulse Extender)

:doc:`rcmult <src/blockdocs/Rcmult>`       (Real/Complex Multiplier)

:doc:`reorder <src/blockdocs/Reorder>`     (Arbitrary Reorderer)

:doc:`ri_to_c <src/blockdocs/Ri_to_c>`     (Real/Imaginary to Complex)

:doc:`square_transposer <src/blockdocs/Square_transposer>`     (Square Transposer)

:doc:`stopwatch <src/blockdocs/Stopwatch>`     (Stopwatch)

:doc:`sync_delay_en <src/blockdocs/Sync_delay_en>`     (Enabled Sync Delay)

:doc:`sync_delay_proc <src/blockdocs/Sync_delay_prog>`     (Programmable Sync Delay)

:doc:`sync_gen <src/blockdocs/Sync_gen>`       (Parameterized Sync Generator)

:doc:`win_x_engine <src/blockdocs/Win_x_engine>`       (Windowed X-Engine)

:doc:`xeng_tvg <src/blockdocs/Xeng_tvg>`       (X-Engine Test Vector Generator)

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Signal Processing Blocks

    src/blockdocs/Adder_tree
    src/blockdocs/Barrel_switcher
    src/blockdocs/Bit_reverse
    src/blockdocs/Cmult_4bit_br*
    src/blockdocs/Cmult_4bit_br
    src/blockdocs/Cmult_4bit_em*
    src/blockdocs/Cmult_4bit_em
    src/blockdocs/Cmult_4bit_sl*
    src/blockdocs/Cmult_4bit_sl
    src/blockdocs/Complex_addsub
    src/blockdocs/C_to_ri
    src/blockdocs/Dds
    src/blockdocs/Dec_fir
    src/blockdocs/Delay_bram_en_plus
    src/blockdocs/Delay_bram_prog
    src/blockdocs/Delay_bram
    src/blockdocs/Delay_complex
    src/blockdocs/Delay_slr
    src/blockdocs/Delay_wideband_prog
    src/blockdocs/Dram_vacc
    src/blockdocs/Dram_vacc_tvg
    src/blockdocs/Edge
    src/blockdocs/Fft_biplex_real_2x
    src/blockdocs/Fft_biplex_real_4x
    src/blockdocs/Fft
    src/blockdocs/Fft_wideband_real
    src/blockdocs/Finedelay_fstop_prog
    src/blockdocs/Finedelay_fstop_prog_cordic
    src/blockdocs/Fir_col
    src/blockdocs/Fir_dbl_col
    src/blockdocs/Fir_tap
    src/blockdocs/Freeze_cntr
    src/blockdocs/Lo_const
    src/blockdocs/Lo_osc
    src/blockdocs/Mixer
    src/blockdocs/Negedge
    src/blockdocs/Partial_delay
    src/blockdocs/Pfb_fir_real
    src/blockdocs/Pfb_fir
    src/blockdocs/Posedge
    src/blockdocs/Power
    src/blockdocs/Pulse_ext
    src/blockdocs/Rcmult
    src/blockdocs/Reorder
    src/blockdocs/Ri_to_c
    src/blockdocs/Square_transposer
    src/blockdocs/Stopwatch
    src/blockdocs/Sync_delay_en
    src/blockdocs/Sync_delay_prog
    src/blockdocs/Sync_gen
    src/blockdocs/Win_x_engine
    src/blockdocs/Xeng_tvg


Communication Blocks 
----------------------

:doc:`ten_gbe <src/blockdocs/Ten_GbE>`        (10GbE Transceiver)

:doc:`XAUI <src/blockdocs/XAUI>`      (XAUI Transceiver)

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Communication Blocks

    src/blockdocs/Ten_GbE
    src/blockdocs/XAUI

System Blocks 
---------------

:doc:`adc <src/blockdocs/Adc>`     (ADC)

:doc:`x64_adc <src/blockdocs/X64_adc>`     (64 Channel, 12 bit ADC: `64ADCx64-12 <src/blockdocs/64ADCx64-12.html>`__)

:doc:`dac <src/blockdocs/Dac>` (DAC)

:doc:`dram <src/blockdocs/Dram>`       (DRAM)

:doc:`gpio_bidir <src/blockdocs/gpio_bidir>` 	(Bi-directional GPIO)

:doc:`gpio <src/blockdocs/GPIO>`       (GPIO)

:doc:`qdr <src/blockdocs/Qdr>`     (QDR)

:doc:`snapshot <src/blockdocs/Snapshot>`       (Snapshot Capture)

:doc:`snap <src/blockdocs/Snap>`       (Snapshot Capture)

:doc:`snap64 <src/blockdocs/Snap64>`       (64-Bit Snapshot Capture)

:doc:`software_register <src/blockdocs/Software_register>`     (Software Register)

:doc:`sram <src/blockdocs/Sram>`       (SRAM)

:doc:`XSG core config <src/blockdocs/XSG_core_config>`     (XSG Core Config)

:doc:`Gaussian Random Number Generator <src/blockdocs/Gaussian_Random_Number_Gen>`     (Gaussian Random Number Generator)

:doc:`Correlation Control Block <src/blockdocs/Correlation_Control_Block>`     (CCB)

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: System Blocks

    src/blockdocs/Adc
    src/blockdocs/X64_adc
    src/blockdocs/64ADCx64-12
    src/blockdocs/Dac
    src/blockdocs/Dram
    src/blockdocs/gpio_bidir
    src/blockdocs/GPIO
    src/blockdocs/Qdr
    src/blockdocs/Snapshot
    src/blockdocs/Snap
    src/blockdocs/Snap64
    src/blockdocs/Software_register
    src/blockdocs/Sram
    src/blockdocs/XSG_core_config
    src/blockdocs/Gaussian_Random_Number_Gen
    src/blockdocs/Correlation_Control_Block
