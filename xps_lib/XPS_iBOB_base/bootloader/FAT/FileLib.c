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
#include "FileLib.h"

//-----------------------------------------------------------------------------
// Globals
//-----------------------------------------------------------------------------
FileLib_File Files[MAX_OPEN_FILES];

//-----------------------------------------------------------------------------
//								Internal
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// FindSpareFile: Find a slot in the open files buffer for a new file
//-----------------------------------------------------------------------------
FileLib_File* FindSpareFile()
{
	int i;
	int freeFile = -1;
	for (i=0;i<MAX_OPEN_FILES;i++)
		if (Files[i].inUse == FALSE)
		{
			freeFile = i;
			break;
		}

	if (freeFile!=-1)
		return &Files[freeFile];
	else
		return NULL;
}
//-----------------------------------------------------------------------------
// OpenDirectory: Cycle through path string to find the start cluster
// address of the highest subdir.
//-----------------------------------------------------------------------------
BOOL OpenDirectory(char *path, UINT32 *pathCluster)
{
	int levels;
	int sublevel;
	char currentfolder[MAX_LONG_FILENAME];
	FAT32_ShortEntry sfEntry;
	UINT32 startcluster;

	// Set starting cluster to root cluster
	startcluster = FAT32_GetRootCluster();

	// Find number of levels
	levels = FileString_PathTotalLevels(path);

	// Cycle through each level and get the start sector
	for (sublevel=0;sublevel<(levels+1);sublevel++) 
	{
		FileString_GetSubString(path, sublevel, currentfolder);

		// Find clusteraddress for folder (currentfolder) 
		if (FAT32_GetFileEntry(startcluster, currentfolder,&sfEntry))
			startcluster = (((UINT32)sfEntry.FstClusHI)<<16) + sfEntry.FstClusLO;
		else
			return FALSE;
	}

	*pathCluster = startcluster;
	return TRUE;
}
//-----------------------------------------------------------------------------
//								External API
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// FileLib_Init: Initialise File Library
//-----------------------------------------------------------------------------
void FileLib_Init()
{
	int i;
	for (i=0;i<MAX_OPEN_FILES;i++)
		Files[i].inUse = FALSE;
}
//-----------------------------------------------------------------------------
// fopen: Return start cluster to a file start
//-----------------------------------------------------------------------------
FileLib_File* FileLib_fopen(char *path)
{
	FileLib_File* file; 
	FAT32_ShortEntry sfEntry;

	file = FindSpareFile();
	if (file==NULL)
		return NULL;

	// Clear filename
	memset(file->path, '\n', sizeof(file->path));
	memset(file->filename, '\n', sizeof(file->filename));

	// Split full path into filename and directory path
	FileString_SplitPath(path, file->path, file->filename);

	// If file is in the root dir
	if (file->path[0]==0)
	{
		file->parentcluster = FAT32_GetRootCluster();
		file->inRoot = TRUE;
	}
	else
	{
		file->inRoot = FALSE;

		// Find parent directory start cluster
		if (!OpenDirectory(file->path, &file->parentcluster))
			return NULL;
	}

	// Using dir cluster address search for filename
	if (FAT32_GetFileEntry(file->parentcluster, file->filename,&sfEntry))
	{
		// Initialise file details
		memcpy(file->shortfilename, sfEntry.Name, 11);
		file->filelength = sfEntry.FileSize;
		file->bytenum = 0;
		file->startcluster = (((UINT32)sfEntry.FstClusHI)<<16) + sfEntry.FstClusLO;
		file->currentBlock = 0xFFFFFFFF;
		file->inUse = TRUE;
		return file;
	}

	return NULL;
}
//-----------------------------------------------------------------------------
// fclose: Close an open file
//-----------------------------------------------------------------------------
#if 0
void FileLib_fclose(FileLib_File *file)
{
	if (file!=NULL)
	{
		file->bytenum = 0;
		file->filelength = 0;
		file->startcluster = 0;
		file->currentBlock = 0xFFFFFFFF;
		file->inUse = FALSE;
	}
}
#endif
//-----------------------------------------------------------------------------
// fgetc: Get a character in the stream
//-----------------------------------------------------------------------------
int FileLib_fgetc(FileLib_File *file)
{
	int sector;
	int offset;	
	BYTE returnchar=0;

	if (file==NULL)
		return -1;

	// Check if file open
	if (file->inUse==FALSE)
		return -1;

	// Calculations for file position
	sector = file->bytenum / 512;
	offset = file->bytenum - (sector*512);

	// If file block not already loaded
	if (file->currentBlock!=sector)
	{
		// Read the appropriate sector
		if (!FAT32_SectorReader(file->startcluster, sector)) 
			return -1;

		// Copy to file's buffer
		memcpy(file->filebuf, FATFS_Internal.currentsector, 512);
		file->currentBlock=sector;
	}

	// Get the data block
	returnchar = file->filebuf[offset];

	// Increase next read position
	file->bytenum++;

	// Return character read
	return returnchar;
}
//-----------------------------------------------------------------------------
// FileLib_fread: Read a block of data from the file
//-----------------------------------------------------------------------------
#if 0
int FileLib_fread (FileLib_File *file, BYTE * buffer, UINT32 count)
{
	UINT32 cnt;
	int data;

	if (buffer==NULL || file==NULL)
		return -1;

	// Check if file open
	if (file->inUse==FALSE)
		return -1;

	if (count==0)
		return 0;

	for (cnt=0;cnt<count;cnt++)
	{
		// Get a data byte
		data = FileLib_fgetc(file);
    
		// If past end of file, return count so far
		if (file->bytenum>file->filelength)
			return cnt;

		// If not error or end of file
		if (data!=-1)
			// Add to buffer
			buffer[cnt] = (BYTE)data;
		else
			// If end of file or error, return data count
			// read so far
			return cnt;		
	}

	return count;
}
#endif
//-----------------------------------------------------------------------------
// FileLib_fseek: Seek to a specific place in the file
// TODO: This should support -ve numbers with SEEK END and SEEK CUR
//-----------------------------------------------------------------------------
#if 0
int FileLib_fseek( FileLib_File *file , UINT32 offset , int origin )
{
	if (file==NULL)
		return -1;

	// Check if file open
	if (file->inUse==FALSE)
		return -1;

	if ( (origin == SEEK_END) && (offset!=0) )
		return -1;

	// Invalidate file buffer
	file->currentBlock = 0xFFFFFFFF;

	if (origin==SEEK_SET)
	{
		file->bytenum = offset;

		if (file->bytenum>file->filelength)
			file->bytenum = file->filelength;

		return 0;
	}
	else if (origin==SEEK_CUR)
	{
		file->bytenum+= offset;

		if (file->bytenum>file->filelength)
			file->bytenum = file->filelength;

		return 0;
	}
	else if (origin==SEEK_END)
	{
		file->bytenum = file->filelength;
		return 0;
	}
	else
		return -1;
}
#endif

//-----------------------------------------------------------------------------
// FileLib_fgetpos: Get the current file position
//-----------------------------------------------------------------------------
#if 0
int FileLib_fgetpos(FileLib_File *file , UINT32 * position)
{
	if (file==NULL)
		return -1;

	// Check if file open
	if (file->inUse==FALSE)
		return -1;

	// Get position
	*position = file->bytenum;

	return 0;
}
#endif
