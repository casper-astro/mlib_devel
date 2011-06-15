`ifndef XAUI_KAT_VH
`define XAUI_KAT_VH

/* TENGBE/8_10 constants */

/* channel sync symbol */
`define SYM_A_ 8'h7c 
/* byte align symbol */
`define SYM_K_ 8'hbc
/* idle skip -- clock correction symbol */
`define SYM_R_ 8'h1c
/* error symbol */
`define SYM_E_ 8'hfe

/* XAUI constants */
`define SYM_TERM_ 8'hfd

`define SYM_IDLE_ 8'h07

`define SYM_ERR_ 8'hfe

`define XAUI_IDLE_ 8'h07

`endif
