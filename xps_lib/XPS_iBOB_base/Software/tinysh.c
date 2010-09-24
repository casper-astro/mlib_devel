/*
 * tinysh.c
 *
 * Minimal portable shell
 *
 * Copyright (C) 2001 Michel Gutierrez <mig@nerim.net>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free
 * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/* Modified by Pierre-Yves Droz to support Windows consoles */

#include "tinysh.h"

#include "xparameters.h"
#include "xuartlite_l.h"
#include <stdio.h>
#include <stdlib.h>
#include "xbasic_types.h"
#include "tinysh_util.h"
#include "core_info.h"

#ifndef BUFFER_SIZE
#define BUFFER_SIZE 256
#endif
#ifndef HISTORY_DEPTH
#define HISTORY_DEPTH 16
#endif
#ifndef MAX_ARGS
#define MAX_ARGS 16
#endif
#ifndef PROMPT_SIZE
#define PROMPT_SIZE 16
#endif
#ifndef TOPCHAR
#define TOPCHAR '\\'
#endif

typedef unsigned char uchar;
/* redefine some useful and maybe missing utilities to avoid conflicts */
#define strlen tinysh_strlen
#define puts tinysh_puts

typedef struct tinysh_args {
  int argc;
  char **argv;
} tinysh_args;

/* Prototypes */
static void help_fnt(int argc, char **argv);

static tinysh_cmd_t help_cmd={ 
  0,"help","display help\n\r","<cr>",help_fnt,0,0,0 };

static uchar input_buffers[HISTORY_DEPTH][BUFFER_SIZE+1]={0};
static uchar trash_buffer[BUFFER_SIZE+1]={0};
static int cur_buf_index=0;
static int cur_buf_index_for_viewing=0;
static uchar context_buffer[BUFFER_SIZE+1]={0};
static int cur_context=0;
static int cur_index=0;
static int echo=1;
static char prompt[PROMPT_SIZE+1]="$ ";
static tinysh_cmd_t *root_cmd=&help_cmd;
static tinysh_cmd_t *cur_cmd_ctx=0;
static void *tinysh_arg=0;
// Exclude binary and info transactions from lwip builds
#ifndef LWIP_ENABLE
static void binary_transaction();
static void info_transaction();
#else
struct conn_state;
extern struct conn_state * telnetstate;
extern Xuint8 printmode;
void close_conn(struct conn_state *ws);
#endif

tinysh_args args;

/* few useful utilities that may be missing */

static int strlen(uchar *s)
{
  int i;
  for(i=0;*s;s++,i++);
  return i;
}

static void puts(char *s)
{
  while(*s)
    tinysh_char_out(*s++);
}

/* callback for help function
 */
static void help_fnt(int argc, char **argv)
{
  puts("?            display help on given or available commands\n\r");
  puts("<TAB>        auto-completion\n\r");
  puts("<cr>         execute command line\n\r");
  puts("CTRL-P       recall previous input line\n\r");
  puts("CTRL-N       recall next input line\n\r");
  puts("<any>        treat as input character\n\r");
  puts("\n\r");
  puts("number format :\n\r");
  puts("\t123  : integer\n\r");
  puts("\t0x7b : hexadecimal (x7b is also accepted)\n\r");
}

/*
 */

/* verify if the non-spaced part of s2 is included at the begining
 * of s1.
 * return FULLMATCH if s2 equal to s1, PARTMATCH if s1 starts with s2
 * but there are remaining chars in s1, UNMATCH if s1 does not start with
 * s2
 */
match_t strstart(uchar *s1, uchar *s2)
{
  while(*s1 && *s1==*s2) { s1++; s2++; }

  if(*s2==' ' || *s2==0)
    {
      if(*s1==0)
        return FULLMATCH; /* full match */
      else
        return PARTMATCH; /* partial match */ 
    }
  else
    return UNMATCH;     /* no match */
}

/*
 * check commands at given level with input string.
 * _cmd: point to first command at this level, return matched cmd
 * _str: point to current unprocessed input, return next unprocessed
 */
