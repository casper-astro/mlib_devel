// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       soc_system_hps_0_fpga_interfaces_f2h_cold_reset_req
// role:width:direction:                              f2h_cold_rst_req_n:1:Input
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_system_hps_0_fpga_interfaces_f2h_cold_reset_req
(
   sig_f2h_cold_rst_req_n
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input sig_f2h_cold_rst_req_n;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_f2h_cold_rst_req_n_t;

   logic [0 : 0] sig_f2h_cold_rst_req_n_in;
   logic [0 : 0] sig_f2h_cold_rst_req_n_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_f2h_cold_rst_req_n_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "24.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // f2h_cold_rst_req_n
   // -------------------------------------------------------
   function automatic ROLE_f2h_cold_rst_req_n_t get_f2h_cold_rst_req_n();
   
      // Gets the f2h_cold_rst_req_n input value.
      $sformat(message, "%m: called get_f2h_cold_rst_req_n");
      print(VERBOSITY_DEBUG, message);
      return sig_f2h_cold_rst_req_n_in;
      
   endfunction

   assign sig_f2h_cold_rst_req_n_in = sig_f2h_cold_rst_req_n;


   always @(sig_f2h_cold_rst_req_n_in) begin
      if (sig_f2h_cold_rst_req_n_local != sig_f2h_cold_rst_req_n_in)
         -> signal_input_f2h_cold_rst_req_n_change;
      sig_f2h_cold_rst_req_n_local = sig_f2h_cold_rst_req_n_in;
   end
   


// synthesis translate_on

endmodule

