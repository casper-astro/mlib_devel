#include <stdlib.h>
#include "xbasic_types.h"
#include "xparameters.h"

/* section 5.2.2.1 (page 91 of PDF)
   http://www.sandisk.com/pdf/oem/ProdManualSDCardv1.9.pdf

   0 - GO_IDLE_STATE - Resets the SD Card
   1 - SEND_OP_COND - Activates the card's initialization process
   9 - SEND_CSD                         Asks card to send card-specific data
   10 - SEND_CID                        Asks card to send card identification
   12 - STOP_TRANSMISSION       Forces card to stop transmission during multi-block read
   13 - SEND_STATUS                     Asks card to send its status register.
   16 - SET_BLOCKLEN            Selects block length for all subsequent block commands (default is 512)
   17 - READ_SINGLE_BLOCK       Reads a block of the size specified by SET_BLOCKLEN
   18 - READ_MULTIPLE_BLOCK     Continuously transfers data until interrupted by STOP_TRANSMISSION
   24 - WRITE_BLOCK                     Writes a block of the size specified by
SET_BLOCKLEN
   25 - WRITE_MULTI_BLOCK       Continuously writes blocks of data until a stop transmission token is sent instead of start block token. */

/* R1 Response Codes (from SD Card Product Manual v1.9 section 5.2.3.1) */
#define R1_IN_IDLE_STATE    (1<<0)   /* The card is in idle state and running initializing process */
#define R1_ERASE_RESET      (1<<1)   /* An erase sequence was cleared before executing because of an out of erase sequence command was received */
#define R1_ILLEGAL_COMMAND  (1<<2)   /* An illegal command code was detected */
#define R1_COM_CRC_ERROR    (1<<3)   /* The CRC check of the last command failed */
#define R1_ERASE_SEQ_ERROR  (1<<4)   /* An error in the sequence of erase commands occured */
#define R1_ADDRESS_ERROR    (1<<5)   /* A misaligned address, which did not match the block length was used in the command */
#define R1_PARAMETER        (1<<6)   /* The command's argument (e.g. address, block length) was out of the allowed range for this card */
/* R1 bit (1<<7) is always 0 */

#define BASEADDR     XPAR_OPB_HARDWARE_SPI_0_BASEADDR

#define CE_OFFSET  0
#define RD_OFFSET  2
#define WR_OFFSET  3

#define SET_CE_N(val)   XIo_Out8(BASEADDR + CE_OFFSET, val)
#define GET_CE_N        XIo_In8(BASEADDR + CE_OFFSET)
#define WRITE_BYTE(val) XIo_Out8(BASEADDR + WR_OFFSET, val)
#define READ_BYTE       XIo_In8(BASEADDR + RD_OFFSET)

/* Prototypes */
unsigned char SPIRead();
void SPIWrite(unsigned char data);
int InitSD();
unsigned char SD_WriteCommand(unsigned char* cmd);
unsigned char SD_ReadBlock(unsigned long addr, unsigned char *buf);

unsigned char SPIRead() {
	int i;
	unsigned char val = 0;

	WRITE_BYTE(0xFF);
	usleep(1);
	val = READ_BYTE;

	return val;
}

void SPIWrite(unsigned char data) {
	int i;

	WRITE_BYTE(data);
	usleep(1);

}