static int parse_command(tinysh_cmd_t **_cmd, uchar **_str)
{
  uchar *str=*_str;
  tinysh_cmd_t *cmd;
  int matched_len=0;
  tinysh_cmd_t *matched_cmd=0;

  /* first eliminate first blanks */
  while(*str==' ') str++;
  if(!*str)
    {
      *_str=str;
      return NULLMATCH; /* end of input */
    }
  
  /* first pass: count matches */
  for(cmd=*_cmd;cmd;cmd=cmd->next)
    {
      int ret=strstart(cmd->name,str);

      if(ret==FULLMATCH)
        {
          /* found full match */
          while(*str && *str!=' ') str++; 
          while(*str==' ') str++;
          *_str=str;
          *_cmd=cmd;
          return MATCH;
        }
      else if (ret==PARTMATCH)
        {
          if(matched_cmd)
            {
              *_cmd=matched_cmd;
              return AMBIG;
            }
          else
            {
              matched_cmd=cmd;
            }
        }
      else /* UNMATCH */
        {
        }
    }
  if(matched_cmd)
    {
      while(*str && *str!=' ') str++; 
      while(*str==' ') str++;
      *_cmd=matched_cmd;
      *_str=str;
      return MATCH;
    }
  else
    return UNMATCH;
}

/* create a context from current input line
 */
static void do_context(tinysh_cmd_t *cmd, uchar *str)
{
  while(*str) 
    context_buffer[cur_context++]=*str++;
  context_buffer[cur_context]=0;
  cur_cmd_ctx=cmd;
}

/* execute the given command by calling callback with appropriate 
 * arguments
 */
static void exec_command(tinysh_cmd_t *cmd, uchar *str)
{
  int pid;
  char *argv[MAX_ARGS];
  int argc=0;
  int i;
  int quotemode=0;

/* copy command line to preserve it for history */
  for(i=0;i<BUFFER_SIZE;i++)
    trash_buffer[i]=str[i];
  str=trash_buffer;
  
/* cut into arguments */
  argv[argc++]=cmd->name;
  while(*str && argc<MAX_ARGS)
    {
      while(*str==' ') str++;
      if(*str==0)
        break;
      if(*str=='\"')
        {
          argv[argc++]=++str;
          while(*str!='\"' && *str) str++;
        }
      else
        {
          argv[argc++]= str;
          while(*str!=' ' && *str) str++;
        }
      if(!*str) break;
      *str++=0;
    }

/* call the correct function */
  if(cmd->function)
    {
      tinysh_arg=cmd->arg;
      cmd->function(argc, &argv[0]);
    }

}

/* try to execute the current command line
 */
static int exec_command_line(tinysh_cmd_t *cmd, uchar *_str)
{
  uchar *str=_str;

  while(1)
    {
      int ret;
      ret=parse_command(&cmd,&str);
      if(ret==MATCH) /* found unique match */
        {
          if(cmd)
            {
              if(!cmd->child) /* no sub-command, execute */
                {
                  exec_command(cmd,str);
                  return 0;
                }
              else
                {
                  if(*str==0) /* no more input, this is a context */
                    {
                      do_context(cmd,_str);
                      return 0;
                    }
                  else /* process next command word */
                    {
                      cmd=cmd->child;
                    }
                }
            } 
          else /* cmd == 0 */
            {
              return 0;
            }
        }
      else if(ret==AMBIG)
        {
          puts("ambiguity: ");
          puts(str);
          tinysh_char_out('\n');
          tinysh_char_out('\r');
          return 0;
        }
      else if(ret==UNMATCH) /* UNMATCH */
        {
          puts("no match: ");
          puts(str);
          tinysh_char_out('\n');
          tinysh_char_out('\r');
          return 0;
        }
      else /* NULLMATCH */
        return 0;
    }
}

/* display help for list of commands 
*/
static void display_child_help(tinysh_cmd_t *cmd)
{
  tinysh_cmd_t *cm;
  int len=0;

  tinysh_char_out('\n');
  tinysh_char_out('\r');
  for(cm=cmd;cm;cm=cm->next)
    if(len<strlen(cm->name))
      len=strlen(cm->name);
  for(cm=cmd;cm;cm=cm->next)
    if(cm->help)
      {
        int i;
        puts(cm->name);
        for(i=strlen(cm->name);i<len+2;i++)
          tinysh_char_out(' ');
        puts(cm->help);
        tinysh_char_out('\n');
        tinysh_char_out('\r');
      }
}

