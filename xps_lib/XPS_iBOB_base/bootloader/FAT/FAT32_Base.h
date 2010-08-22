#include "define.h"

#ifndef __FAT32_BASE_H__
#define __FAT32_BASE_H__

//-----------------------------------------------------------------------------
// Globals
//-----------------------------------------------------------------------------
struct 
{
	   // Filesystem globals
	   BYTE SectorsPerCluster;
	   UINT32 cluster_begin_lba;
	   UINT32 RootDir_First_Cluster;
	   UINT32 fat_begin_lba;
       UINT32 filenumber;
} FAT32;

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
BOOL FAT32_FindLBABegin(UINT32 *lbaBegin);
UINT32 FAT32_LBAofCluster(UINT32 Cluster_Number);
BOOL FAT32_FindFAT32Details(void);
UINT32 FAT32_FindNextCluster(UINT32 Current_Cluster);
BYTE FAT32_GetFATVersion();

#endif

