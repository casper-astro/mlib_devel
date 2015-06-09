# System clock, 100MHz
create_clock -period 5.000 -name sysclk200 [get_ports sysclk_p]

set_property PACKAGE_PIN T26 [get_ports miso]
set_property IOSTANDARD LVCMOS18 [get_ports miso]
set_property PACKAGE_PIN R26 [get_ports mosi]
set_property IOSTANDARD LVCMOS18 [get_ports mosi]
set_property PACKAGE_PIN R29 [get_ports sclk]
set_property IOSTANDARD LVCMOS18 [get_ports sclk]
set_property PACKAGE_PIN P29 [get_ports cs_n]
set_property IOSTANDARD LVCMOS18 [get_ports cs_n]

set_property PACKAGE_PIN AR21 [get_ports sysclk_p]
set_property IOSTANDARD LVDS [get_ports sysclk_p]
set_property PACKAGE_PIN AT21 [get_ports sysclk_n]
set_property IOSTANDARD LVDS [get_ports sysclk_n]