/* try to display help for current comand line
 */
static int help_command_line(tinysh_cmd_t *cmd, uchar *_str)
{
  uchar *str=_str;

  while(1)
    {
      int ret;
      ret=parse_command(&cmd,&str);
      if(ret==MATCH && *str==0) /* found unique match or empty line */
        {
          tinysh_cmd_t *cm;
          int len=0;
              
          if(cmd->child) /* display sub-commands help */
            {
              display_child_help(cmd->child);
              return 0;
            }
          else  /* no sub-command, show single help */
            {
              if(*(str-1)!=' ')
                tinysh_char_out(' ');
              if(cmd->usage)
                puts(cmd->usage);
              puts(": ");
              if(cmd->help)
                puts(cmd->help);
              else
                puts("no help available");
              tinysh_char_out('\n');
              tinysh_char_out('\r');
            }
          return 0;
        }
      else if(ret==MATCH && *str)
        { /* continue processing the line */
          cmd=cmd->child;
        }
      else if(ret==AMBIG)
        {
          puts("\n\rambiguity: ");
          puts(str);
          tinysh_char_out('\n');
          tinysh_char_out('\r');
          return 0;
        }
      else if(ret==UNMATCH)
        {
          puts("\n\rno match: ");
          puts(str);
          tinysh_char_out('\n');
          tinysh_char_out('\r');
          return 0;
        }
      else /* NULLMATCH */
        {
          if(cur_cmd_ctx)
            display_child_help(cur_cmd_ctx->child);
          else
            display_child_help(root_cmd);
          return 0;
        }
    }
}

/* try to complete current command line
 */
static int complete_command_line(tinysh_cmd_t *cmd, uchar *_str)
{
  uchar *str=_str;

  while(1)
    {
      int ret;
      int common_len=BUFFER_SIZE;
      int _str_len;
      int i;
      uchar *__str=str;

      tinysh_cmd_t *_cmd=cmd;
      ret=parse_command(&cmd,&str);
      for(_str_len=0;__str[_str_len]&&__str[_str_len]!=' ';_str_len++);
      if(ret==MATCH && *str)
        {
          cmd=cmd->child;
        }
      else if(ret==AMBIG || ret==MATCH || ret==NULLMATCH)
        {
          tinysh_cmd_t *cm;
          tinysh_cmd_t *matched_cmd=0;
          int nb_match=0;
              
          for(cm=cmd;cm;cm=cm->next)
            {
              int r=strstart(cm->name,__str);
              if(r==FULLMATCH)
                {
                  for(i=_str_len;cmd->name[i];i++)
                    tinysh_char_in(cmd->name[i]);
                  if(*(str-1)!=' ')
                    tinysh_char_in(' ');
                  if(!cmd->child)
                    {
                      if(cmd->usage)
                        {
                          puts(cmd->usage);
                          tinysh_char_out('\n');
                          tinysh_char_out('\r');
                          return 1;
                        }
                      else
                        return 0;
                    }
                  else
                    {
                      cmd=cmd->child;
                      break;
                    }
                }
              else if(r==PARTMATCH)
                {
                  nb_match++;
                  if(!matched_cmd)
                    {
                      matched_cmd=cm;
                      common_len=strlen(cm->name);
                    }
                  else
                    {
                      for(i=_str_len;cm->name[i] && i<common_len &&
                            cm->name[i]==matched_cmd->name[i];i++);
                      if(i<common_len)
                        common_len=i;
                    }
                }
            }
          if(cm)
            continue;
          if(matched_cmd)
            {
              if(_str_len==common_len)
                {
                  tinysh_char_out('\n');
                  tinysh_char_out('\r');
                  for(cm=cmd;cm;cm=cm->next)
                    {
                      int r=strstart(cm->name,__str);
                      if(r==FULLMATCH || r==PARTMATCH)
                        {
                          puts(cm->name);
                          tinysh_char_out('\n');
                          tinysh_char_out('\r');
                        }
                    }
                  return 1;
                }
              else
                {
                  for(i=_str_len;i<common_len;i++)
                    tinysh_char_in(matched_cmd->name[i]);
                  if(nb_match==1)
                    tinysh_char_in(' ');
                }
            }
          return 0;
        }
      else /* UNMATCH */
        { 
          return 0;
        }
    }
}

