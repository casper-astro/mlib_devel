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
#include "FAT32_Access.h"
#include "FileString.h"
#include "FatMisc.h"
#include "../SD/SD_Access.h"

//-----------------------------------------------------------------------------
// FAT32_InitFAT: Load FAT32 Parameters
//-----------------------------------------------------------------------------
BOOL FAT32_InitFAT(void)
{
	FATFS_Internal.SectorCurrentlyLoaded = 0xFFFFFFFF;
	return FAT32_FindFAT32Details();
}
//-----------------------------------------------------------------------------
// FAT32_SectorReader: From the provided startcluster and sector offset
// Returns new cluster read if success, returns 0 if not (including if read out of range)
//-----------------------------------------------------------------------------
BOOL FAT32_SectorReader(UINT32 Startcluster, UINT32 offset)
{
 	  UINT32 SectortoRead = 0;
	  UINT32 ClustertoRead = 0;
	  UINT32 ClusterChain = 0;
	  UINT32 i;
	  UINT32 lba;
	  static UINT32 lastClustertoRead = 0;
          static UINT32 lastStartcluster = 0;
          static UINT32 lastcluster = 0;
          static UINT32 lastoffset = 0;
	  BOOL startfromlast;

	  // if the start cluster is the same as last time, and the offset is further 
	  // where we went last time, we can re-start the cluster search from where we were
	  startfromlast = (Startcluster==lastStartcluster && offset > lastoffset);
 
	  // Set start of cluster chain
	  if(startfromlast)
		  ClusterChain = lastcluster;
	  else
		  ClusterChain = Startcluster;

	  // Find parameters
	  if(startfromlast) {
		  ClustertoRead = (offset / FAT32.SectorsPerCluster) - lastClustertoRead; 
		  SectortoRead = offset % FAT32.SectorsPerCluster;
	  } else {
		  ClustertoRead = offset / FAT32.SectorsPerCluster;	  
		  SectortoRead = offset % FAT32.SectorsPerCluster;
	  }

	  // Follow chain to find cluster to read
	  for (i=0; i<ClustertoRead; i++)
	  	  ClusterChain = FAT32_FindNextCluster(ClusterChain);

	  // If end of cluster chain then return false
	  if (ClusterChain==0xFFFFFFFF) 
		  return 0;

	  // Else read sector 
	  lba = FAT32_LBAofCluster(ClusterChain)+SectortoRead;
	  if (!SD_BufferSector(lba))
		  return 0;

	  // cache cluster position for next time
	  lastcluster = ClusterChain;
	  lastoffset  = offset;
	  lastStartcluster  = Startcluster;
	  lastClustertoRead = offset / FAT32.SectorsPerCluster;

	  // Copy data into local buffer
	  memcpy(FATFS_Internal.currentsector, SD_Internal.currentsector, 512);
	  FATFS_Internal.SectorCurrentlyLoaded = lba;

	  return ClusterChain;
}
//-----------------------------------------------------------------------------
// FAT32_ShowFATDetails: Show the details about the filesystem
//-----------------------------------------------------------------------------
#if 0
void FAT32_ShowFATDetails(void)
{
	xil_printf("\r\nCurrent Disc FAT details\r\n------------------------\r\nRoot Dir First Cluster = ");   
	xil_printf("0x%x",FAT32.RootDir_First_Cluster);
	xil_printf("\r\nFAT Begin LBA = ");
	xil_printf("0x%x",FAT32.fat_begin_lba);
	xil_printf("\r\nCluster Begin LBA = ");
	xil_printf("0x%x",FAT32.cluster_begin_lba);
	xil_printf("\r\nSectors Per Cluster = ");
	xil_printf("%d",FAT32.SectorsPerCluster);
	xil_printf("\r\n\r\nFormula for conversion from Cluster num to LBA is;");
	xil_printf("\r\nLBA = (cluster_begin_lba + ((Cluster_Number-2)*SectorsPerCluster)))\r\n");
	xil_printf("\r\nMax LBA address on this drive is 0x%lx",SD_Internal.maxLBA-1);
}
#endif
//-----------------------------------------------------------------------------
// FAT32_GetRootCluster: Get the root dir cluster
//-----------------------------------------------------------------------------
UINT32 FAT32_GetRootCluster()
{
	return FAT32.RootDir_First_Cluster;
}
//-------------------------------------------------------------
// FAT32_GetFileEntry: Find the file entry for a filename
//-------------------------------------------------------------
UINT32 FAT32_GetFileEntry(UINT32 Cluster, char *nametofind, FAT32_ShortEntry *sfEntry)
{
	BYTE item=0;
	UINT16 recordoffset = 0;
	BYTE index=0;
	BYTE i=0;
	int x=0;
	char LongFilename[MAX_LONG_FILENAME];
	char ShortFilename[13];
	FAT32_ShortEntry directoryEntry;

	FATMisc_ClearLFN(TRUE);

	// Main cluster following loop
	while (TRUE)
	{
		// Read sector
		if (FAT32_SectorReader(Cluster, x++)) // If sector read was successfull
		{
			// Analyse Sector
			for (item=0; item<=15;item++)
			{
				// Create the multiplier for sector access
				recordoffset = (32*item);

				// Copy directory entry over buffer
				memcpy(&directoryEntry, FATFS_Internal.currentsector+recordoffset, sizeof(FAT32_ShortEntry));
				// Fix endianness of the short and long entries in the directory entry
				directoryEntry.FstClusHI = 
					((directoryEntry.FstClusHI & 0x00FF) << 8) | 
					((directoryEntry.FstClusHI & 0xFF00) >> 8);
				directoryEntry.FstClusLO = 
					((directoryEntry.FstClusLO & 0x00FF) << 8) | 
					((directoryEntry.FstClusLO & 0xFF00) >> 8);
				directoryEntry.FileSize = 
					((directoryEntry.FileSize & 0x000000FF) << 24) |
					((directoryEntry.FileSize & 0x0000FF00) <<  8) |
					((directoryEntry.FileSize & 0x00FF0000) >>  8) |
					((directoryEntry.FileSize & 0xFF000000) >> 24);

				// Long File Name Text Found
				if (FATMisc_If_LFN_TextOnly(&directoryEntry) ) 
					FATMisc_CacheLFN(FATFS_Internal.currentsector+recordoffset);

				// If Invalid record found delete any long file name information collated
				else if (FATMisc_If_LFN_Invalid(&directoryEntry) ) 
					FATMisc_ClearLFN(FALSE);

				// Normal SFN Entry and Long text exists 
				else if (FATMisc_If_LFN_Exists(&directoryEntry) ) 
				{
					FATMisc_GetLFNCache(LongFilename);

					// Compare names to see if they match
					if (FileString_Compare(LongFilename, nametofind)) 
					{
						memcpy(sfEntry,&directoryEntry,sizeof(FAT32_ShortEntry));
						return TRUE;
					}

		 			FATMisc_ClearLFN(FALSE);
				}

				// Normal Entry, only 8.3 Text		 
				else if (FATMisc_If_noLFN_SFN_Only(&directoryEntry) )
				{
					memset(ShortFilename, 0, sizeof(ShortFilename));

					// Copy name to string
					for (i=0; i<8; i++) 
						ShortFilename[i] = directoryEntry.Name[i];

					// If not . or .. entry
					if (ShortFilename[0]!='.')
						ShortFilename[8] = '.';
					else
						ShortFilename[8] = ' ';

					// Extension
					for (i=8; i<11; i++) 
						ShortFilename[i+1] = directoryEntry.Name[i];
		  			
					// Compare names to see if they match
					if (FileString_Compare(ShortFilename, nametofind)) 
					{
						memcpy(sfEntry,&directoryEntry,sizeof(FAT32_ShortEntry));
						return TRUE;
					}

					FATMisc_ClearLFN(FALSE);
				}
			} // End of if
		} 
		else
			break;
	} // End of while loop

	return FALSE;
}
//-----------------------------------------------------------------------------
// ListDirectory: Using starting cluster number of a directory and the FAT,
//				  list all directories and files 
//-----------------------------------------------------------------------------
#if 0
void ListDirectory(UINT32 StartCluster)
{
	BYTE i,item;
	UINT16 recordoffset;
	BYTE tempitem=0;
	BYTE LFNIndex=0;
	UINT32 x=0;
	FAT32_ShortEntry directoryEntry;
	char LongFilename[MAX_LONG_FILENAME];
	char ShortFilename[13];
 
	FAT32.filenumber=0;
	xil_printf("\r\nNo.             Filename\r\n");

	FATMisc_ClearLFN(TRUE);
	
	while (TRUE)
	{
		// If data read OK
		if (FAT32_SectorReader(StartCluster, x++))
		{
			LFNIndex=0;

			// Maximum of 15 directory entries
			for (item=0; item<=15;item++)
			{
				// Increase directory offset 
				recordoffset = (32*item);

				// Copy directory entry over buffer
				memcpy(&directoryEntry, FATFS_Internal.currentsector+recordoffset, sizeof(FAT32_ShortEntry));
				// Fix endianness of the short and long entries in the directory entry
				directoryEntry.FstClusHI = 
					((directoryEntry.FstClusHI & 0x00FF) << 8) | 
					((directoryEntry.FstClusHI & 0xFF00) >> 8);
				directoryEntry.FstClusLO = 
					((directoryEntry.FstClusLO & 0x00FF) << 8) | 
					((directoryEntry.FstClusLO & 0xFF00) >> 8);
				directoryEntry.FileSize = 
					((directoryEntry.FileSize & 0x000000FF) << 24) |
					((directoryEntry.FileSize & 0x0000FF00) <<  8) |
					((directoryEntry.FileSize & 0x00FF0000) >>  8) |
					((directoryEntry.FileSize & 0xFF000000) >> 24);
		 
				// Long File Name Text Found
				if ( FATMisc_If_LFN_TextOnly(&directoryEntry) )   
					FATMisc_CacheLFN(FATFS_Internal.currentsector+recordoffset);
				 	 
				// If Invalid record found delete any long file name information collated
				else if ( FATMisc_If_LFN_Invalid(&directoryEntry) ) 	
					FATMisc_ClearLFN(FALSE);

				// Normal SFN Entry and Long text exists 
				else if (FATMisc_If_LFN_Exists(&directoryEntry) ) 
				{
					FAT32.filenumber++; //File / Dir Count

					// Get text
					FATMisc_GetLFNCache(LongFilename);

		 			if (FATMisc_If_dir_entry(&directoryEntry)) xil_printf("\r\nDirectory ");
    				if (FATMisc_If_file_entry(&directoryEntry)) xil_printf("\r\nFile ");

					// Print Filename
					xil_printf("%d - %s",FAT32.filenumber, LongFilename);

		 			FATMisc_ClearLFN(FALSE);
				}
				 
				// Normal Entry, only 8.3 Text		 
				else if ( FATMisc_If_noLFN_SFN_Only(&directoryEntry) )
				{
       				FATMisc_ClearLFN(FALSE);
					FAT32.filenumber++; //File / Dir Count
					
		 			if (FATMisc_If_dir_entry(&directoryEntry)) xil_printf("\r\nDirectory ");
					if (FATMisc_If_file_entry(&directoryEntry)) xil_printf("\r\nFile ");

					memset(ShortFilename, 0, sizeof(ShortFilename));

					// Copy name to string
					for (i=0; i<8; i++) 
						ShortFilename[i] = directoryEntry.Name[i];

					// If not . or .. entry
					if (ShortFilename[0]!='.')
						ShortFilename[8] = '.';
					else
						ShortFilename[8] = ' ';

					// Extension
					for (i=8; i<11; i++) 
						ShortFilename[i+1] = directoryEntry.Name[i];
		  			
					// Print Filename
					xil_printf("%d - %s",FAT32.filenumber, ShortFilename);
					 					
				}
			}// end of for
		}
		else
			break;
	}
} 
#endif
