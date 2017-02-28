create_clock -period 4.300 -name sysclk200 [get_ports sysclk_p]

set_property PACKAGE_PIN H27 [get_ports miso]
set_property IOSTANDARD LVCMOS18 [get_ports miso]
set_property PACKAGE_PIN D27 [get_ports mosi]
set_property IOSTANDARD LVCMOS18 [get_ports mosi]
set_property PACKAGE_PIN E27 [get_ports sclk]
set_property IOSTANDARD LVCMOS18 [get_ports sclk]
set_property PACKAGE_PIN K29 [get_ports cs_n]
set_property IOSTANDARD LVCMOS18 [get_ports cs_n]

set_property PACKAGE_PIN AU11 [get_ports sysclk_p]
set_property IOSTANDARD LVDS [get_ports sysclk_p]
set_property PACKAGE_PIN AU10 [get_ports sysclk_n]
set_property IOSTANDARD LVDS [get_ports sysclk_n]

