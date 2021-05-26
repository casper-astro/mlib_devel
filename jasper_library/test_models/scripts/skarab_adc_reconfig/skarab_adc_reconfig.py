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
# This script reprograms a SKARAB ADC board that is installed in a SKARAB
# system with new firmware.
# It requests the following user input:
# - The filename ("BIN file name") of the firmware to upload. This file needs to be 
#   stored under the directory of this script. The following firmwares are provided
#   along with this script: 
#     EMB124901U8R2_BYP.bin (Configures the SKARAB ADC board in Bypass Mode by default)
#     EMB124901U8R2_DDC.bin (Configures the SKARAB ADC board in DDC Mode by default)
# - The mezzanine site onto which the SKARAB ADC board is installed
# - The IP address of the SKARAB
# - The name of the fpg file that needs to be uploaded to the SKARAB before the
#   SKARAB ADC board is programmed. Note that this fpg file needs to be stored under the
#   directory of this script and needs to have a corresponding SKARAB ADC Yellow Block 
#   for the SKARAB ADC board that needs to be reprogrammed. Also, the User IP Clock 
#   source needs to be set to sys_clk (not adc_clk). A prebuilt fpg file that contains  
#   SKARAB ADC Yellow Blocks for SKARAB ADC boards on site 0 and site 1 is provided  
#   along with this script: 
#     test_skarab_adc_x2_sysclk.fpg
# - The name of the corresponding SKARAB ADC Yellow Block
#     In the test_skarab_adc_x2_sysclk.fpg prebuilt fpg file, the SKARAB ADC Yellow  
#     Block for site 1 is named skarab_adc4x3g_14_master while the one for site 0 is  
#     named skarab_adc4x3g_14_slave
#
#--------------------------------------------------------------------------------------

import casperfpga
from casperfpga import skarab_definitions as sd
import numpy as np

import time
import math

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
STM32_I2C_ADDRESS = 0x08
MAX_STM32_IMAGE_SIZE_BYTES = 1024*1024
MAX_I2C_TRANSMIT_BYTES = 32
MAX_I2C_RECEIVE_BYTES = 7
I2C_OVERHEAD_BYTES = 7
STM32_APP_LOAD_ADDRESS = 0x08010000
ERASE_WAIT_TIME = 10
QSFP_MEZZANINE_RESET = 0x100
uReg = 0
C_WR_MEZZANINE_CTL_ADDR = 0x10

OPC_READ = 0x03
OPC_WREN = 0x06
OPC_ERPG = 0x20
OPC_ERUSM = 0x60
OPC_USRCD = 0x77

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

uImageSize = 0

puCodeBuffer = []
puReadBuffer = []
bTestPassed = 1
i = 0

#filename = 'EMB124901U8R1.bin'
#sIPAddress = '10.0.7.3'
filename = str(raw_input("Specify BIN file name (Example: EMB124901U8R2_DDC.bin): "))
uMezzanine = int(raw_input("Specify mezzanine site (Example: 1): "))
sYbName = str(raw_input("Specify Yellow Block name (Examples: skarab_adc4x3g_14_master, skarab_adc4x3g_14_slave): "))
sIPAddress = str(raw_input("Specify IP address of the SKARAB (Example: 10.0.7.2): "))

i2c_interface = uMezzanine + 1

# Create empty transmit array
uTx = []
for init in range(MAX_I2C_TRANSMIT_BYTES):
	uTx.append(0);

uTransmitRead = []
for init in range(I2C_OVERHEAD_BYTES):
	uTransmitRead.append(0);

# Create empty receive array
uReceive = []
for init in range(MAX_I2C_RECEIVE_BYTES):
	uReceive.append(0);
	
# Connect to SKARAB and upload .fpg file
skarab = casperfpga.CasperFpga(sIPAddress)
# loadfirmware = str(raw_input("Do you want to load an FPG file? (y/n): "))
# if (loadfirmware[0] == 'y' or loadfirmware[0] == 'Y'):
fpgfilename = str(raw_input("Specify FPG file name (Example: test_skarab_adc_x2_sysclk.fpg): "))
#skarab.upload_to_ram_and_program('test_skarab_adc_x2_sysclk')
skarab.upload_to_ram_and_program(fpgfilename)
WB_BASEADR = 0x7FFFFFFF & get_wb_addresses(fpgfilename)[sYbName]['address']
skarab.listdev()

skarab.transport.write_wishbone(WB_BASEADR + REGADR_WR_MEZZANINE_RESET, 1)
time.sleep(0.1)
skarab.transport.write_wishbone(WB_BASEADR + REGADR_WR_MEZZANINE_RESET, 0)

time.sleep(1)
print("Now in bootloader programming mode.")

print(str("Opening file: "+str(filename)))