/* start a new line 
 */
static void start_of_line()
{
  /* display start of new line */
  puts(prompt);
  if(cur_context)
    {
      puts(context_buffer);
      puts("> ");
    }
  cur_index=0;
}

static int last_was_escape=0;
static int last_was_switch=0;
static int last_was_dummy=0;

void repeat_line()
{
  uchar *line=input_buffers[cur_buf_index];

  usleep(10000);
  puts("\n\r");
  puts(prompt);
  puts(line);
}

/* character input 
 */
static void _tinysh_char_in(uchar c)
{
uchar *line=input_buffers[cur_buf_index];
int i;

// Exclude binary and info transactions from lwip builds
#ifndef LWIP_ENABLE
  if(c==128) // start binary transaction
    {
      binary_transaction();
      return;
    }
  if(c==129) // start info transaction
    {
      info_transaction();
      return;
    }
#else
  // CTRL-D from network at (or even before) beginning of line
  if(c==4 && printmode==1 && cur_index<=0)
    {
      close_conn(telnetstate);
      return;
    }
#endif // LWIP_ENABLE

  if(last_was_switch)
    {
      last_was_switch = 0;
    }
  else if(last_was_escape)
    {
      last_was_escape=0;
      last_was_dummy=1;
    }
  else if(last_was_dummy)
    {
      if(c==65) /* up arrow: back in history */
        {
          int prevline=(cur_buf_index_for_viewing+HISTORY_DEPTH-1)%HISTORY_DEPTH;

          if(input_buffers[prevline][0])
            {
              line=input_buffers[prevline];
              /* fill the rest of the line with spaces */
              while(cur_index-->strlen(line))
                puts("\b \b");
              tinysh_char_out('\r');
              start_of_line();
              puts(line);
              cur_index=strlen(line);
              cur_buf_index_for_viewing=prevline;
              line=input_buffers[cur_buf_index];
              for(i=0;input_buffers[cur_buf_index_for_viewing][i]!=0;i++)
                input_buffers[cur_buf_index][i]=input_buffers[cur_buf_index_for_viewing][i];
              input_buffers[cur_buf_index][i] = 0;
            }
        }
      else if(c==66) /* down: next in history */
        {
          int nextline=(cur_buf_index_for_viewing+1)%HISTORY_DEPTH;

          if(input_buffers[nextline][0])
            {
              line=input_buffers[nextline];
              /* fill the rest of the line with spaces */
              while(cur_index-->strlen(line))
                puts("\b \b");
              tinysh_char_out('\r');
              start_of_line();
              puts(line);
              cur_index=strlen(line);
              cur_buf_index_for_viewing=nextline;
              line=input_buffers[cur_buf_index];
              for(i=0;input_buffers[cur_buf_index_for_viewing][i]!=0;i++)
                input_buffers[cur_buf_index][i]=input_buffers[cur_buf_index_for_viewing][i];
              input_buffers[cur_buf_index][i] = 0;
            }
        }
      last_was_dummy=0;
    }
  else
    {

      if(c=='\n' || c=='\r') /* validate command */
        {
          tinysh_cmd_t *cmd;
          int context=0;
      
    /* first, echo the newline */
          if(echo)
            tinysh_char_out('\n');
            tinysh_char_out('\r');

          line=input_buffers[cur_buf_index];
          input_buffers[cur_buf_index][strlen(line)]=0;
          if(*line) /* not empty line */
            {
              cmd=cur_cmd_ctx?cur_cmd_ctx->child:root_cmd;
              exec_command_line(cmd,line);
              cur_buf_index=(cur_buf_index+1)%HISTORY_DEPTH;
              cur_index=0;
              input_buffers[cur_buf_index][0]=0;
              cur_buf_index_for_viewing=cur_buf_index;
            }
          start_of_line();
        }
      else if(c==TOPCHAR) /* return to top level */
        {
          if(echo)
            tinysh_char_out(c);

          cur_context=0;
          cur_cmd_ctx=0;
        }
      else if(c==8 || c==127) /* backspace */
        {
          if(cur_index>0)
            {
              puts("\b \b");
              cur_index--;
              line[cur_index]=0;
            }
        }
      else if(c=='~') /* repeat the current line */
        {
          repeat_line();
        }
      else if(c==3) /* cancel the current line */
        {
          if(echo)
            tinysh_char_out('\n');
            tinysh_char_out('\r');
          line=input_buffers[cur_buf_index];
          input_buffers[cur_buf_index][strlen(line)]=0;
          start_of_line();
        }
      else if(c=='`') /* switch FPGA */
        {
          last_was_switch=1;
        }
      else if(c==16) /* CTRL-P: back in history */
        {
          int prevline=(cur_buf_index_for_viewing+HISTORY_DEPTH-1)%HISTORY_DEPTH;

          if(input_buffers[prevline][0])
            {
              line=input_buffers[prevline];
              /* fill the rest of the line with spaces */
              while(cur_index-->strlen(line))
                puts("\b \b");
              tinysh_char_out('\r');
              start_of_line();
              puts(line);
              cur_index=strlen(line);
              cur_buf_index_for_viewing=prevline;
              line=input_buffers[cur_buf_index];
              for(i=0;input_buffers[cur_buf_index_for_viewing][i]!=0;i++)
                input_buffers[cur_buf_index][i]=input_buffers[cur_buf_index_for_viewing][i];
              input_buffers[cur_buf_index][i] = 0;
            }
        }
      else if(c==14) /* CTRL-N: next in history */
        {
          int nextline=(cur_buf_index_for_viewing+1)%HISTORY_DEPTH;

          if(input_buffers[nextline][0])
            {
              line=input_buffers[nextline];
              /* fill the rest of the line with spaces */
              while(cur_index-->strlen(line))
                puts("\b \b");
              tinysh_char_out('\r');
              start_of_line();
              puts(line);
              cur_index=strlen(line);
              cur_buf_index_for_viewing=nextline;
              line=input_buffers[cur_buf_index];
              for(i=0;input_buffers[cur_buf_index_for_viewing][i]!=0;i++)
                input_buffers[cur_buf_index][i]=input_buffers[cur_buf_index_for_viewing][i];
              input_buffers[cur_buf_index][i] = 0;
            }
        }
      else if(c=='?') /* display help */
        {
          tinysh_cmd_t *cmd;
          cmd=cur_cmd_ctx?cur_cmd_ctx->child:root_cmd;
          help_command_line(cmd,line);
          start_of_line();
          puts(line);
          cur_index=strlen(line);
        }
      else if(c==9 || c=='!') /* TAB: autocompletion */
        {
          tinysh_cmd_t *cmd;
          cmd=cur_cmd_ctx?cur_cmd_ctx->child:root_cmd;
          if(complete_command_line(cmd,line))
            {
              start_of_line();
              puts(line);
            }
          cur_index=strlen(line);
        }      
      else if(c==27)
        {
          last_was_escape=1;
        }
      else /* any input character */
        {
          if(cur_index<BUFFER_SIZE)
            {
              if(echo)
                tinysh_char_out(c);
              line[cur_index++]=c;
              line[cur_index]=0;
            }
        }
    }

}

