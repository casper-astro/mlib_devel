set_multicycle_path -setup -start -to [get_pins {DATA_O_reg*/D}] 2
set_multicycle_path -hold -start -to [get_pins {DATA_O_reg*/D}] 3

set_multicycle_path -setup -start -from [get_pins {data_valid_d2_flag_reg/C}] -to [get_pins {DATA_VALID_O_reg/D}] 2
set_multicycle_path -hold -start -from [get_pins {data_valid_d2_flag_reg/C}] -to [get_pins {DATA_VALID_O_reg/D}] 3

set_multicycle_path -setup -start -from [get_pins {data_valid_d2_flag_reg/C}] -to [get_pins {data_valid_d2_flag_old_reg/D}] 2
set_multicycle_path -hold -start -from [get_pins {data_valid_d2_flag_reg/C}] -to [get_pins {data_valid_d2_flag_old_reg/D}] 3

set_multicycle_path -setup -start -from [get_pins {TX5/DUAL_CLK_STROBE_inst/strobe_flag_slow_reg[1]/C}] -to [get_pins {TX5/DUAL_CLK_STROBE_inst/strobe_flag_async_reg[0]/D}] 2
set_multicycle_path -hold -start -from [get_pins {TX5/DUAL_CLK_STROBE_inst/strobe_flag_slow_reg[1]/C}] -to [get_pins {TX5/DUAL_CLK_STROBE_inst/strobe_flag_async_reg[0]/D}] 3