file = open(filename, "r")
puCodeBuffer = np.fromfile(file, dtype=np.uint8)
file.close()
uImageSize = len(puCodeBuffer)
print(str("Bytes read from file: "+str(uImageSize)))

print("Erasing User-Space...")
skarab.transport.write_i2c(i2c_interface, STM32_I2C_ADDRESS, 0x60)
time.sleep(ERASE_WAIT_TIME)
print("User-space has been erased.")

uTx[0] = 0x06
uTx[1] = (STM32_APP_LOAD_ADDRESS >> 24) & 0xFFFF
uTx[2] = (STM32_APP_LOAD_ADDRESS >> 16) & 0xFFFF
uTx[3] = (STM32_APP_LOAD_ADDRESS >> 8) & 0xFFFF
uTx[4] = (STM32_APP_LOAD_ADDRESS >> 0) & 0xFFFF
uTx[5] = 0x00;
uTx[6] = MAX_I2C_TRANSMIT_BYTES - 7

print("Downloading image to flash...")

uByteIdx = 0
uTransferIdx = 0
ulnTempAddr = STM32_APP_LOAD_ADDRESS
uTransBufInc = 0
iNewPercent = 0
iOldPercent = 0;
dTotalTransferIdx = (uImageSize / (MAX_I2C_TRANSMIT_BYTES - 7))

#Check if the image size is a multiple of the number of the bytes transferred per transaction
if ((uImageSize % (MAX_I2C_TRANSMIT_BYTES - 7)) == 0):
	 uTransferIdx = 1
	 while (uTransferIdx <= math.floor((uImageSize / (MAX_I2C_TRANSMIT_BYTES - 7)))):
		uTx[1] = (ulnTempAddr >> 24) & 0xFFFF
		uTx[2] = (ulnTempAddr >> 16) & 0xFFFF
		uTx[3] = (ulnTempAddr >> 8) & 0xFFFF
		uTx[4] = (ulnTempAddr >> 0) & 0xFFFF
		
		uByteIdx = 7
		while(uByteIdx < MAX_I2C_TRANSMIT_BYTES):
			if ((uTransBufInc + (uByteIdx - 7)) < uImageSize) :
				uTx[uByteIdx] = puCodeBuffer[uTransBufInc + (uByteIdx - 7)]
			else :
				uTx[uByteIdx] = 0x0			
			uByteIdx = uByteIdx + 1

		#Write op-code, start address, no. of bytes and the data bytes
		skarab.transport.write_i2c(i2c_interface, STM32_I2C_ADDRESS, *uTx)

		ulnTempAddr = ulnTempAddr + (MAX_I2C_TRANSMIT_BYTES - 7)
		uTransBufInc = uTransBufInc + (MAX_I2C_TRANSMIT_BYTES - 7)

		iNewPercent = math.floor((uTransferIdx * 100.0) / dTotalTransferIdx);
		if(iNewPercent != iOldPercent) :
			print(str(str(int(iNewPercent))+" %"))
			iOldPercent = iNewPercent
		
		uTransferIdx = uTransferIdx + 1
else :
	uTransferIdx = 1
	while (uTransferIdx <= math.floor((uImageSize / (MAX_I2C_TRANSMIT_BYTES - 7)) + 1)):
		uTx[1] = (ulnTempAddr >> 24) & 0xFFFF
		uTx[2] = (ulnTempAddr >> 16) & 0xFFFF
		uTx[3] = (ulnTempAddr >> 8) & 0xFFFF
		uTx[4] = (ulnTempAddr >> 0) & 0xFFFF
	
		uByteIdx = 7
		while (uByteIdx < MAX_I2C_TRANSMIT_BYTES) :
			if ((uTransBufInc + (uByteIdx - 7)) < uImageSize) :
				uTx[uByteIdx] = puCodeBuffer[uTransBufInc + (uByteIdx - 7)]
			else :
				uTx[uByteIdx] = 0x0
			uByteIdx = uByteIdx + 1
	
		#Write op-code, start address, no. of bytes and the data bytes
		skarab.transport.write_i2c(i2c_interface, STM32_I2C_ADDRESS, *uTx)

		ulnTempAddr = ulnTempAddr + (MAX_I2C_TRANSMIT_BYTES - 7)
		uTransBufInc = uTransBufInc + (MAX_I2C_TRANSMIT_BYTES - 7)

		iNewPercent = math.floor((uTransferIdx * 100.0) / dTotalTransferIdx)
		if(iNewPercent != iOldPercent) :
			print(str(str(int(iNewPercent))+" %"))
			iOldPercent = iNewPercent
		
		uTransferIdx = uTransferIdx + 1
print("Download complete.")
	
print("Reading image from flash...")

