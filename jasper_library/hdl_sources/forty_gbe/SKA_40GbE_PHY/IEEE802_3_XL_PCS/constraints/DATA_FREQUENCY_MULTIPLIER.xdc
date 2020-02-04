set_multicycle_path -setup -end -from [get_pins {data_d1_reg*/C}] 2
set_multicycle_path -hold -end -from [get_pins {data_d1_reg*/C}] 3

set_multicycle_path -setup -end -from [get_pins {data_valid_d1_flag_reg/C}] -to [get_pins {data_valid_d2_flag_reg/D}] 2
set_multicycle_path -hold -end -from [get_pins {data_valid_d1_flag_reg/C}] -to [get_pins {data_valid_d2_flag_reg/D}] 3

set_multicycle_path -setup -end -from [get_pins {data_valid_d2_flag_reg/C}] -to [get_pins {data_valid_d2_flag_old_reg/D}] 2
set_multicycle_path -hold -end -from [get_pins {data_valid_d2_flag_reg/C}] -to [get_pins {data_valid_d2_flag_old_reg/D}] 3