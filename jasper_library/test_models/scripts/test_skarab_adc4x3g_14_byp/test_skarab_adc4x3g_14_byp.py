#---------------------------------------------------------------------------
# COMPANY              : PERALEX ELECTRONICS (PTY) LTD
#---------------------------------------------------------------------------
# COPYRIGHT NOTICE :
#
# The copyright, manufacturing and patent rights stemming from this document
# in any form are vested in PERALEX ELECTRONICS (PTY) LTD.
#
# (c) PERALEX ELECTRONICS (PTY) LTD 2021
#
# PERALEX ELECTRONICS (PTY) LTD has ceded these rights to its clients
# where contractually agreed.
#---------------------------------------------------------------------------
# DESCRIPTION :
#
# This script is used to perform synchronised ADC data captures on (1 to 4) 
# SKARABs. The captured data is written to text files so that it can be
# plotted by the plot_adc_data.m script.
#
# Please do the following before running this script
#   - Ensure each SKARAB is be populated with a PI-12533.02G SKARAB 
#     ADC32RF45X2 Mezzanine Module.
#   - Create an fpg file from the test model in mlib_devel/jasper_library/
#     test_models/test_skarab_adc_byp.slx
#   - Set up the hardware test configuration as described in the SKARAB 
#     4X3G-14 DAQ 2M Client Qualification Acceptance Test Procedure 
#     Document (please contact Peralex Electronics for a copy of this
#     document)
# 	- Set the script configuration (under "1. SCRIPT CONFIG")
# 
#---------------------------------------------------------------------------

import casperfpga
from casperfpga import skarab_definitions as sd
import time

# ---------------------------------------------------------------
# 1. SCRIPT CONFIG
# ---------------------------------------------------------------
# SET FPG FILE DIRECTORY
fpg_file_dir = 'test_skarab_adc_byp_2021-02-23_1313.fpg'
# SET THE MEZZANINE SITE (0 TO 3)
mezzanine_site = 2
# SET NUMBER OF SKARABS (1 TO 4)
skarab_num = 1
# SET SKARAB IPS
skarab_ips = ['10.0.7.3', '10.0.7.4', '10.0.7.5', '10.0.7.6']

# ---------------------------------------------------------------
# 2. CONNECT TO SKARAB HARDWARE AND UPLOAD FPG FILE (ALL SKARABS)
# ---------------------------------------------------------------
skarabs = [None] * 4
skarabs[0] = casperfpga.CasperFpga(skarab_ips[0])
skarabs[0].upload_to_ram_and_program(fpg_file_dir)

# ---------------------------------------------------------------
# 3. CONFIGURE  IN TEST PATTERN MODE; DEBUGGING ONLY (ALL SKARABS)
# ---------------------------------------------------------------
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x69);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_A_CTRL_K, 0x80);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_B_CTRL_K, 0x80);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_A_LINK_LAYER_TESTMODE, 0x01);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_B_LINK_LAYER_TESTMODE, 0x01);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x69);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_A_CTRL_K, 0x80); 
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_B_CTRL_K, 0x80);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_A_LINK_LAYER_TESTMODE, 0x01);
# skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_B_LINK_LAYER_TESTMODE, 0x01);

# ---------------------------------------------------------------
# 4. ARM THE BLOCK CAPTURE COMPONENTS (ALL SKARABS)
# ---------------------------------------------------------------
print("\nStarting synchronised ADC data capture")
skarabs[0].snapshots.adc0_bc_l_ss.arm()
skarabs[0].snapshots.adc0_bc_h_ss.arm()
skarabs[0].snapshots.adc1_bc_l_ss.arm()
skarabs[0].snapshots.adc1_bc_h_ss.arm()
skarabs[0].snapshots.adc2_bc_l_ss.arm()
skarabs[0].snapshots.adc2_bc_h_ss.arm()
skarabs[0].snapshots.adc3_bc_l_ss.arm()
skarabs[0].snapshots.adc3_bc_h_ss.arm()
skarabs[0].write_int('adc_trig', 1)