int InitSD()
{
	int i = 0;
	unsigned char status;
	unsigned char val;
	int size;
	unsigned int c_size, c_size_mult, block_len;

	/* disable CE outputs */
	SET_CE_N(0);

	/* wait */
	usleep(30000);
	/* disable card */
	SET_CE_N(1);
	/* wait */
	usleep(30000);

        /* We need to give SD Card about a hundred clock cycles to boot up */
        for(i = 0; i < 16; ++i)
        {
                SPIWrite(0xFF); // write dummy data to pump clock signal line
        }

	/* Enable the card */
        SET_CE_N(0);

	/* This is the only command required to have a valid CRC
	   After this command, CRC values are ignored unless explicitly
	   enabled using CMD59 */
	unsigned char CMD0_GO_IDLE_STATE[] = {0x00,0x00,0x00,0x00,0x00,0x95};

	/* Wait for the SD Card to go into IDLE state */
	i = 0;
	do
	{	
        	SET_CE_N(0);
		status = SD_WriteCommand(CMD0_GO_IDLE_STATE);
        	SET_CE_N(1);
		/* Following this transaction, the SD Card needs 8 clocks after the end
		   bit of the last data block to finish up its work.
		   (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
		SPIWrite(0xFF);

		/* fail and return */
		if(i++ > 50)
		{
			return 0;
		}
	} while( status != 0x01 );

	/* Read the OCR register */
	unsigned char CMD58_READ_OCR[] = {58, 0x00, 0x00, 0x00, 0x00, 0xFF};
	SET_CE_N(0);
	status = SD_WriteCommand(CMD58_READ_OCR);
	if(status != 0x01) return 0;
	for(i=0; i<4; i++) {
		val = SPIRead();
		/* check that SDCard supports 3.3V */
		if(i==1 && ((val & 0x03) != 0x03)) return 0;
	}
	SET_CE_N(1);
	/* Following this transaction, the SD Card needs 8 clocks after the end
	   bit of the last data block to finish up its work.
	   (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
	SPIWrite(0xFF);

	/* Wait for SD Card to initialize */
	unsigned char CMD1_SEND_OP_COND[] = {0x01,0x00,0x00,0x00,0x00,0xFF};

	i = 0;
	do
	{
        	SET_CE_N(0);
		status = SD_WriteCommand(CMD1_SEND_OP_COND);
        	SET_CE_N(1);
		/* Following this transaction, the SD Card needs 8 clocks after the end
		   bit of the last data block to finish up its work.
		   (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
		SPIWrite(0xFF);
		if(i++ > 50)
		{
			return 0;
		}
		usleep(100000);
	} while( (status & R1_IN_IDLE_STATE) != 0 );

	/* Send CMD55, required to precede all "application specific" commands */
	unsigned char CMD55_APP_CMD[] = {55,0x00,0x00,0x00,0x00,0xFF};
        SET_CE_N(0);
	status = SD_WriteCommand(CMD55_APP_CMD); /* Do not check response here */
        SET_CE_N(1);
	/* Following this transaction, the SD Card needs 8 clocks after the end
	   bit of the last data block to finish up its work.
	   (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
	SPIWrite(0xFF);

	/* Send the ACMD41 command to initialize SD Card mode (not supported by
MMC cards) */
	i = 0;
	unsigned char ACMD41_SD_SEND_OP_COND[] = {41,0x00,0x00,0x00,0x00,0xFF};
	do
	{
        	SET_CE_N(0);
		status = SD_WriteCommand(ACMD41_SD_SEND_OP_COND);
        	SET_CE_N(1);
		/* Following this transaction, the SD Card needs 8 clocks after the end
		   bit of the last data block to finish up its work.
		   (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
        	SET_CE_N(1);
		SPIWrite(0xFF);

		if(i++ > 50)
		{
			return 0;
		}
	} while( (status & R1_IN_IDLE_STATE) != 0 );

        /* Read the CID register */
        unsigned char CMD10_SEND_CID[] = {10, 0x00, 0x00, 0x00, 0x00, 0xFF};
        SET_CE_N(0);
        status = SD_WriteCommand(CMD10_SEND_CID);
        if(status != 0) return 0;
        while(SPIRead() != 0xFE);
        for(i=0; i<16; i++) {
                val = SPIRead();
                switch(i) {
                        case 0:
                                xil_printf("Manufacturer ID: 0x%02X\n\r", val);
				break;
                        case 1:
                                xil_printf("OEM/Application ID: 0x%02X", val);
				break;
                        case 2:
                                xil_printf("%02X\n\r", val);
				break;
			case 3:
				xil_printf("Product name: %c", val);
				break;
			case 4:
			case 5:
			case 6:
				xil_printf("%c", val);
				break;
			case 7:
				xil_printf("%c\n\r", val);
				break;
		}
        }
        /* Read CRC */
        SPIRead();
        SPIRead();
        SET_CE_N(1);
        /* Following this transaction, the SD Card needs 8 clocks after the end
           bit of the last data block to finish up its work.
           (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
        SPIWrite(0xFF);


        /* Read the CSD register */
        unsigned char CMD9_SEND_CSD[] = {9, 0x00, 0x00, 0x00, 0x00, 0xFF};
        SET_CE_N(0);
        status = SD_WriteCommand(CMD9_SEND_CSD);
        if(status != 0) return 0;
        while(SPIRead() != 0xFE);
        for(i=0; i<16; i++) {
		val = SPIRead();
		switch(i) {
			case 5:
				block_len = val & 0x0F;
				/* check that this block length is supported */
				if(block_len != 9) return 0;
				break;
			case 6:
				c_size = (val & 0x03) << 10;
				break;
			case 7:
				c_size |= val << 2;
				break;
			case 8:
				c_size |= (val & 0xC0) >> 6;
				break;
			case 9:
				c_size_mult = (val & 0x03) << 1;
				break;
			case 10:
				c_size_mult |= (val & 0x80) >> 7;
				break;
		}
	}
	size = (c_size + 1) * (1 << c_size_mult + 2) * (1 << block_len);
        xil_printf("Card size : %d Bytes\n\r", size);
        /* Read CRC */
        SPIRead();
        SPIRead();
        SET_CE_N(1);
        /* Following this transaction, the SD Card needs 8 clocks after the end
           bit of the last data block to finish up its work.
           (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
        SPIWrite(0xFF);

        return size;
}

unsigned char SD_WriteCommand(unsigned char* cmd) {
	unsigned int i;
	unsigned char response;

        /* SD Card Command Format */
	/* (from Section 5.2.1 of SanDisk SD Card Product Manual v1.9).
	   Frame 7 = 0
	   Frame 6 = 1
	   Command (6 bits)
	   Address (32 bits)
	   Frame 0 = 1 */

	/* Set the framing bits correctly (never change) */
	cmd[0] |= (1<<6);
	cmd[0] &= ~(1<<7);
	cmd[5] |= (1<<0);

	/* Send the 6 byte command */
	for(i = 0; i < 6; ++i)
	{
		SPIWrite(*cmd);
		cmd++;
	}

	/* Wait for the response */
	i = 0;
	do
	{
		response = SPIRead();

		if(i > 100)
		{
			break;
		}
		i++;
	} while(response == 0xFF);

	return(response);


}

/* SD Card defaults to 512 byte block size */
#define BLOCK_SIZE 512
unsigned char SD_ReadBlock(unsigned long addr, unsigned char *buf) {
	unsigned int i;
	unsigned char status;

	unsigned char CMD17_READ_SINGLE_BLOCK[] = {17,0x00,0x00,0x00,0x00,0xFF};
	CMD17_READ_SINGLE_BLOCK[1] = ((addr & 0xFF000000) >> 24);
	CMD17_READ_SINGLE_BLOCK[2] = ((addr & 0x00FF0000) >> 16);
	CMD17_READ_SINGLE_BLOCK[3] = ((addr & 0x0000FF00) >> 8);
	CMD17_READ_SINGLE_BLOCK[4] = ((addr & 0x000000FF));

	SET_CE_N(0);

	/* Send the read command */
	status = SD_WriteCommand(CMD17_READ_SINGLE_BLOCK);
	if(status != 0)
	{
		/* ABORT: invalid response for read single command */
                return 1;
	}

	/* Now wait for the "Start Block" token (0xFE)
	   (see SanDisk SD Card Product Manual v1.9 section 5.2.4. Data Tokens) */
	do
	{
		status = SPIRead();
	} while(status != 0xFE);

	/* Read off all the bytes in the block */
	for(i = 0; i < BLOCK_SIZE; ++i)
	{
		status = SPIRead();
		*buf = status;
		buf++;
	}

	/* Read CRC bytes */
	status = SPIRead();
	status = SPIRead();

	SET_CE_N(1);

	/* Following a read transaction, the SD Card needs 8 clocks after the end
	   bit of the last data block to finish up its work.
	   (from SanDisk SD Card Product Manual v1.9 section 5.1.8) */
	SPIWrite(0xFF);

	return 0;
}

