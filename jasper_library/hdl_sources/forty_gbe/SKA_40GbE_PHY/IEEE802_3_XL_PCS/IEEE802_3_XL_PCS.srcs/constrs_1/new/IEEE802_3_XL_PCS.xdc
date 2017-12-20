set_false_path -to [get_pins {THROTTLE_STROBE_SR_reg[0]/D}]

set_false_path -to [get_pins {XL_TX_CLK_161M133_RST_reg/PRE}]

set_false_path -from [get_pins {lanes_RX1[*].RX1_ctrl/BLOCK_LOCK_O_reg/C}] -to [get_pins {BLOCK_LOCK_RX1_SR_reg[0][*]/D}]

set_false_path -from [get_pins {RX3/lanes[*].inst/AM_LOCK_O_reg/C}] -to [get_pins {AM_LOCK_SR_reg[0][*]/D}]
set_false_path -from [get_pins {BLOCK_LOCK_RX1_SR_reg[3][*]/C}] -to [get_pins {BLOCK_LOCK_SR_reg[0][*]/D}]
set_false_path -from [get_pins RX4/ALIGN_STATUS_O_reg/C] -to [get_pins ALIGN_STATUS_SR_reg[0]/D]
set_false_path -from [get_pins RX6/BIP_ERROR_O_reg/C] -to [get_pins BIP_ERROR_SR_reg[0]/D]

set_false_path -to [get_pins {TEST_PATTERN_ERROR_QUAD_SR_reg[0][*]/D}]
set_false_path -to [get_pins {TEST_PATTERN_EN_SR_reg[0]/D}]

set_false_path  -to [get_pins {ENCODER_START_DETECTED_SR_reg[0]/D}]
set_false_path  -to [get_pins {ENCODER_TERMINATE_DETECTED_SR_reg[0]/D}]
set_false_path  -to [get_pins {DECODER_START_DETECTED_SR_reg[0]/D}]
set_false_path  -to [get_pins {DECODER_TERMINATE_DETECTED_SR_reg[0]/D}]