# ---------------------------------------------------------------
# 5. RESET YELLOW BLOCK REGISTERS (MASTER SKARAB)
# ---------------------------------------------------------------
skarabs[0].write_int('pll_sync_start_in', 0)
skarabs[0].write_int('pll_pulse_gen_start_in', 0)
skarabs[0].write_int('adc_sync_start_in', 0)
skarabs[0].write_int('adc_sync_part2_start_in', 0)
skarabs[0].write_int('adc_sync_part3_start_in', 0)
skarabs[0].write_int('adc_trig', 0)	

# ---------------------------------------------------------------
# 6. EMBEDDED SOFTWARE VERSION CHECK (ALL SKARABS)
# ---------------------------------------------------------------
# <TEMPROARY
skarab_index = 0
# TEMPROARY>

i2c_interface = mezzanine_site + 1
skarabs[0].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.ADC_FIRMWARE_MAJOR_VERSION_REG)
major_version = skarabs[0].transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)
skarabs[0].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.ADC_FIRMWARE_MINOR_VERSION_REG)
minor_version = skarabs[0].transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)
if (major_version==1 and minor_version==7):
	print(str("ERROR: SKARAB " + str(skarab_index) +  " SKARAB ADC board not programmed with embedded software version 1.7"))
	exit()

# ---------------------------------------------------------------
# 7. REFERENCE CLOCK CHECK (ALL SKARABS)
# ---------------------------------------------------------------
i2c_interface = mezzanine_site + 1
skarabs[0].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.HOST_PLL_GPIO_CONTROL_REG)
read_byte = skarabs[0].transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)
if ((read_byte[0] & 0x01) == 0x01):
	print(str("ERROR: SKARAB " + str(skarab_index) +  " reporting loss of reference"))
	exit()

# ---------------------------------------------------------------
# 8. PREPARE PLL SYNC (ALL SKARABS)
# ---------------------------------------------------------------
# 8.1 CHANGE SYNC PIN TO SYNC SOURCE
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x41)
# 8.2 CHANGE SYSREF TO PULSE GEN MODE
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_FORCE_MUTE, 0x88)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_FORCE_MUTE, 0x88)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)
# 8.3 ENABLE PLL SYNC
i2c_interface = mezzanine_site + 1
skarabs[0].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, sd.ENABLE_PLL_SYNC)

# ---------------------------------------------------------------
# 9. PERFORM PLL SYNC (MASTER SKARAB)
# ---------------------------------------------------------------
# 9.1 TRIGGER PLL SYNC
skarabs[0].write_int('pll_sync_start_in', 0)
skarabs[0].write_int('pll_sync_start_in', 1)
# 9.2 WAIT FOR PLL SYNC COMPLETION
timeout = 0
read_reg = skarabs[0].read_int('pll_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[0].read_int('pll_sync_complete_out')
	timeout = timeout + 1
if timeout == 100:
	print("ERROR: Master SKARAB PLL SYNC timeout")
	exit()

# ---------------------------------------------------------------
# 10. CHECK SYNC STATUS (ALL SKARABS)
# ---------------------------------------------------------------
spi_read_word = skarabs[0].transport.direct_spi_read(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
timeout = 0
while (((spi_read_word & sd.PLL_CLOCK_OUTPUT_PHASE_STATUS) == 0x0) and (timeout < 1000)):
	spi_read_word = skarabs[0].transport.direct_spi_read(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
	timeout = timeout + 1
if timeout == 1000:
	print(str("ERROR: SKARAB " + str(skarab_index) +  " check SYNC status timeout"))
	exit()

# ---------------------------------------------------------------
# 11. PREPARE LMFC ALIGN (ALL SKARABS)
# ---------------------------------------------------------------
# 11.1 CHANGE SYNC PIN TO PULSE GENERATOR
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x81)
# 11.2 POWER UP ADC SYSREF INPUT BUFFERS
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_MASTER_PDN_SYSREF, 0x00)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_MASTER_PDN_SYSREF, 0x00)

