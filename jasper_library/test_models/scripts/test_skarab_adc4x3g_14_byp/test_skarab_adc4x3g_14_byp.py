#--------------------------------------------------------------------------------------
# COMPANY              : PERALEX ELECTRONICS (PTY) LTD
#--------------------------------------------------------------------------------------
# COPYRIGHT NOTICE :
#
# The copyright, manufacturing and patent rights stemming from this document
# in any form are vested in PERALEX ELECTRONICS (PTY) LTD.
#
# (c) PERALEX ELECTRONICS (PTY) LTD 2021
#
# PERALEX ELECTRONICS (PTY) LTD has ceded these rights to its clients
# where contractually agreed.
#--------------------------------------------------------------------------------------
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
#   - Set up the hardware test configuration as described in:
#     https://casper-tutorials.readthedocs.io/en/latest/tutorials/skarab/tut_adc.html
#   - Set the script configuration (under "1. SCRIPT CONFIG")
# 
#--------------------------------------------------------------------------------------

import casperfpga
from casperfpga import skarab_definitions as sd
import time


# ---------------------------------------------------------------
# FUNCTIONS
# ---------------------------------------------------------------
def get_wb_addresses(filename):
    """
    Read the meta information from the FPG file.
    :param filename: the name of the fpg file to parse
    :return: device info dictionary, memory map info (coreinfo.tab) dictionary
    """
    if filename is not None:
        fptr = open(filename, 'r')
        firstline = fptr.readline().strip().rstrip('\n')
        if firstline != '#!/bin/kcpfpg':
            fptr.close()
            raise RuntimeError('%s does not look like an fpg file we can '
                               'parse.' % filename)
    else:
        raise IOError('No such file %s' % filename)
    memorydict = {}
    metalist = []
    while True:
        line = fptr.readline().strip().rstrip('\n')
        if line.lstrip().rstrip() == '?quit':
            break
        elif line.startswith('?meta'):
            # some versions of mlib_devel may mistakenly have put spaces
            # as delimiters where tabs should have been used. Rectify that
            # here.
            if line.startswith('?meta '):
                line = line.replace(' ', '\t')
            # and carry on as usual.
            line = line.replace('\_', ' ').replace('?meta', '')
            line = line.replace('\n', '').lstrip().rstrip()
            #line_split = line.split('\t')
            # Rather split on any space
            line_split = line.split()
            name = line_split[0]
            tag = line_split[1]
            param = line_split[2]
            if len(line_split[3:]) == 1:
                value = line_split[3:][0]
            else:
                value = ' '.join(line_split[3:])
            # name, tag, param, value = line.split('\t')
            name = name.replace('/', '_')
            metalist.append((name, tag, param, value))
        elif line.startswith('?register'):
            if line.startswith('?register '):
                register = line.replace('\_', ' ').replace('?register ', '')
                register = register.replace('\n', '').lstrip().rstrip()
                name, address, size_bytes = register.split(' ')
            elif line.startswith('?register\t'):
                register = line.replace('\_', ' ').replace('?register\t', '')
                register = register.replace('\n', '').lstrip().rstrip()
                name, address, size_bytes = register.split('\t')
            else:
                raise ValueError('Cannot find ?register entries in '
                                 'correct format.')
            address = int(address, 16)
            size_bytes = int(size_bytes, 16)
            if name in memorydict.keys():
                raise RuntimeError('%s: mem device %s already in '
                                   'dictionary' % (filename, name))
            memorydict[name] = {'address': address, 'bytes': size_bytes}
    fptr.close()
    return memorydict