/* new character input */
void tinysh_char_in(uchar c)
{
  /*
   * filter characters here
   */
  _tinysh_char_in(c);
}

/* add a new command */
void tinysh_add_command(tinysh_cmd_t *cmd)
{
  tinysh_cmd_t *cm;

  if(cmd->parent)
    {
      cm=cmd->parent->child;
      if(!cm)
        {
          cmd->parent->child=cmd;
        }
      else
        {
          while(cm->next) cm=cm->next;
          cm->next=cmd;
        }
    }
  else if(!root_cmd)
    {
      root_cmd=cmd;
    }
  else
    {
      cm=root_cmd;
      while(cm->next) cm=cm->next;
      cm->next=cmd;      
    }
}

/* modify shell prompt
 */
void tinysh_set_prompt(char *str)
{
  int i;

  for(i=0;str[i] && i<PROMPT_SIZE;i++)
    prompt[i]=str[i];
  prompt[i]=0;
  echo = (i!=0);
}

/* return current command argument
 */
void *tinysh_get_arg()
{
  return tinysh_arg;
}

/* string to decimal/hexadecimal conversion
 */
unsigned long tinysh_atoxi(char *s)
{
  char c;
  int ishex=0;
  unsigned long res=0;
  int isneg=(s && *s=='-');

  /* If s is null or empty, return 0 */
  if(s==NULL||*s==0) {
    return 0;
  }

  if(isneg) {
      s++;
  }

  if(s[0]=='0' && s[1]=='x') {
      s++;
  }

  if(*s=='x')
    {
      ishex=1;
      s+=1;
    }

  while(*s)
    {
      // Setting bit 0x20 makes letters lowercase
      // (also could turn control characters into numbers,
      // but live with that possibility in the interest of
      // code size minimization. - DM)
      c = *s | 0x20;

      if(ishex)
        res*=16;
      else
        res*=10;

      if(c>='0' && c<='9')
        res+=c-'0';
      else if(ishex && c>='a' && c<='f')
        res+=c+10-'a';
      else
        break;
      
      s++;
    }

  return isneg ? -res : res;
}

