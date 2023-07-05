# this is a scrip to facilitate the testing of the skatab 1gbe cores
# it is a manual process and you will need to adjust the IPs accordingly
# the read of the rx_eof just checks whether packets are being received
# if you wish to check the data you will need to read the snapblocks
# and manually compair the date to the tx design

t = casperfpga.CasperFpga("192.168.14.28")
r = casperfpga.CasperFpga("192.168.14.30")

t.get_system_information("forty_gbe_testing/skarab_1gbe_tx_test_2020-07-24_1016.fpg")
r.get_system_information("forty_gbe_testing/skarab_1gbe_rx_test_2020-07-24_0950.fpg")

dest_port = 7777
dest_ip = 192*(2**24) + 168*(2**16) + 14*(2**8) + 30
pkt_period = 1024
payload_len = 128

t.write_int('tx_ip', dest_ip)
t.write_int('tx_port', dest_port)

t.registers.tx_control.write(pkt_len=160)
clk_ghz = t.estimate_fpga_clock()/1000

rate = 2
decimation = int((clk_ghz * 256.0 / rate) + 1)
t.registers.decimation.write(reg=decimation)

for i in range(20):
     print(hex(t.transport.read_wishbone(0xDC000 + 4*i)))

for i in range(20):
     print(hex(r.transport.read_wishbone(0xDC000 + 4*i)))

r.transport.write_wishbone(0xdc000 + 4*0xc, dest_port)

t.registers.tx_control.write(tx_en=1, pkt_rst='pulse')

r.read_int('rx_eof')