# ---------------------------------------------------------------
# DEFINITIONS
# ---------------------------------------------------------------
# WB REGISTER DEFINITIONS
REGADR_WR_ADC_SYNC_START       = 0x00
REGADR_WR_ADC_SYNC_PART2_START = 0x04
REGADR_WR_ADC_SYNC_PART3_START = 0x08
REGADR_WR_PLL_SYNC_START       = 0x0C
REGADR_WR_PLL_PULSE_GEN_START  = 0x10
REGADR_WR_MEZZANINE_RESET      = 0x14
REGADR_RD_ADC0_STATUS          = 0x18
REGADR_RD_ADC1_STATUS          = 0x1C
REGADR_RD_ADC2_STATUS          = 0x20
REGADR_RD_ADC3_STATUS          = 0x24
REGADR_RD_ADC_SYNC_COMPLETE    = 0x28
REGADR_RD_PLL_SYNC_COMPLETE    = 0x2C
REGADR_RD_ADC_SYNC_REQUEST     = 0x30 

# ---------------------------------------------------------------
# 1. SCRIPT CONFIG
# ---------------------------------------------------------------
# SET FPG FILE DIRECTORY
fpg_file_dir = 'test_skarab_adc_byp_2021-03-03_1304.fpg'
# SET THE MEZZANINE SITE (0 TO 3)
mezzanine_site = 2
# SET NUMBER OF SKARABS (1 TO 4)
skarab_num = 4
# SET MASTER SKARAB INDEX
mst_sk_i = 0
# SET SKARAB IPS
skarab_ips = ['10.0.7.2', '10.0.7.3', '10.0.7.4', '10.0.7.5']

# ---------------------------------------------------------------
# 2. CONNECT TO SKARAB HARDWARE AND UPLOAD FPG FILE (ALL SKARABS)
# ---------------------------------------------------------------
print("----------------------------------------------")
print("Multi-SKARAB Synchronised Sampling Test Script")
print("----------------------------------------------")
usr_input = raw_input("Upload FPG file? (y/n): ")
skarabs = [None] * 4
WB_BASEADR = 0x7FFFFFFF & get_wb_addresses(fpg_file_dir)['skarab_adc4x3g14_byp']['address']
for i in range(skarab_num):
	skarabs[i] = casperfpga.CasperFpga(skarab_ips[i])
	if usr_input.lower() == 'y':
		skarabs[i].upload_to_ram_and_program(fpg_file_dir)
	else:
		skarabs[i].get_system_information(fpg_file_dir)
if usr_input.lower() == 'y':
	print("\nFPG files uploaded to SKARAB(s) successfully")
print("")
raw_input("Press Enter to continue with the ADC data captures")

# ---------------------------------------------------------------
# 3. CONFIGURE IN TEST PATTERN MODE; DEBUGGING ONLY (ALL SKARABS)
# ---------------------------------------------------------------
#print(Configuring test pattern mode...)
#for i in range(skarab_num):
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x69);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_A_CTRL_K, 0x90);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_B_CTRL_K, 0x90);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_A_LINK_LAYER_TESTMODE, 0x00);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_JESD_CHAN_B_LINK_LAYER_TESTMODE, 0x00);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_DIGITAL_BANK_PAGE_SEL_LSB, 0x00);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_DIGITAL_BANK_PAGE_SEL_MID, 0x00);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_DIGITAL_BANK_PAGE_SEL_MSB, 0x69);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_A_CTRL_K, 0x90); 
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_B_CTRL_K, 0x90);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_A_LINK_LAYER_TESTMODE, 0x00);
#	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_JESD_CHAN_B_LINK_LAYER_TESTMODE, 0x00);

# ---------------------------------------------------------------
# 4. RESET YELLOW BLOCK REGISTERS (ALL SKARABS)
# ---------------------------------------------------------------
print("Resetting registers...")
for i in range(skarab_num):
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_START      , 0) #skarabs[i].write_int('adc_sync_start_in', 0)
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_PART2_START, 0) #skarabs[i].write_int('adc_sync_part2_start_in', 0)
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_PART3_START, 0) #skarabs[i].write_int('adc_sync_part3_start_in', 0)
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_PLL_SYNC_START      , 0) #skarabs[i].write_int('pll_sync_start_in', 0)
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_PLL_PULSE_GEN_START , 0) #skarabs[i].write_int('pll_pulse_gen_start_in', 0)
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_MEZZANINE_RESET     , 0) #skarabs[i].write_int('mezzanine_reset_in', 0)
	skarabs[i].write_int('adc_trig', 0)

