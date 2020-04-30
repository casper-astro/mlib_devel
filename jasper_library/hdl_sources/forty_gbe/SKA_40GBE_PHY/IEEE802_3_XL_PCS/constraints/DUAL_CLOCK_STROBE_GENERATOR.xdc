set_multicycle_path -setup -start -from [get_pins {strobe_flag_slow_reg[1]/C}] -to [get_pins {strobe_flag_async_reg[0]/D}] 2
set_multicycle_path -hold -start -from [get_pins {strobe_flag_slow_reg[1]/C}] -to [get_pins {strobe_flag_async_reg[0]/D}] 3
