#include "define.h"

#ifndef __SD_ACCESS_H__
#define __SD_ACCESS_H__

//-----------------------------------------------------------------------------
//  Globals
//-----------------------------------------------------------------------------
struct 
{
 	   BYTE currentsector[512];
	   UINT32 SectorCurrentlyLoaded; // Initially Load to 0xffffffff;
	   UINT32 maxLBA;
} SD_Internal;

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------
BYTE SD_SectorByte(UINT16 sublocation);
UINT16 SD_SectorWord(UINT16 sublocation);
UINT32 SD_SectorUI32(UINT16 sublocation);
BOOL SD_BufferSector(UINT32 LBALocation);
void SD_Init(void);

#endif
