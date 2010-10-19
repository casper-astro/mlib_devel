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
#include "FatMisc.h"

//-----------------------------------------------------------------------------
// FATMisc_ClearLFN: Clear long file name cache
//-----------------------------------------------------------------------------
void FATMisc_ClearLFN(BOOL wipeTable)
{
	int i;
	FAT32_LFN.no_of_strings = 0;

	// Zero out buffer also
	if (wipeTable)
		for (i=0;i<MAX_LONGFILENAME_ENTRIES;i++)
			memset(FAT32_LFN.String[i], 0x00, 13);
}
//-----------------------------------------------------------------------------
// FATMisc_cacheLFN - Function extracts long file name text from sector 
//                       at a specific offset
//-----------------------------------------------------------------------------
void FATMisc_CacheLFN(BYTE *entryBuffer)
{
	BYTE LFNIndex, i;
	LFNIndex = entryBuffer[0] & 0x0F;

	if (FAT32_LFN.no_of_strings==0) 
		FAT32_LFN.no_of_strings = LFNIndex;

	FAT32_LFN.String[LFNIndex-1][0] = entryBuffer[1];
	FAT32_LFN.String[LFNIndex-1][1] = entryBuffer[3];
	FAT32_LFN.String[LFNIndex-1][2] = entryBuffer[5];
	FAT32_LFN.String[LFNIndex-1][3] = entryBuffer[7];
	FAT32_LFN.String[LFNIndex-1][4] = entryBuffer[9];
	FAT32_LFN.String[LFNIndex-1][5] = entryBuffer[0x0E];
	FAT32_LFN.String[LFNIndex-1][6] = entryBuffer[0x10];
	FAT32_LFN.String[LFNIndex-1][7] = entryBuffer[0x12];
	FAT32_LFN.String[LFNIndex-1][8] = entryBuffer[0x14];
	FAT32_LFN.String[LFNIndex-1][9] = entryBuffer[0x16];
	FAT32_LFN.String[LFNIndex-1][10] = entryBuffer[0x18];		 		  		  	 		 
	FAT32_LFN.String[LFNIndex-1][11] = entryBuffer[0x1C];
	FAT32_LFN.String[LFNIndex-1][12] = entryBuffer[0x1E];

	for (i=0; i<13; i++)
		if (FAT32_LFN.String[LFNIndex-1][i]==0xFF) 
			FAT32_LFN.String[LFNIndex-1][i] = 0x20; // Replace with spaces
} 
//-----------------------------------------------------------------------------
// FATMisc_GetLFNCache: Get a copy of the long filename to into a string buffer
//-----------------------------------------------------------------------------
void FATMisc_GetLFNCache(BYTE *strOut)
{
	int i,index;
	int lfncount = 0;

	// Copy LFN from LFN Cache into a string
	for (index=0;index<FAT32_LFN.no_of_strings;index++)
		for (i=0; i<13; i++)
			strOut[lfncount++] = FAT32_LFN.String[index][i];

	// Null terminate string
	strOut[lfncount]='\0';
}
//-----------------------------------------------------------------------------
// FATMisc_If_LFN_TextOnly: If LFN text entry found
//-----------------------------------------------------------------------------
int FATMisc_If_LFN_TextOnly(FAT32_ShortEntry *entry)
{
	if ((entry->Attr&0x0F)==FILE_ATTR_LFN_TEXT) 
		return 1;
	else 
		return 0;
}
//-----------------------------------------------------------------------------
// FATMisc_If_LFN_Invalid: If SFN found not relating to LFN
//-----------------------------------------------------------------------------
int FATMisc_If_LFN_Invalid(FAT32_ShortEntry *entry)
{
	if ((entry->Name[0]==FILE_HEADER_BLANK)||(entry->Name[0]==FILE_HEADER_DELETED)||(entry->Attr==FILE_ATTR_VOLUME_ID)||(entry->Attr&FILE_ATTR_SYSHID)) 
		return 1;
	else 
		return 0;
}
//-----------------------------------------------------------------------------
// FATMisc_If_LFN_Exists: If LFN exists and correlation SFN found
//-----------------------------------------------------------------------------
int FATMisc_If_LFN_Exists(FAT32_ShortEntry *entry)
{
	if ((entry->Attr!=FILE_ATTR_LFN_TEXT) && (entry->Name[0]!=FILE_HEADER_BLANK) && (entry->Name[0]!=FILE_HEADER_DELETED) && (entry->Attr!=FILE_ATTR_VOLUME_ID) && (!(entry->Attr&FILE_ATTR_SYSHID)) && (FAT32_LFN.no_of_strings))
		return 1;
	else 
		return 0;
}
//-----------------------------------------------------------------------------
// FATMisc_If_noLFN_SFN_Only: If SFN only exists
//-----------------------------------------------------------------------------
int FATMisc_If_noLFN_SFN_Only(FAT32_ShortEntry *entry)
{
	if ((entry->Attr!=FILE_ATTR_LFN_TEXT) && (entry->Name[0]!=FILE_HEADER_BLANK) && (entry->Name[0]!=FILE_HEADER_DELETED) && (entry->Attr!=FILE_ATTR_VOLUME_ID) && (!(entry->Attr&FILE_ATTR_SYSHID)))
		return 1;
	else 
		return 0;
}
//-----------------------------------------------------------------------------
// FATMisc_If_dir_entry: Returns 1 if a directory
//-----------------------------------------------------------------------------
int FATMisc_If_dir_entry(FAT32_ShortEntry *entry)
{
	if (entry->Attr&FILE_TYPE_DIR) 
		return 1;
	else 
		return 0;
}
//-----------------------------------------------------------------------------
// FATMisc_If_file_entry: Returns 1 is a file entry
//-----------------------------------------------------------------------------
int FATMisc_If_file_entry(FAT32_ShortEntry *entry)
{
	if (entry->Attr&FILE_TYPE_FILE) 
		return 1;
	else 
		return 0;
}
