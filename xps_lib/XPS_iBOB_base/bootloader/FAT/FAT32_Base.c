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
#include "FAT32_Definitions.h"
#include "FAT32_Base.h"

//-----------------------------------------------------------------------------
// FAT32_FindLBABegin: This function is used to find the LBA Address of the first
// volume on the disc. Also checks are performed on the signature and identity
// codes to make sure the partition is FAT32.
//-----------------------------------------------------------------------------
BOOL FAT32_FindLBABegin(UINT32 *lbaBegin)
{
	BYTE tempdata;
	
	// Load MBR (LBA 0) into the 512 byte buffer
	if (!SD_BufferSector(0))
		return FALSE;
	
	// Make Sure 0x55 and 0xAA are at end of sector
	if (SD_SectorWord(Signature_Position)!=Signature_Value) 
		return FALSE;
		
	// Verify Type Code as 0C or 0B for FAT32
	tempdata = SD_SectorByte(PARTITION1_TYPECODE_LOCATION);
	
	if ((tempdata!=FAT32_TYPECODE1)&&(tempdata!=FAT32_TYPECODE2))
		 return FALSE;
		
	// Read LBA Begin for FAT32 File system is located for partition
	*lbaBegin=SD_SectorUI32(PARTITION1_LBA_BEGIN_LOCATION);

  	// Return the LBA address of FAT table
	return TRUE;			
}
//-----------------------------------------------------------------------------
// FAT32_LBAofCluster: This function converts a cluster number into a sector / 
// LBA number.
//-----------------------------------------------------------------------------
UINT32 FAT32_LBAofCluster(UINT32 Cluster_Number)
{
	return ((FAT32.cluster_begin_lba + ((Cluster_Number-2)*FAT32.SectorsPerCluster)));
}
//-----------------------------------------------------------------------------
// FAT32_FindFAT32Details: Uses FAT32_FindLBABegin to find the LBA for the volume, 
// and loads into memory some specific details of the partitionw which are used 
// in further calculations.
//-----------------------------------------------------------------------------
BOOL FAT32_FindFAT32Details(void)
{
	BYTE Number_of_FATS;
	UINT32 Sectors_per_FAT;
	UINT16 Reserved_Sectors;
	UINT32 LBA_BEGIN;

	// Check Volume 1 and find LBA address
	if (FAT32_FindLBABegin(&LBA_BEGIN))
	{
		// Load Volume 1 table into sector buffer
		if (!SD_BufferSector(LBA_BEGIN))
			return FALSE;

		// Make sure there are 512 bytes per cluster
		if (SD_SectorWord(0x0B)!=0x200) 
			return FALSE;

		// Load Parameters of FAT32	 
		FAT32.SectorsPerCluster = SD_SectorByte(BPB_SecPerClus);
		Reserved_Sectors = SD_SectorWord(BPB_RsvdSecCnt);
		Number_of_FATS = SD_SectorByte(BPB_NumFATs);
		Sectors_per_FAT = SD_SectorUI32(BPB_FAT32_FATSz32);
		FAT32.RootDir_First_Cluster = SD_SectorUI32(BPB_FAT32_RootClus);

		// First FAT LBA address
		FAT32.fat_begin_lba = LBA_BEGIN + Reserved_Sectors;

		// The address of the first data cluster on this volume
		FAT32.cluster_begin_lba = FAT32.fat_begin_lba + (Number_of_FATS * Sectors_per_FAT);

		if (SD_SectorWord(0x1FE)!=0xAA55) // This signature should be AA55
			return FALSE;

		return TRUE;
	 }
	 else
		return FALSE;
}
//-----------------------------------------------------------------------------
// FAT32_FindNextCluster: Return Cluster number of next cluster in chain by 
// reading FAT table and traversing it. Return 0xffffffff for end of chain.
//-----------------------------------------------------------------------------
UINT32 FAT32_FindNextCluster(UINT32 Current_Cluster)
{
	UINT32 FAT_sector_offset, position;
	UINT32 nextcluster;

	// Why is '..' labelled with cluster 0 when it should be 2 ??
	if (Current_Cluster==0) Current_Cluster=2;

	// Find which sector of FAT table to read
	FAT_sector_offset = Current_Cluster / 128;

	// Read FAT sector into buffer
	SD_BufferSector(FAT32.fat_begin_lba+FAT_sector_offset);

	// Find 32 bit entry of current sector relating to cluster number 
	position = (Current_Cluster - (FAT_sector_offset * 128)) * 4; 

	// Read Next Clusters value from Sector Buffer
	nextcluster = SD_SectorUI32((UINT16)position);	 

	// Mask out MS 4 bits (its 28bit addressing)
	nextcluster = nextcluster & 0x0FFFFFFF;		

	// If 0x0FFFFFFF then end of chain found
	if (nextcluster==0x0FFFFFFF) 
		return (FAT32_EOC_FLAG); 
	else 
	// Else return next cluster
		return (nextcluster);						 
} 
//-----------------------------------------------------------------------------
// FAT32_GetFATVersion: Returns the FAT type code
//-----------------------------------------------------------------------------
BYTE FAT32_GetFATVersion()
{
	UINT32 FATSz;
	UINT32 RootDirSectors;
	UINT32 TotSec;
	UINT32 DataSec;
	UINT32 CountofClusters;

	// Buffer sector
	if (!SD_BufferSector(0))
		return 0xFF;

	// Calculate the root dir sectors
	RootDirSectors = ((SD_SectorWord(BPB_RootEntCnt) * 32) + (SD_SectorWord(BPB_BytsPerSec) - 1)) / SD_SectorWord(BPB_BytsPerSec);
	
	if(SD_SectorWord(BPB_FATSz16) != 0)
		FATSz = SD_SectorWord(BPB_FATSz16);
	else
		FATSz = SD_SectorUI32(BPB_FAT32_FATSz32);  

	if(SD_SectorWord(BPB_TotSec16) != 0)
		TotSec = SD_SectorWord(BPB_TotSec16);
	else
		TotSec = SD_SectorUI32(BPB_TotSec32);

	DataSec = TotSec - (SD_SectorWord(BPB_RsvdSecCnt) + (SD_SectorByte(BPB_NumFATs) * FATSz) + RootDirSectors);

	CountofClusters = DataSec / BPB_SecPerClus;

	if(CountofClusters < 4085) 
		// Volume is FAT12 
		return FAT_TYPE_FAT12;
	else if(CountofClusters < 65525) 
		// Volume is FAT16
		return FAT_TYPE_FAT16;
	else 
		// Volume is FAT32
		return FAT_TYPE_FAT32;
}

