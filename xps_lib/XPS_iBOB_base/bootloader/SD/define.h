//-------------------------------------------------------------
// Global Defines
//-------------------------------------------------------------
#ifndef __DEFINE_H__
#define __DEFINE_H__

#include <stdlib.h>
#include <stdlib.h>
#include <string.h>

//-------------------------------------------------------------
// Configuration
//-------------------------------------------------------------

// Max filename Length 
#define MAX_LONG_FILENAME		128
// Max open files (reduce to lower mem requirements)
#define MAX_OPEN_FILES			1

//-------------------------------------------------------------
// Structures/Typedefs
//-------------------------------------------------------------

#ifndef BYTE
	typedef unsigned char BYTE;
#endif

#ifndef BOOL
	typedef int BOOL;
#endif

#ifndef UINT16
	typedef unsigned short UINT16;
#endif

#ifndef UINT32
	typedef unsigned long UINT32;
#endif

#ifndef TRUE
	#define TRUE 1
#endif

#ifndef FALSE
	#define FALSE 0
#endif

#ifndef NULL
	#define NULL 0
#endif


#endif
