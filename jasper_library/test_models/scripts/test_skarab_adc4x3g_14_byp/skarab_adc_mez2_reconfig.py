import casperfpga
from casperfpga import skarab_definitions as sd
import numpy as np

import time
import math

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
WB_BASEADR = 0x124000

uImageSize = 0
uMezzanine = 2
i2c_interface = uMezzanine + 1
puCodeBuffer = []
puReadBuffer = []
bTestPassed = 1
i = 0

#filename = 'EMB124901U8R1.bin'
#sIPAddress = '10.0.7.3'
filename = str(raw_input("Specify BIN file name (Example: EMB124901U8R1.bin): "))
sIPAddress = str(raw_input("Specify IP address of Skarab to program (Example: 10.0.7.2): "))

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
loadfirmware = str(raw_input("Do you want to load an FPG file? (y/n): "))
if (loadfirmware[0] == 'y' or loadfirmware[0] == 'Y'):
	fpgfilename = str(raw_input("Specify FPG file name (Example: skarab_adc_byp.fpg): "))
	#skarab.upload_to_ram_and_program('test_skarab_adc_byp_2021-02-12_1344.fpg')
	skarab.upload_to_ram_and_program(fpgfilename)
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