void clear_screen()
{
  int i = 0 ;
  for(; i < 80; i++ )
    {
      tinysh_char_out('\r');
      tinysh_char_out('\n');
    }
}

// Exclude binary and info transactions from lwip builds
#ifndef LWIP_ENABLE
void info_transaction()
{
        char core_name[256];
        char *name;
        char c;
        int i;

        /* read core name */
        name = core_name;
        do {
                c = inbyte();
                *(name++) = c;
        } while(c!=0);

        /* find core in core list */
        for(i=0;i<NUM_CORES;i++)
                if(strstart(core_name,cores[i].name)==FULLMATCH)
                {
                        if(cores[i].type == xps_bram)
                        {
                                /* output succes code */
                                outbyte(0);
                                /* output result string */
                                xil_printf("xps_bram;address=0x%08X;size=%s",cores[i].address,cores[i].params);
                                /* end of string */
                                outbyte(0);
                        } else 
                        if(cores[i].type == xps_sw_reg)
                        {
                                /* output succes code */
                                outbyte(0);
                                /* output result string */
                                xil_printf("xps_sw_reg;address=0x%08X;direction=%s",cores[i].address,cores[i].params);
                                /* end of string */
                                outbyte(0);
                        } else {
                                /* output error code */
                                outbyte(1);
                                /* output error string */
                                xil_printf("Block is of unsupported type");
                                /* end of string */
                                outbyte(0);
                        }
                        break;
                }

        if(i==NUM_CORES) {
                /* output error code */
                outbyte(2);
                /* output error string */
                xil_printf("Block does not exist");
                /* end of string */
                outbyte(0);
        }
                
}






void binary_transaction()
{
        Xuint32 address = 0;
        Xuint8 access_type;
        Xuint32 data = 0;
        int write;
        int size;
        int i;

        /* access type and size */
        access_type = inbyte();
        write = access_type >> 7;
        size = access_type & 0x7F;

        /* the address */
        address |= inbyte();
        address <<= 8;
        address |= inbyte();
        address <<= 8;
        address |= inbyte();
        address <<= 8;
        address |= inbyte();

        /* if it's a write, we read the data to write */
        if(write == 1)
                for(i=0;i<size;i++)
                {
                        data = inbyte();
                        data <<= 8;
                        data |= inbyte();
                        data <<= 8;
                        data |= inbyte();
                        data <<= 8;
                        data |= inbyte();
                        XIo_Out32(address + 4*i,data);
                }

        /* if it's a read, we send the data */
        if(write == 0)
                for(i=0;i<size;i++)
                {
                        data = XIo_In32(address + 4*i);
                        outbyte(data >> 24);
                        outbyte(data >> 16);
                        outbyte(data >>  8);
                        outbyte(data >>  0);
                }
}
#endif // LWIP_ENABLE