# ---------------------------------------------------------------
# 5. EMBEDDED SOFTWARE VERSION CHECK (ALL SKARABS)
# ---------------------------------------------------------------
print("Checking embedded software version...")
for i in range(skarab_num):
	i2c_interface = mezzanine_site + 1
	skarabs[i].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.ADC_FIRMWARE_MAJOR_VERSION_REG)
	major_version = skarabs[i].transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)[0]
	skarabs[i].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.ADC_FIRMWARE_MINOR_VERSION_REG)
	minor_version = skarabs[i].transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)[0]
	if not (major_version==1 and minor_version>=7):
		print(str("ERROR: SKARAB " + str(i) +  " SKARAB ADC board not programmed with correct software version"))
		exit()

# ---------------------------------------------------------------
# 6. REFERENCE CLOCK CHECK (ALL SKARABS)
# ---------------------------------------------------------------
print("Checking reference clock...")
for i in range(skarab_num):
	i2c_interface = mezzanine_site + 1
	skarabs[i].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.HOST_PLL_GPIO_CONTROL_REG)
	read_reg = skarabs[i].transport.read_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, 1)[0]
	if ((read_reg & 0x01) == 0x01):
		print(str("ERROR: SKARAB " + str(i) +  " reporting loss of reference"))
		exit()

# ---------------------------------------------------------------
# 7. PREPARE PLL SYNC (ALL SKARABS)
# ---------------------------------------------------------------
print("Preparing PLL sync...")
for i in range(skarab_num):
	# 7.1 CHANGE SYNC PIN TO SYNC SOURCE
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x41)
	# 7.2 CHANGE SYSREF TO PULSE GEN MODE
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_FORCE_MUTE, 0x88)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_FORCE_MUTE, 0x88)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_3_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_CHANNEL_OUTPUT_7_CONTROL_HIGH_PERFORMANCE_MODE, 0xDD)
	# 7.3 ENABLE PLL SYNC
	i2c_interface = mezzanine_site + 1
	skarabs[i].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, sd.ENABLE_PLL_SYNC)

# ---------------------------------------------------------------
# 8. PERFORM PLL SYNC (MASTER SKARAB)
# ---------------------------------------------------------------
print("Performing PLL sync...")
# 8.1 TRIGGER PLL SYNC
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_PLL_SYNC_START, 0) #skarabs[mst_sk_i].write_int('pll_sync_start_in', 0)
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_PLL_SYNC_START, 1) #skarabs[mst_sk_i].write_int('pll_sync_start_in', 1)
# 8.2 WAIT FOR PLL SYNC COMPLETION
timeout = 0
read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_PLL_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('pll_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_PLL_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('pll_sync_complete_out')
	time.sleep(0.1)
	timeout = timeout + 1
if timeout == 100:
	print("ERROR: Master SKARAB PLL SYNC timeout")
	exit()

# ---------------------------------------------------------------
# 9. CHECK SYNC STATUS (ALL SKARABS)
# ---------------------------------------------------------------
print("Checking sync status...")
for i in range(skarab_num):
	spi_read_word = skarabs[i].transport.direct_spi_read(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
	timeout = 0
	while (((spi_read_word & sd.PLL_CLOCK_OUTPUT_PHASE_STATUS) == 0x0) and (timeout < 1000)):
		spi_read_word = skarabs[i].transport.direct_spi_read(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_ALARM_READBACK)
		time.sleep(0.1)
		timeout = timeout + 1
	if timeout == 1000:
		print(str("ERROR: SKARAB " + str(i) + " check SYNC status timeout"))
		exit()

# ---------------------------------------------------------------
# 10. PREPARE LMFC ALIGN (ALL SKARABS)
# ---------------------------------------------------------------
print("Preparing LMFC align...")
for i in range(skarab_num):
	# 10.1 CHANGE SYNC PIN TO PULSE GENERATOR
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_PLL, sd.PLL_GLOBAL_MODE_AND_ENABLE_CONTROL, 0x81)
	# 10.2 POWER UP ADC SYSREF INPUT BUFFERS
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_MASTER_PDN_SYSREF, 0x00)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_ADC_PAGE_SEL, 0x00)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_GENERAL_MASTER_PAGE_SEL, 0x04)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_MASTER_PDN_SYSREF, 0x00)

