//-----------------------------------------------------------------------
//	File:		RCSfile: ddr2dimm.v,v $
//	Version:	Revision: 1.1.1.1 $
//	Desc:		DDR2 DIMM Model
//	Author:		Greg Gibeling
//	Copyright:	Copyright 2004 UC Berkeley
//	This copyright header must appear in all derivative works.
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//	Section:	Change Log
//-----------------------------------------------------------------------
//	Log: ddr2dimm.v,v $
//	Revision 1.1.1.1  2005-11-08 08:45:48  alschult
//	Initial checkin
//	
//	Revision 1.1.1.1  2005/11/08 06:02:52  alschult
//	Initial checkin 
//	
//	Revision 1.1.1.1  2005/10/20 06:20:17  alschult
//	Initial checkin from old CVS
//	
//	Revision 1.1.1.1  2005/08/17 07:02:14  alschult
//	Initial import
//	
//	Revision 1.1  2004/11/17 22:41:00  sshd_server
//	Initial Import
//	
//-----------------------------------------------------------------------

`timescale 1ns/1ps

//-----------------------------------------------------------------------
//	Module:		ddr2dimm
//	Desc:		...
//-----------------------------------------------------------------------
module	ddr2dimm(	ClockPos, ClockNeg,
			ODT, CKE, CS_N,
			RAS_N, CAS_N, WE_N,
			BA,
			A,
			DM,
			DQ,
			DQS, DQS_N,
		);
	//---------------------------------------------------------------
	//	Parameters
	//---------------------------------------------------------------
	parameter  bawidth =		3,
				awidth =		14;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	I/Os
	//---------------------------------------------------------------
	input   [2:0]           ClockPos, ClockNeg;
	input   [1:0]           ODT, CKE, CS_N;
	input                   RAS_N, CAS_N, WE_N;
	input   [bawidth-1:0]   BA;
	input   [awidth-1:0]    A;
	input   [8:0]           DM;
	inout   [71:0]          DQ;
	inout   [8:0]           DQS, DQS_N;

	wire    [2:0]           #0.8  ClockPos, ClockNeg;
	wire    [1:0]           #1    ODT, CKE, CS_N;
	wire                    #1    RAS_N, CAS_N, WE_N;
	wire    [bawidth-1:0]   #1    BA;
	wire    [awidth-1:0]    #1    A;
	wire    [8:0]           #0.8  DM;
	wire    [71:0]          #0.8  DQ;
	wire    [8:0]           #0.8  DQS, DQS_N;

	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Wires and Regs
	//---------------------------------------------------------------
	genvar i, j;
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Rank 0
	//---------------------------------------------------------------
	generate for (i = 1; i <= 9; i = i + 1) begin:R0C
		ddr2		chip(	.CLK(		ClockPos[(i-1)/3]),
					.CLK_N(		ClockNeg[(i-1)/3]),
                    .CKE(       CKE[0]),
                    .CS_N(      CS_N[0]),
                    .RAS_N(     RAS_N),
                    .CAS_N(     CAS_N),
                    .WE_N(      WE_N),
                    .DM_RDQS(   DM[i-1]),
                    .BA(        BA[1:0]),
                    .ADDR(      A),
                    .DQ(        DQ[(i*8)-1:(i-1)*8]),
                    .DQS(       DQS[i-1]),
                    .DQS_N(     DQS_N[i-1]),
                    .RDQS_N(    ),
                    .ODT(		ODT[0]));
	end endgenerate
	//---------------------------------------------------------------

	//---------------------------------------------------------------
	//	Rank 1
	//---------------------------------------------------------------
	generate for (i = 1; i <= 9; i = i + 1) begin:R1C
		ddr2		chip(	.CLK(		ClockPos[(i-1)/3]),
					.CLK_N(		ClockNeg[(i-1)/3]),
					.CKE(		CKE[1]),
					.CS_N(		CS_N[1]),
					.RAS_N(		RAS_N),
					.CAS_N(		CAS_N),
					.WE_N(		WE_N),
					.DM_RDQS(	DM[i-1]),
					.BA(		BA[1:0]),
					.ADDR(		A),
					.DQ(		DQ[(i*8)-1:(i-1)*8]),
					.DQS(		DQS[i-1]),
					.DQS_N(		DQS_N[i-1]),
					.RDQS_N(	),
					.ODT(		ODT[1]));
	end endgenerate
//---------------------------------------------------------------
endmodule
//-----------------------------------------------------------------------
