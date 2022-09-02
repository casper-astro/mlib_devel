# IO constraints
# ------------------------------------------------------------------------------

# Satellite UART
set_property PACKAGE_PIN BB26                    [get_ports satellite_uart_0_rxd]
set_property -dict {IOSTANDARD LVCMOS18}         [get_ports satellite_uart_0_rxd]
set_property PACKAGE_PIN BB25                    [get_ports satellite_uart_0_txd]
set_property -dict {IOSTANDARD LVCMOS18 DRIVE 4} [get_ports satellite_uart_0_txd]

# MSP GPIO (Sateliite GPIO)
set_property PACKAGE_PIN C16                     [get_ports satellite_gpio_0[0]]
set_property -dict {IOSTANDARD LVCMOS18}         [get_ports satellite_gpio_0[0]]
set_property PACKAGE_PIN C17                     [get_ports satellite_gpio_0[1]]
set_property -dict {IOSTANDARD LVCMOS18}         [get_ports satellite_gpio_0[1]]