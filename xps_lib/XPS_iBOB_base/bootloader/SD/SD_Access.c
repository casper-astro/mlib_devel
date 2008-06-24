//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//					    FAT32 File IO Library (Read Only)
//								   V1.0
// 	  							Rob Riglar
//							Copyright 2003-2006
//
//   					  Email: rob@robriglar.com
//
//-----------------------------------------------------------------------------
//
// This file is part of FAT32 File IO Library.
//
// FAT32 File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT32 File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT32 File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

#include "SD_Access.h"

//-----------------------------------------------------------------------------
// SD_SectorByte: Function is used to retrieve a BYTE from the 'currentsector'
// array. The value passed in must be between 0 - 511.
//
// Parameters: Word location within currentsector
//
// Returns: Byte of data requested from currentsector
//-----------------------------------------------------------------------------
BYTE SD_SectorByte(UINT16 sublocation)
{
// NOTE: This function is to be used whereever access to currentsector is required
//  	 by all layers that are higher than the SD Base functions.
	BYTE data=0;          
    data=SD_Internal.currentsector[sublocation];	  // Read Data from specified pos
	return (data);
}

//-----------------------------------------------------------------------------
// SD_SectorWord: Function is used to retrieve a UINT16 from the 'currentsector'
// array. The value passed in must be between 0 - 510.
//
// Parameters: Word location within currentsector
//
// Returns: Word of data requested from currentsector
//-----------------------------------------------------------------------------
UINT16 SD_SectorWord(UINT16 sublocation) // Return Word at position specified
{
	 UINT16 data=0; 
	 UINT16 tempword=0;
	   
	 tempword = SD_SectorByte(sublocation+1); // Get MSB from Buffer
	 tempword<<=8;							 // Make MSB word half into BYTE
	 data = SD_SectorByte(sublocation) + tempword; // Combine LSB and MSB

	 return (data);					  			 // Return value
}

//-----------------------------------------------------------------------------
// SD_SectorUI32: Function is used to retrieve a 32 bit value from the 
// 'currentsector' array. The value passed in must be between 0 - 511.
//
// Parameters: Word offset within current sector
//
// Returns: 32 bit unsigned data as requested
//
// Functions Used: None
//
//-----------------------------------------------------------------------------
UINT32 SD_SectorUI32(UINT16 sublocation) // Return UINT32 at position specified
{
    UINT32 data=0; 
	UINT32 A,B,C,D;
	
	A= SD_SectorByte(sublocation);		// Read the four bytes which make up
	B= SD_SectorByte(sublocation+1);    // the 32-bit value
	C= SD_SectorByte(sublocation+2);
	D= SD_SectorByte(sublocation+3);         

    data=(D<<=24) + (C<<=16) + (B<<=8) + A; //Combine into correct order
	return (data);					  			 // Return value
}

//-----------------------------------------------------------------------------
// SD_BufferSector: This function recieves the LBA address of a sector and reads into
// an array of 512 bytes (1 sector) called 'currentsector'.
//
// Parameters: 32bit Unsigned Logical Block Address
//
// Returns: An integer error code: 1 means read successfull, 0 means read fail.
//
// Functions Used: WriteReg, CheckforError, ReadErrors, Wait_DRQ, Set_Address, 
// 			 	   DataInputSetup, printf
//
//-----------------------------------------------------------------------------
BOOL SD_BufferSector(UINT32 LBALocation)
{
	if (LBALocation>=SD_Internal.maxLBA) 
		/* Return failure */
		return FALSE;

	/* read a block */
	SD_ReadBlock(LBALocation * 512, SD_Internal.currentsector);	

	/* Return Success */
	return TRUE;
}

//-----------------------------------------------------------------------------
// Init: SDCard Initialisation routine, required before you use the card 
// for reading. 
//-----------------------------------------------------------------------------
void SD_Init(void)
{
	int size;

	/* initialize SD card */
        xil_printf("SD Card initialization\n\r");
        size = InitSD();
        if(!size) {
                xil_printf("Cannot initialize the SD Card, check that it is properly inserted.\n\r");
                return;
        } else {
                xil_printf("Card initialization complete\n\r");
        }

	/* store the maximum LBA */
	SD_Internal.maxLBA = size / 512;

	/* Set to defualt value */
	SD_Internal.SectorCurrentlyLoaded = 0xffffffff;

}