# ---------------------------------------------------------------
# 12. PERFORM LMFC ALIGN (MASTER SKARAB)
# ---------------------------------------------------------------
# 12.1 TRIGGER PULSE GENERATION
skarabs[0].write_int('pll_pulse_gen_start_in', 0)
skarabs[0].write_int('pll_pulse_gen_start_in', 1)
# 12.2 WAIT FOR PULSE GENERATION TO COMPLETE
timeout = 0
read_reg = skarabs[0].read_int('pll_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[0].read_int('pll_sync_complete_out')
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: Master SKARAB LMFC align timeout"))
	exit()
	
# ---------------------------------------------------------------
# 13. POWER DOWN SYSREF BUFFERS (ALL SKARABS)
# ---------------------------------------------------------------
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_MASTER_PDN_SYSREF, 0x10)
skarabs[0].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_MASTER_PDN_SYSREF, 0x10)

# ---------------------------------------------------------------
# 14. PREPARE ADC SYNC (ALL SKARABS)
# ---------------------------------------------------------------
i2c_interface = mezzanine_site + 1
skarabs[0].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, sd.ENABLE_ADC_SYNC)

# ---------------------------------------------------------------
# 15. ADC SYNC PART 1 (ALL SKARABS)
# ---------------------------------------------------------------
# 15.1 TRIGGER ADC SYNC PART 1
skarabs[0].write_int('adc_sync_start_in', 0)
skarabs[0].write_int('adc_sync_start_in', 1)
# 15.2 WAIT FOR ADC SYNC PART 1 COMPLETION
timeout = 0
read_reg = skarabs[0].read_int('adc_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[0].read_int('adc_sync_complete_out')
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: SKARAB " + str(skarab_index) +  " ADC SYNC PART 1 timeout"))
	exit()

# ---------------------------------------------------------------
# 16. WAIT FOR SYNC REQUEST ASSERT (ALL SKARABS)
# ---------------------------------------------------------------
timeout = 0
read_reg = skarabs[0].read_int('adc_sync_request_out')
while ((read_reg != 0xF) and (timeout < 100)):
	read_reg = skarabs[0].read_int('adc_sync_request_out')
	time.sleep(0.1)
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: SKARAB " + str(skarab_index) +  " wait for SYNC request assert timeout"))
	exit()

# ---------------------------------------------------------------
# 17. ADC SYNC PART 2 (MASTER SKARAB)
# ---------------------------------------------------------------
# 17.1 TRIGGER ADC SYNC PART 2
skarabs[0].write_int('adc_sync_part2_start_in', 0)
skarabs[0].write_int('adc_sync_part2_start_in', 1)
# 17.2 WAIT FOR ADC SYNC PART 2 COMPLETION
timeout = 0
read_reg = skarabs[0].read_int('adc_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[0].read_int('adc_sync_complete_out')
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: Master SKARAB wait for ADC SYNC PART 2 timeout"))
	exit()
	
# ---------------------------------------------------------------
# 18. WAIT FOR SYNC REQUEST DE-ASSERT (ALL SKARABS)
# ---------------------------------------------------------------
timeout = 0
read_reg = skarabs[0].read_int('adc_sync_request_out')
while ((read_reg != 0) and (timeout < 100)):
	read_reg = skarabs[0].read_int('adc_sync_request_out')
	time.sleep(0.1)
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: SKARAB " + str(skarab_index) +  " wait for SYNC request de-assert timeout"))
	exit()

# ---------------------------------------------------------------
# 19. ADC SYNC PART 3 (MASTER SKARAB)
# ---------------------------------------------------------------
# 19.1 TRIGGER ADC SYNC PART 3
skarabs[0].write_int('adc_sync_part3_start_in', 0)
skarabs[0].write_int('adc_sync_part3_start_in', 1)
# 19.2 WAIT FOR ADC SYNC PART 3 COMPLETION
timeout = 0
read_reg = skarabs[0].read_int('adc_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[0].read_int('adc_sync_complete_out')
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: Master SKARAB wait for ADC SYNC PART 3 timeout"))
	exit()

# ---------------------------------------------------------------
# 20. DISABLE THE ADC SYNC (ALL SKARABS)
# ---------------------------------------------------------------
i2c_interface = mezzanine_site + 1
skarabs[0].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, 0x0)

# ---------------------------------------------------------------
# 21. ADC STATUS REGISTER CHECK (ALL SKARABS)
# ---------------------------------------------------------------
adc0_status_out = skarabs[0].read_uint('adc0_status_out')
adc1_status_out = skarabs[0].read_uint('adc1_status_out')
adc2_status_out = skarabs[0].read_uint('adc2_status_out')
adc3_status_out = skarabs[0].read_uint('adc3_status_out')
if (adc0_status_out != 0xE0000000 or adc1_status_out != 0xE0000000 or adc2_status_out != 0xE0000000 or adc3_status_out != 0xE0000000):				
	print(str("ERROR: SKARAB " + str(skarab_index) +  " status register invalid"))
	print(str("ADC 0 STATUS REG: " + str(hex(adc0_status_out))))
	print(str("ADC 1 STATUS REG: " + str(hex(adc1_status_out))))
	print(str("ADC 2 STATUS REG: " + str(hex(adc2_status_out))))
	print(str("ADC 3 STATUS REG: " + str(hex(adc3_status_out))))
	exit()
	
# ---------------------------------------------------------------
# 22. ADC/PLL SYNC ERROR CHECK (MASTER SKARAB)
# ---------------------------------------------------------------
if skarabs[0].read_int('pll_sync_complete_out') != 1:
	print(str("ERROR: PLL SYNC COULD NOT COMPLETE"))
if skarabs[0].read_int('adc_sync_complete_out') != 1:
	print(str("ERROR: ADC SYNC COULD NOT COMPLETE"))

# -------------------------------------------------
# 23. WRITE CAPTURED ADC DATA TO FILE (ALL SKARABS)
# -------------------------------------------------
bc_keylist = ['d0','d1','d2','d3','d4','d5','d6','d7','d8','d9','d10','d11','d12','d13','d14','d15']
filename_list = ["adc_data/sk0_adc0_data.txt", "adc_data/sk0_adc1_data.txt", "adc_data/sk0_adc2_data.txt", "adc_data/sk0_adc3_data.txt"]
adc_bc_l_array = [skarabs[0].snapshots.adc0_bc_l_ss.read(arm=False)['data'], skarabs[0].snapshots.adc1_bc_l_ss.read(arm=False)['data'], skarabs[0].snapshots.adc2_bc_l_ss.read(arm=False)['data'], skarabs[0].snapshots.adc3_bc_l_ss.read(arm=False)['data']]
adc_bc_h_array = [skarabs[0].snapshots.adc0_bc_h_ss.read(arm=False)['data'], skarabs[0].snapshots.adc1_bc_h_ss.read(arm=False)['data'], skarabs[0].snapshots.adc2_bc_h_ss.read(arm=False)['data'], skarabs[0].snapshots.adc3_bc_h_ss.read(arm=False)['data']]
for p in range(4):
	adc_bc_file = open(filename_list[p], "w")
	for i in range(256):
		for j in range(8):
			adc_bc_file.write(str(str(adc_bc_l_array[p][bc_keylist[j]][i]) + "\n"))
		for j in range(8,16):
			adc_bc_file.write(str(str(adc_bc_h_array[p][bc_keylist[j]][i]) + "\n"))
	adc_bc_file.close()
print("Successfully captured synchronised ADC data")