# ---------------------------------------------------------------
# 11. PERFORM LMFC ALIGN (MASTER SKARAB)
# ---------------------------------------------------------------
print("Performing LMFC align...")
# 11.1 TRIGGER PULSE GENERATION
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_PLL_PULSE_GEN_START, 0) #skarabs[mst_sk_i].write_int('pll_pulse_gen_start_in', 0)
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_PLL_PULSE_GEN_START, 1) #skarabs[mst_sk_i].write_int('pll_pulse_gen_start_in', 1)
# 11.2 WAIT FOR PULSE GENERATION TO COMPLETE
timeout = 0
read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_PLL_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('pll_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_PLL_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('pll_sync_complete_out')
	time.sleep(0.1)
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: Master SKARAB LMFC align timeout"))
	exit()

# ---------------------------------------------------------------
# 12. POWER DOWN SYSREF BUFFERS (ALL SKARABS)
# ---------------------------------------------------------------
print("Powering down SYSREF buffers...")
for i in range(skarab_num):
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_0, sd.ADC_MASTER_PDN_SYSREF, 0x10)
	skarabs[i].transport.direct_spi_write(mezzanine_site, sd.SPI_DESTINATION_ADC_1, sd.ADC_MASTER_PDN_SYSREF, 0x10)

# ---------------------------------------------------------------
# 13. PREPARE ADC SYNC (ALL SKARABS)
# ---------------------------------------------------------------
print("Preparing ADC sync...")
for i in range(skarab_num):
	i2c_interface = mezzanine_site + 1
	skarabs[i].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, sd.ENABLE_ADC_SYNC)

# ---------------------------------------------------------------
# 14. ADC SYNC PART 1 (ALL SKARABS)
# ---------------------------------------------------------------
print("Performing ADC sync part 1...")
for i in range(skarab_num):
	# 14.1 TRIGGER ADC SYNC PART 1
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_START, 0) #skarabs[i].write_int('adc_sync_start_in', 0)
	skarabs[i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_START, 1) #skarabs[i].write_int('adc_sync_start_in', 1)
	# 14.2 WAIT FOR ADC SYNC PART 1 COMPLETION
	timeout = 0
	read_reg = skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_COMPLETE) #read_reg = skarabs[i].read_int('adc_sync_complete_out')
	while ((read_reg == 0) and (timeout < 100)):
		read_reg = skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_COMPLETE) #read_reg = skarabs[i].read_int('adc_sync_complete_out')
		time.sleep(0.1)
		timeout = timeout + 1
	if timeout == 100:
		print(str("ERROR: SKARAB " + str(i) +  " ADC SYNC PART 1 timeout"))
		exit()

# ---------------------------------------------------------------
# 15. ARM THE BLOCK CAPTURE COMPONENTS (ALL SKARABS)
# ---------------------------------------------------------------
print("Arming block capture components...")
for i in range(skarab_num):
	skarabs[i].snapshots.adc0_bc_l_ss.arm()
	skarabs[i].snapshots.adc0_bc_h_ss.arm()
	skarabs[i].snapshots.adc1_bc_l_ss.arm()
	skarabs[i].snapshots.adc1_bc_h_ss.arm()
	skarabs[i].snapshots.adc2_bc_l_ss.arm()
	skarabs[i].snapshots.adc2_bc_h_ss.arm()
	skarabs[i].snapshots.adc3_bc_l_ss.arm()
	skarabs[i].snapshots.adc3_bc_h_ss.arm()
	skarabs[i].write_int('adc_trig', 1)

