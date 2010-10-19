#include "define.h"
#include "FAT32_Definitions.h"

#ifndef __FATMISC_H__
#define __FATMISC_H__

//-----------------------------------------------------------------------------
// Defines
//-----------------------------------------------------------------------------
#define MAX_LONGFILENAME_ENTRIES	20

//-----------------------------------------------------------------------------
// Globals
//-----------------------------------------------------------------------------
struct 
{
	   // Long File Name Structure (max 260 LFN length)
	   BYTE String[MAX_LONGFILENAME_ENTRIES][13];
	   BYTE no_of_strings;
} FAT32_LFN;

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
void FATMisc_ClearLFN(BOOL wipeTable);
void FATMisc_CacheLFN(BYTE *entryBuffer);
void FATMisc_GetLFNCache(BYTE *strOut);
int FATMisc_If_LFN_TextOnly(FAT32_ShortEntry *entry);
int FATMisc_If_LFN_Invalid(FAT32_ShortEntry *entry);
int FATMisc_If_LFN_Exists(FAT32_ShortEntry *entry);
int FATMisc_If_noLFN_SFN_Only(FAT32_ShortEntry *entry);
int FATMisc_If_dir_entry(FAT32_ShortEntry *entry);
int FATMisc_If_file_entry(FAT32_ShortEntry *entry);

#endif
