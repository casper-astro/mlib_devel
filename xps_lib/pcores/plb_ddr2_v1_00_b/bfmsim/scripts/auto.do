
env /bfm_system/bfm_processor/bfm_processor/master/master/
force -deposit msize_mode 2#101

force -deposit root_seed  1

env /bfm_system/bfm_processor/bfm_processor/master/master/decoder
change plb_master_command_mode_temp(3) 1

change plb_master_command_mode_temp(0) 1
change plb_master_command_mode_temp(3) 1

env /bfm_system/bfm_processor/bfm_processor/master/master/
force -deposit generic_load 0
force -deposit plb_master_addr0_lo  16#0000000000000000

force -deposit generic_load 0
force -deposit plb_master_addr0_hi  16#000000003fffff7f

env /bfm_system/bfm_processor/bfm_processor/master/master/decoder
change size0_min 0

change size0_max 15

change size_probability_mode 1
change single_probability 20

change size_probability_mode 1
change line_probability 40

change size_probability_mode 1
change burst_probability 40

change burst_count_min 1

change burst_count_max 16

change fixed_burst_probability 1

change fixed_burst_count_min 2

change fixed_burst_count_max 32

change fixed_burst_abort_probability 16

change lock_probability 1000

env /