# ---------------------------------------------------------------
# 16. WAIT FOR ADC SYNC REQUEST ASSERT (ALL SKARABS)
# ---------------------------------------------------------------
print("Waiting for ADC sync request assertion...")
for i in range(skarab_num):
	timeout = 0
	read_reg = skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_REQUEST) #read_reg = skarabs[i].read_int('adc_sync_request_out')
	while ((read_reg != 0xF) and (timeout < 100)):
		read_reg = skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_REQUEST) #read_reg = skarabs[i].read_int('adc_sync_request_out')
		time.sleep(0.1)
		timeout = timeout + 1
	if timeout == 100:
		print(str("ERROR: SKARAB " + str(i) +  " wait for SYNC request assert timeout"))
		exit()

# ---------------------------------------------------------------
# 17. ADC SYNC PART 2 (MASTER SKARAB)
# ---------------------------------------------------------------
print("Performing ADC sync part 2...")
# 17.1 TRIGGER ADC SYNC PART 2
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_PART2_START, 0) #skarabs[mst_sk_i].write_int('adc_sync_part2_start_in', 0)
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_PART2_START, 1) #skarabs[mst_sk_i].write_int('adc_sync_part2_start_in', 1)
# 17.2 WAIT FOR ADC SYNC PART 2 COMPLETION
timeout = 0
read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('adc_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('adc_sync_complete_out')
	time.sleep(0.1)
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: Master SKARAB wait for ADC SYNC PART 2 timeout"))
	exit()

# ---------------------------------------------------------------
# 18. WAIT FOR SYNC REQUEST DE-ASSERT (ALL SKARABS)
# ---------------------------------------------------------------
print("Waiting for ADC sync request de-assertion...")
for i in range(skarab_num):
	timeout = 0
	read_reg = skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_REQUEST) #read_reg = skarabs[i].read_int('adc_sync_request_out')
	while ((read_reg != 0) and (timeout < 100)):
		read_reg = skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_REQUEST) #read_reg = skarabs[i].read_int('adc_sync_request_out')
		time.sleep(0.1)
		timeout = timeout + 1
	if timeout == 100:
		print(str("ERROR: SKARAB " + str(i) +  " wait for SYNC request de-assert timeout"))
		exit()

# ---------------------------------------------------------------
# 19. ADC SYNC PART 3 (MASTER SKARAB)
# ---------------------------------------------------------------
print("Performing ADC sync part 3...")
# 19.1 TRIGGER ADC SYNC PART 3
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_PART3_START, 0) #skarabs[mst_sk_i].write_int('adc_sync_part3_start_in', 0)
skarabs[mst_sk_i].transport.write_wishbone(WB_BASEADR+REGADR_WR_ADC_SYNC_PART3_START, 1) #skarabs[mst_sk_i].write_int('adc_sync_part3_start_in', 1)
# 19.2 WAIT FOR ADC SYNC PART 3 COMPLETION
timeout = 0
read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('adc_sync_complete_out')
while ((read_reg == 0) and (timeout < 100)):
	read_reg = skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_COMPLETE) #read_reg = skarabs[mst_sk_i].read_int('adc_sync_complete_out')
	time.sleep(0.1)
	timeout = timeout + 1
if timeout == 100:
	print(str("ERROR: Master SKARAB wait for ADC SYNC PART 3 timeout"))
	exit()

# ---------------------------------------------------------------
# 20. DISABLE THE ADC SYNC (ALL SKARABS)
# ---------------------------------------------------------------
print("Disabling ADC sync...")
for i in range(skarab_num):
	i2c_interface = mezzanine_site + 1
	skarabs[i].transport.write_i2c(i2c_interface, sd.STM_I2C_DEVICE_ADDRESS, sd.MEZ_CONTROL_REG, 0x0)

