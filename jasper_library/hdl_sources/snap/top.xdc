# System clock, 100MHz
create_clock -period 5.000 -name sysclk200 [get_ports sysclk_p]

set_property PACKAGE_PIN K20 [get_ports miso]
set_property IOSTANDARD LVCMOS33 [get_ports miso]
set_property PACKAGE_PIN J20 [get_ports mosi]
set_property IOSTANDARD LVCMOS33 [get_ports mosi]
set_property PACKAGE_PIN E17 [get_ports sclk]
set_property IOSTANDARD LVCMOS33 [get_ports sclk]
set_property PACKAGE_PIN G19 [get_ports cs_n]
set_property IOSTANDARD LVCMOS33 [get_ports cs_n]

#LED0 D13
#LED1 D14
#LED2 E12
#LED3 E13

set_property PACKAGE_PIN E10 [get_ports sysclk_p]
set_property IOSTANDARD LVDS_25 [get_ports sysclk_p]
set_property PACKAGE_PIN D10 [get_ports sysclk_n]
set_property IOSTANDARD LVDS_25 [get_ports sysclk_n]
