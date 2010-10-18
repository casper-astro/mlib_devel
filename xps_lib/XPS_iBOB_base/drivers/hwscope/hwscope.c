/* ********************************* */
/* *                               * */
/* *    BEE2 Start-up test suite   * */
/* *                               * */
/* ********************************* */

/* 2005 Henry Chen, UCB SETI Group */

/* HWScope access functions */

#include "hwscope.h"
#include "reg.h"
#include "fifo.h"

enum { NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG };

/* Checks status of scope */
/* ********************************* */

void scopestatus_cmd (int argc, char **argv)
/* command = "scopestatus"                                  */
/* help    = "checks scope status"                          */
/* params  = "<hwscope name>"                               */
{
    char *scopename, *regname;
    Xuint32 status;
    int i;

    if (argc != 2)
    {
        xil_printf("Wrong number of arguments\n\r");
        return;
    }

    scopename = argv[1];
    regname = strcat(scopename, "/scopedone");

    for(i = 0; i < NUM_CORES; i++)
    {
        if(strstart(regname, cores[i].name) == FULLMATCH)
        {
            status = sif_reg_read(cores[i].address);

            if (status == 1)
            {
                xil_printf("Scope has been triggered and has finished logging.\n\r");
            }
            else
            {
                xil_printf("Scope has not been triggered.\n\r");
            }

            break;
        }
    }

    if(i == NUM_CORES)
    {
        xil_printf("Could not find scope named '%s'\n\r", scopename);
    }
}

/* Sets the trigger delay of a scope */
/* ********************************* */

void setscopedelay_cmd (int argc, char **argv)
/* command = "scopedelay"                                   */
/* help    = "sets scope trigger delay"                     */
/* params  = "<hwscope name> <delay>"                       */
{
    Xuint32 delay;
    char *scopename, *regname;
    int i;

    if(argc != 3)
    {
        xil_printf("Wrong number of arguments\n\r");
        return;
    }

    scopename = argv[1];
    delay = tinysh_atoxi(argv[2]);

    regname = strcat(scopename, "/trigdly");

    for(i = 0; i < NUM_CORES; i++)
    {
        if(strstart(regname, cores[i].name) == FULLMATCH)
        {
            sif_reg_write(cores[i].address, delay);
            break;
        }
    }

    if(i == NUM_CORES)
    {
        xil_printf("Could not find scope named '%s'\n\r", scopename);
    }

}

/* Resets the scope */
/* ********************************** */

void scopereset_cmd (int argc, char **argv)
/* command = "scopereset"                                   */
/* help    = "resets a scope"                               */
/* params  = "<hwscope name>"                               */
{
    char *scopename, *regname;
    int i;

    if(argc != 2)
    {
        xil_printf("Wrong number of arguments\n\r");
        return;
    }

    scopename = argv[1];

    regname = strcat(scopename, "/scopectrl");

    for(i = 0; i < NUM_CORES; i++)
    {
        if(strstart(regname,cores[i].name) == FULLMATCH)
        {
            sif_reg_write(cores[i].address, 256);
            usleep(50);
            sif_reg_write(cores[i].address, 0);
            break;
        }
    }

    if(i == NUM_CORES)
    {
        xil_printf("Could not find scope named '%s'\n\r",scopename);
    }

}

/* Arms the scope for triggering */
/* ********************************** */

void scopeenable_cmd (int argc, char **argv)
/* command = "scopeenable"                                  */
/* help    = "enables or disables a scope trigger"          */
/* params  = "<hwscope name> <0/1>"                         */
{
    Xuint32 setenable;
    char *scopename, *regname;
    int i, setenable_val;

    if(argc != 3)
    {
        xil_printf("Wrong number of arguments\n\r");
        return;
    }

    scopename = argv[1];
    setenable = tinysh_atoxi(argv[2]);

    if ((setenable != 0) && (setenable != 1))
    {
        xil_printf("Trigger enable/disable is a binary state (0/1)\n\r");
        return;
    }

    regname = strcat(scopename, "/scopectrl");

    for(i = 0; i < NUM_CORES; i++)
    {
        if(strstart(regname,cores[i].name) == FULLMATCH)
        {
            sif_reg_write(cores[i].address, setenable);
            break;
        }
    }

    if(i == NUM_CORES)
    {
        xil_printf("Could not find scope named '%s'\n\r",scopename);
    }
}

/* Get data from a scope */
/* ********************************** */

void scoperead_cmd(int argc, char **argv)
/* command = "scoperead"                                    */
/* help    = "reads data from a scope"                      */
/* params  = "<hwscope name> [<repeat>]"                    */
{
    char *scopename, *fifoname;
    int i,j;
    int fail;
    int repeat;
    Xuint32 value;

    if((argc != 2) && (argc != 3))
    {
        xil_printf("Wrong number of arguments\n\r");
        return;
    }

    scopename = argv[1];

    if(argc == 3)
    {
        repeat = tinysh_atoxi(argv[2]);
    }

    fifoname = strcat(scopename, "/scopefifo");

    for(i = 0; i < NUM_CORES; i++)
    {
        if(strstart(fifoname,cores[i].name) == FULLMATCH)
        {
            if(argc == 3)
            {
                for(j = 0; j < repeat; j++)
                {
                    value = sif_fifo_read_nonblock(cores[i].address, &fail);
                    multiprint(value, j, fail);
                }
            }
            else
            {
                value = sif_fifo_read_nonblock(cores[i].address, &fail);
                multiprint(value, 0, fail);
            }
            break;
        }
    }

    if(i==NUM_CORES)
    {
        xil_printf("Could not find scope named '%s'\n\r", scopename);
    }

}

/* Prints data in binary, decimal, and hex formats */
/* ****************************************************** */

void multiprint (Xuint32 value, int j, int fail)
{
    if(fail)
    {
        xil_printf("0x%04X / %05d -> Operation failed. Scope is empty\n\r", j, j);
    }
    else
    {
        xil_printf("0x%04X / %05d -> 0x%08X / 0b%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d / %010d\n\r",
            j,
            j,
            value,
            (value>>31)&1,
            (value>>30)&1,
            (value>>29)&1,
            (value>>28)&1,
            (value>>27)&1,
            (value>>26)&1,
            (value>>25)&1,
            (value>>24)&1,
            (value>>23)&1,
            (value>>22)&1,
            (value>>21)&1,
            (value>>20)&1,
            (value>>19)&1,
            (value>>18)&1,
            (value>>17)&1,
            (value>>16)&1,
            (value>>15)&1,
            (value>>14)&1,
            (value>>13)&1,
            (value>>12)&1,
            (value>>11)&1,
            (value>>10)&1,
            (value>> 9)&1,
            (value>> 8)&1,
            (value>> 7)&1,
            (value>> 6)&1,
            (value>> 5)&1,
            (value>> 4)&1,
            (value>> 3)&1,
            (value>> 2)&1,
            (value>> 1)&1,
            (value>> 0)&1,
            value);
    }
}