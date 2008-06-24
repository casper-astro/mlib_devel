#include "define.h"
#include "FAT32_Definitions.h"

#ifndef __FAT32_ACCESS_H__
#define __FAT32_ACCESS_H__

//-----------------------------------------------------------------------------
//  Globals
//-----------------------------------------------------------------------------
struct 
{
 	   BYTE currentsector[512];
	   UINT32 SectorCurrentlyLoaded; // Initially Load to 0xffffffff;
} FATFS_Internal;

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
BOOL FAT32_InitFAT(void);
BOOL FAT32_SectorReader(UINT32 Startcluster, UINT32 offset);
void FAT32_ShowFATDetails(void);
UINT32 FAT32_GetRootCluster();
UINT32 FAT32_GetFileEntry(UINT32 Cluster, char *nametofind, FAT32_ShortEntry *sfEntry);
void ListDirectory(UINT32 StartCluster);

#endif