# ---------------------------------------------------------------
# 21. ADC STATUS REGISTER CHECK (ALL SKARABS)
# ---------------------------------------------------------------
print("Performing ADC status reg check...")
for i in range(skarab_num):
	adc0_status_out = (skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC0_STATUS)) & 0xFFBFFFFF #skarabs[i].read_uint('adc0_status_out')
	adc1_status_out = (skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC1_STATUS)) & 0xFFBFFFFF #skarabs[i].read_uint('adc1_status_out')
	adc2_status_out = (skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC2_STATUS)) & 0xFFBFFFFF #skarabs[i].read_uint('adc2_status_out')
	adc3_status_out = (skarabs[i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC3_STATUS)) & 0xFFBFFFFF #skarabs[i].read_uint('adc3_status_out')
	if (adc0_status_out != 0xE0000000 or adc1_status_out != 0xE0000000 or adc2_status_out != 0xE0000000 or adc3_status_out != 0xE0000000):				
		print(str("WARNING: SKARAB " + str(i) +  " status register invalid"))
		print(str("ADC 0 STATUS REG: " + str(hex(adc0_status_out))))
		print(str("ADC 1 STATUS REG: " + str(hex(adc1_status_out))))
		print(str("ADC 2 STATUS REG: " + str(hex(adc2_status_out))))
		print(str("ADC 3 STATUS REG: " + str(hex(adc3_status_out))))

# ---------------------------------------------------------------
# 22. ADC/PLL SYNC ERROR CHECK (MASTER SKARAB)
# ---------------------------------------------------------------
print("Performing ADC/PLL sync check...")
if skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_PLL_SYNC_COMPLETE) != 1: #skarabs[mst_sk_i].read_int('pll_sync_complete_out') != 1:
	print(str("ERROR: PLL SYNC COULD NOT COMPLETE"))
if skarabs[mst_sk_i].transport.read_wishbone(WB_BASEADR+REGADR_RD_ADC_SYNC_COMPLETE) != 1: #skarabs[mst_sk_i].read_int('adc_sync_complete_out') != 1:
	print(str("ERROR: ADC SYNC COULD NOT COMPLETE"))

# -------------------------------------------------
# 23. WRITE CAPTURED ADC DATA TO FILE (ALL SKARABS)
# -------------------------------------------------
print("Storing captured ADC data...")
for i in range(skarab_num):
	bc_keylist = ['d0','d1','d2','d3','d4','d5','d6','d7','d8','d9','d10','d11','d12','d13','d14','d15']
	filename_list = ["adc_data/sk"+str(i)+"_adc0_data.txt", "adc_data/sk"+str(i)+"_adc1_data.txt", "adc_data/sk"+str(i)+"_adc2_data.txt", "adc_data/sk"+str(i)+"_adc3_data.txt"]
	adc_bc_l_array = [skarabs[i].snapshots.adc0_bc_l_ss.read(arm=False)['data'], skarabs[i].snapshots.adc1_bc_l_ss.read(arm=False)['data'], skarabs[i].snapshots.adc2_bc_l_ss.read(arm=False)['data'], skarabs[i].snapshots.adc3_bc_l_ss.read(arm=False)['data']]
	adc_bc_h_array = [skarabs[i].snapshots.adc0_bc_h_ss.read(arm=False)['data'], skarabs[i].snapshots.adc1_bc_h_ss.read(arm=False)['data'], skarabs[i].snapshots.adc2_bc_h_ss.read(arm=False)['data'], skarabs[i].snapshots.adc3_bc_h_ss.read(arm=False)['data']]
	for p in range(4):
		adc_bc_file = open(filename_list[p], "w")
		for k in range(256):
			for j in range(8):
				adc_bc_file.write(str(str(adc_bc_l_array[p][bc_keylist[j]][k]) + "\n"))
			for j in range(8,16):
				adc_bc_file.write(str(str(adc_bc_h_array[p][bc_keylist[j]][k]) + "\n"))
		adc_bc_file.close()
print("-------------------------------------------")
print("Successfully captured synchronised ADC data")
print("-------------------------------------------")
