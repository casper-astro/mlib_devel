#include "define.h"

#ifndef __FILELIB_H__
#define __FILELIB_H__

//-----------------------------------------------------------------------------
// Defines
//-----------------------------------------------------------------------------
#ifndef SEEK_CUR
	#define SEEK_CUR    1
#endif
#ifndef SEEK_END
	#define SEEK_END    2
#endif
#ifndef SEEK_SET
	#define SEEK_SET    0
#endif

//-----------------------------------------------------------------------------
// Global Structures
//-----------------------------------------------------------------------------
typedef struct 
{
	UINT32	parentcluster;
	UINT32	startcluster;
	UINT32	bytenum;
	UINT32  currentBlock;
	UINT32  filelength;
	char	path[MAX_LONG_FILENAME];
	char	filename[MAX_LONG_FILENAME];
	BYTE	filebuf[512];
	BYTE	shortfilename[11];
	BOOL	inUse;
	BOOL	inRoot;
}FileLib_File;

//-----------------------------------------------------------------------------
// Prototypes
//-----------------------------------------------------------------------------

// Internal
BOOL OpenDirectory(char *path, UINT32 *pathCluster);
FileLib_File*	FindSpareFile();

// External
void				FileLib_Init();
FileLib_File*		FileLib_fopen(char *path);
void				FileLib_fclose(FileLib_File *file);
int					FileLib_fgetc(FileLib_File *file);
int					FileLib_fread(FileLib_File *file, BYTE * buffer, UINT32 count);
int					FileLib_fseek( FileLib_File *file , UINT32 offset , int origin );
int					FileLib_fgetpos(FileLib_File *file , UINT32 * position);

#endif