uByteIdx = 0
uTransferIdx = 0
uTempAddr = STM32_APP_LOAD_ADDRESS
uTransBufInc = 0

uTransmitRead[0] = OPC_READ
uTransmitRead[1] = ((STM32_APP_LOAD_ADDRESS + 4) >> 24) & 0xFFFF
uTransmitRead[2] = ((STM32_APP_LOAD_ADDRESS + 4) >> 16) & 0xFFFF
uTransmitRead[3] = ((STM32_APP_LOAD_ADDRESS + 4) >> 8) & 0xFFFF
uTransmitRead[4] = ((STM32_APP_LOAD_ADDRESS + 4) >> 0) & 0xFFFF
uTransmitRead[5] = 0x00
uTransmitRead[6] = MAX_I2C_RECEIVE_BYTES

iNewPercent = 0
iOldPercent = 0
dTotalTransferIdx = (uImageSize / MAX_I2C_RECEIVE_BYTES)
	
# Check if the image size is a multiple of the number of the bytes transferred per transaction 
if ((uImageSize % MAX_I2C_RECEIVE_BYTES) == 0) :

	uTransferIdx = 1
	while (uTransferIdx <= (uImageSize / MAX_I2C_RECEIVE_BYTES)) :

		uTransmitRead[1] = (uTempAddr >> 24) & 0xFFFF
		uTransmitRead[2] = (uTempAddr >> 16) & 0xFFFF
		uTransmitRead[3] = (uTempAddr >> 8) & 0xFFFF
		uTransmitRead[4] = (uTempAddr >> 0) & 0xFFFF

		# Write op-code, address and no. of bytes
		skarab.transport.write_i2c(i2c_interface, STM32_I2C_ADDRESS, *uTransmitRead)
		
		# Read back the no. of bytes 
		uReceive = skarab.transport.read_i2c(i2c_interface, STM32_I2C_ADDRESS, MAX_I2C_RECEIVE_BYTES)

		uByteIdx = 0
		while(uByteIdx < MAX_I2C_RECEIVE_BYTES) :
			puReadBuffer.append(uReceive[uByteIdx])
			uByteIdx = uByteIdx + 1

			
		uTempAddr = uTempAddr + MAX_I2C_RECEIVE_BYTES
		uTransBufInc = uTransBufInc + MAX_I2C_RECEIVE_BYTES

		iNewPercent = math.floor((uTransferIdx * 100.0) / dTotalTransferIdx)

		if(iNewPercent != iOldPercent) :
			print(str(str(int(iNewPercent))+" %"))
			iOldPercent = iNewPercent
		
		uTransferIdx = uTransferIdx + 1
		
else :
	uTransferIdx = 1
	while (uTransferIdx <= ((uImageSize / MAX_I2C_RECEIVE_BYTES) + 1)) :
		uTransmitRead[1] = (uTempAddr >> 24) & 0xFFFF
		uTransmitRead[2] = (uTempAddr >> 16) & 0xFFFF
		uTransmitRead[3] = (uTempAddr >> 8) & 0xFFFF
		uTransmitRead[4] = (uTempAddr >> 0) & 0xFFFF
	
		# Write op-code, address and no. of bytes
		skarab.transport.write_i2c(i2c_interface, STM32_I2C_ADDRESS, *uTransmitRead)
		
		# Read back the no. of bytes 
		uReceive = skarab.transport.read_i2c(i2c_interface, STM32_I2C_ADDRESS, MAX_I2C_RECEIVE_BYTES)
	
		uByteIdx = 0
		while (uByteIdx < MAX_I2C_RECEIVE_BYTES) :
			puReadBuffer.append(uReceive[uByteIdx])
			uByteIdx = uByteIdx + 1

		uTempAddr = uTempAddr + MAX_I2C_RECEIVE_BYTES;
		uTransBufInc = uTransBufInc + MAX_I2C_RECEIVE_BYTES;

		iNewPercent = math.floor((uTransferIdx * 100.0) / dTotalTransferIdx);

		if(iNewPercent != iOldPercent) :
			print(str(str(int(iNewPercent))+" %"))
			iOldPercent = iNewPercent
			
		uTransferIdx = uTransferIdx + 1

print("")

i = 0
while (i < uImageSize) :
	if(puCodeBuffer[i] != puReadBuffer[i]) :
		print( "ERROR! ", i , " DESIRED: ", puCodeBuffer[i], " ACTUAL: ", puReadBuffer[i] )
		bTestPassed = 0

	i = i + 1 

if (bTestPassed == 0):
	print("Programming error!")
else :
	print("Programmed successfully! ")

# Put into application mode
uTransmitJumpToUserSpace = [OPC_USRCD]
skarab.transport.write_i2c(i2c_interface, STM32_I2C_ADDRESS, *uTransmitJumpToUserSpace)	

exit()
