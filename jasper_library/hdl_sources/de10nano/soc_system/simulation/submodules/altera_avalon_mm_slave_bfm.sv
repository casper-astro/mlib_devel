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


// $File: //acds/rel/24.1std/ip/sopc/components/verification/altera_avalon_mm_slave_bfm/altera_avalon_mm_slave_bfm.sv $
// $File: //acds/rel/24.1std/ip/sopc/components/verification/altera_avalon_mm_slave_bfm/altera_avalon_mm_slave_bfm.sv $
// $Revision: #1 $
// $Date: 2023/12/11 $
// $Author: psgswbuild $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_avalon_mm_slave_bfm
// =head1 SYNOPSIS
// Memory Mapped Avalon Slave Bus Functional Model (BFM)
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a memory mapped Avalon Slave Bus Functional Model (BFM)
//
// =head1 UNSUPPORTED FEATURES
// Please note that this BFM does not support the interface parameters:
// holdTime and setupTime.
// Also, this BFM does not support the following interface ports: resetrequest
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps

module altera_avalon_mm_slave_bfm(
                                  clk,   
                                  reset,
                                  
                                  avs_clken,
                                  
                                  avs_waitrequest,
                                  avs_write,
                                  avs_read,
                                  avs_address,
                                  avs_byteenable,
                                  avs_burstcount,
                                  avs_beginbursttransfer,
                                  avs_begintransfer,
                                  avs_writedata,
                                  avs_readdata,
                                  avs_readdatavalid,
                                  avs_arbiterlock,
                                  avs_lock,
                                  avs_debugaccess,

                                  avs_transactionid,        // Deprecated
                                  avs_readresponse,         // Deprecated
                                  avs_readid,               // Deprecated
                                  avs_writeresponserequest, // Deprecated
                                  avs_writeresponsevalid,
                                  avs_writeresponse,        // Deprecated
                                  avs_writeid,              // Deprecated
                                  avs_response
                                  );

   // =head1 PARAMETERS
   parameter AV_ADDRESS_W             = 16; // Address width
   parameter AV_SYMBOL_W              = 8;  // Symbol width (default is byte)
   parameter AV_NUMSYMBOLS            = 4;  // Number of symbols per word
   parameter AV_BURSTCOUNT_W          = 3;  // Burst port width
   parameter AV_READRESPONSE_W        = 8;  // Read response port width
   parameter AV_WRITERESPONSE_W       = 8;  // Write response port width   

   parameter USE_READ                 = 1;  // Use read interface pin
   parameter USE_WRITE                = 1;  // Use write interface pin
   parameter USE_ADDRESS              = 1;  // Use address interface pinsp
   parameter USE_BYTE_ENABLE          = 1;  // Use byte_enable interface pins
   parameter USE_BURSTCOUNT           = 1;  // Use burstcount interface pin
   parameter USE_READ_DATA            = 1;  // Use readdata interface pin
   parameter USE_READ_DATA_VALID      = 1;  // Use readdatavalid interface pin
   parameter USE_WRITE_DATA           = 1;  // Use writedata interface pin
   parameter USE_BEGIN_TRANSFER       = 1;  // Use begintransfer interface pin
   parameter USE_BEGIN_BURST_TRANSFER = 1;  // Use beginbursttransfer interface pin    
   parameter USE_WAIT_REQUEST         = 1;  // Use waitrequest interface pin
   parameter USE_ARBITERLOCK          = 0;  // Use arbiterlock interface pin
   parameter USE_LOCK                 = 0;  // Use lock interface pin
   parameter USE_DEBUGACCESS          = 0;  // Use debugaccess interface pin
   parameter USE_TRANSACTIONID        = 0;  // Use transactionid interface pin
   parameter USE_WRITERESPONSE        = 0;  // Use write response interface pins
   parameter USE_READRESPONSE         = 0;  // Use read response interface pins 
   parameter USE_CLKEN                = 0;  // Use NTCM interface pins     

   parameter AV_FIX_READ_LATENCY      = 0;  // Fixed read latency (cycles)
   parameter AV_MAX_PENDING_READS     = 1;  // Max pending pipelined reads
   parameter AV_MAX_PENDING_WRITES    = 0;  // Max pending pipelined writes

   parameter AV_BURST_LINEWRAP        = 0;  // Line wrap bursts (y/n)
   parameter AV_BURST_BNDR_ONLY       = 0;  // Assert Addr alignment

   parameter AV_READ_WAIT_TIME        = 0;  // Fixed wait time cycles when
   parameter AV_WRITE_WAIT_TIME       = 0;  // USE_WAIT_REQUEST is 0
   parameter REGISTER_WAITREQUEST     = 0;  ///TODO-implementation pending
   parameter AV_REGISTERINCOMINGSIGNALS = 0;// Indicate that waitrequest is come from register 
   parameter VHDL_ID                    = 0;// VHDL BFM ID number
   parameter PRINT_HELLO                = 1;  // To enable the printing of __hello message

   localparam MAX_BURST_SIZE          = USE_BURSTCOUNT ? 2**(AV_BURSTCOUNT_W-1) : 1;   
   localparam AV_DATA_W               = AV_SYMBOL_W * AV_NUMSYMBOLS;   
   localparam AV_TRANSACTIONID_W      = 8; 
   
   function int lindex;
      // returns the left index for a vector having a declared width 
      // when width is 0, then the left index is set to 0 rather than -1
      input [31:0] width;
      lindex = (width > 0) ? (width-1) : 0;
   endfunction
   
   // =head1 PINS
   // =head2 Clock Interface   
   input                                            clk;
   input                                            reset;
   // =head2 Avalon Slave Interface
   output                                           avs_waitrequest;
   output                                           avs_readdatavalid;
   output [lindex(AV_SYMBOL_W * AV_NUMSYMBOLS):0]   avs_readdata;
   input                                            avs_write;
   input                                            avs_read;
   input  [lindex(AV_ADDRESS_W):0]                  avs_address;
   input  [lindex(AV_NUMSYMBOLS):0]                 avs_byteenable;
   input  [lindex(AV_BURSTCOUNT_W):0]               avs_burstcount;
   input                                            avs_beginbursttransfer;
   input                                            avs_begintransfer;   
   input  [lindex(AV_SYMBOL_W * AV_NUMSYMBOLS):0]   avs_writedata;
   input                                            avs_arbiterlock;
   input                                            avs_lock;
   input                                            avs_debugaccess;                  

   input  [lindex(AV_TRANSACTIONID_W): 0          ] avs_transactionid;
   output [lindex(AV_READRESPONSE_W): 0           ] avs_readresponse;
   output [lindex(AV_TRANSACTIONID_W): 0          ] avs_readid;
   input                                            avs_writeresponserequest;
   output                                           avs_writeresponsevalid;      
   output [lindex(AV_WRITERESPONSE_W): 0          ] avs_writeresponse;
   output [lindex(AV_TRANSACTIONID_W): 0          ] avs_writeid;
   output [1:0]                                     avs_response;
   
   input                                            avs_clken;
   
   //--------------------------------------------------------------------------
   // Private Data Structures
   // All internal data types are packed. SystemVerilog struct or array 
   // slices can be accessed directly and can be assigned to a logic array 
   // in Verilog or a std_logic_vector in VHDL.
   // Read command transactions expect an associated Response transaction to
   // be pushed in by the test bench. Write transactions do not currently
   // require a response.
   //--------------------------------------------------------------------------

   localparam INT_W = 32;

   // synthesis translate_off
  
   import verbosity_pkg::*;
   import avalon_mm_pkg::*;
   import avalon_utilities_pkg::*;
   
   logic                                            avs_waitrequest        = '1; 
   logic [lindex(AV_SYMBOL_W * AV_NUMSYMBOLS):0]    avs_readdata           = 'x;
   logic                                            avs_readdatavalid      = '0;
   logic [lindex(AV_READRESPONSE_W): 0           ]  avs_readresponse       = 'x;
   logic [lindex(AV_TRANSACTIONID_W): 0          ]  avs_readid             = 'x;
   logic                                            avs_writeresponsevalid = '0; 
   logic [lindex(AV_WRITERESPONSE_W): 0          ]  avs_writeresponse      = 'x;
   logic [lindex(AV_TRANSACTIONID_W): 0          ]  avs_writeid            = 'x;
   logic [1:0]                                      avs_response;
   logic                                            clken_register         = 1'b1;

   typedef logic [lindex(AV_ADDRESS_W):0                                ] AvalonAddress_t;
   typedef logic [lindex(AV_BURSTCOUNT_W):0                             ] AvalonBurstCount_t;
   typedef logic [lindex(AV_TRANSACTIONID_W):0                          ] AvalonTransactionId_t;
   typedef logic [lindex(MAX_BURST_SIZE):0][lindex(AV_NUMSYMBOLS):0     ] AvalonByteEnable_t;
   typedef logic [lindex(MAX_BURST_SIZE):0][lindex(AV_DATA_W):0         ] AvalonData_t;
   typedef logic [lindex(MAX_BURST_SIZE):0][lindex(INT_W):0             ] AvalonIdle_t;
   typedef logic [lindex(MAX_BURST_SIZE):0][lindex(INT_W):0             ] AvalonLatency_t;
   typedef logic [lindex(MAX_BURST_SIZE):0][1:0]                          AvalonBurstResponseStatus_t;

   // command transaction descriptor - access with public API
   typedef struct packed {
                          Request_t               request;     
                          AvalonAddress_t         address;     // start address
                          AvalonBurstCount_t      burst_count; // burst length
                          AvalonData_t            data;        // write data
                          AvalonByteEnable_t      byte_enable; // hot encoded  
                          AvalonIdle_t            idle;        // interspersed
                          int                     burst_cycle;
                          logic                   arbiterlock;
                          logic                   lock;
                          logic                   debugaccess;
                          AvalonTransactionId_t   transaction_id;
                          } SlaveCommand_t;

   // response transaction descriptor - access with public API
   typedef struct packed {
                          Request_t                      request;     
                          AvalonData_t                   data;        // read data
                          AvalonAddress_t                address;     // start addr
                          AvalonBurstCount_t             burst_count; // burst length
                          AvalonLatency_t                response_latency;     // per cycle
                          AvalonBurstResponseStatus_t    response;
                          AvalonTransactionId_t          read_id;
                          AvalonTransactionId_t          write_id;
                          } SlaveResponse_t;

   // issued commands
   typedef struct packed {
                          SlaveCommand_t          command;
                          int                     time_stamp;
                          } IssuedCommand_t;
   
   //--------------------------------------------------------------------------
   // Local Signals
   //--------------------------------------------------------------------------
   string              message = "*unitialized*";   

   event               __signal_wait_cycles_set;
   event               __signal_returned_key;
   event               __signal_required_response_latency_cycle_deducted;

   semaphore           drive_response_semaphore;   
   
   
   bit                 slave_is_full                        = 0;
   bit                 slave_cannot_take_in_more_reads      = 0;
   bit                 slave_cannot_take_in_more_writes     = 0;
   bit                 response_is_valid                    = 0;
   int                 pending_read_counter                 = 0;
   int                 pending_write_counter                = 0;
   int                 required_response_latency_cycle      = 0;
   int                 response_timeout                     = 100;
   int                 consolidate_write_burst_transactions = 1;
   int                 max_response_queue_size              = 256;
   int                 min_response_queue_size              = 2;
   int                 clock_counter                        = 0;
   
   SlaveCommand_t      command_queue[$];
   SlaveResponse_t     response_queue[$];   
   IssuedCommand_t     issued_command_queue[$];
   
   SlaveCommand_t      current_command; 
   SlaveCommand_t      client_command;   
   SlaveResponse_t     client_response;

   AvalonLatency_t     read_wait_time = '0;
   AvalonLatency_t     write_wait_time = '0;
   
   IdleOutputValue_t   idle_output_config       = UNKNOWN;
   IdleOutputValue_t   idle_waitrequest_config  = (AV_REGISTERINCOMINGSIGNALS == 1)? HIGH : LOW;
   bit                 default_waitrequest_idle = (AV_REGISTERINCOMINGSIGNALS == 1)? 1'b1 : 1'b0;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). In this case the application program is the test bench
   // which instantiates and controls and queries state in this BFM component.
   // Test programs must only use these public access methods and events to 
   // communicate with this BFM component. The API and the module pins
   // are the only interfaces in this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------

   event signal_fatal_error; // public
   // This event notifies the test bench that a fatal error has occurred
   // in this module.

   event signal_error_exceed_max_pending_reads; // public
   // This event notifies the test bench of the error condition in which
   // the Slave has more than max_pending_reads pipelined read 
   // commands queued waiting to be processed.

   event signal_error_exceed_max_pending_writes; // public
   // This event notifies the test bench of the error condition in which
   // the Slave has more than max_pending_writes pipelined write 
   // commands queued waiting to be processed.
   
   event signal_command_received; // public
   // This event notifies the test bench that a command has been detected
   // on the Avalon port. 
   // The testbench can respond with a set_interface_wait_time
   // call on receiving this event to dynamically back pressure the driving
   // Avalon master. Alternatively, wait_time which was previously set may
   // be used continuously for a set of transactions.

   event signal_response_issued;  // public
   // This event notifies the test bench that a response has been driven
   // out on the Avalon bus

   event signal_max_response_queue_size; // public
   // This event signals that the pending transaction queue size
   // threshold has been exceeded

   event signal_min_response_queue_size; // public
   // This event signals that the pending transaction queue size
   // is below the minimum threshold
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "24.1";
      return ret_version;            
   endfunction
   
   function automatic void init(); // public
      // Initialize the Avalon Slave Bus Interface.

      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      
      __drive_response_idle();
      __drive_waitrequest_idle();

      command_queue = {};
      response_queue = {};
      issued_command_queue = {};           
   endfunction

   function automatic void set_response_timeout( // public
    int  cycles = 100 
   );
      // Set the number of cycles that may elapse before time out
      response_timeout = cycles;
      $sformat(message, "%m: Response timeout set to %0d cycles", 
               response_timeout);
      print(VERBOSITY_INFO, message);            
   endfunction     
   
   function automatic int get_command_queue_size(); // public
      // Query the command queue to determine number of pending commands
      $sformat(message, "%m: method called");                  
      print(VERBOSITY_DEBUG, message);
      
      return command_queue.size();
   endfunction 

   function automatic int get_response_queue_size(); // public
      // Query the response queue to determine number of response descriptors
      // pending.
      $sformat(message, "%m: method called");                  
      print(VERBOSITY_DEBUG, message);
      
      return response_queue.size();
   endfunction 

   function automatic void set_response_latency(  // public
      bit [31:0]   latency,
      int          index = 0
   );
      // Set the latency of the read and/or write response. The response is
      // driven out at the specified number of cycles after receiving
      // the read or write command.
      
      $sformat(message, "%m: method called arg0 %0d arg1 %0d", latency, index);
      print(VERBOSITY_DEBUG, message);
     
      if (client_response.request == REQ_READ) begin
         if (USE_READ_DATA_VALID == 0) begin
            $sformat(message, 
                     "%m: Slave has fixed read latency. Ignoring this method.");
            print(VERBOSITY_WARNING, message);
         end else if (__check_transaction_index(index)) begin
            client_response.response_latency[index] = latency;
         end
      end else begin
         if (USE_WRITERESPONSE == 1) begin
            if (index == 0)
               client_response.response_latency[index] = latency;
         end else begin
            $sformat(message, "%m: Write response disabled. Ignoring this method.");
            print(VERBOSITY_WARNING, message);
         end
      end
   endfunction 

   function automatic void set_response_burst_size( // public
      bit [AV_BURSTCOUNT_W-1:0] burst_size
   );
      // Set the transaction burst count in the response descriptor.
      $sformat(message, "%m: method called arg0 %0d", burst_size);
      print(VERBOSITY_DEBUG, message);

      if (burst_size > MAX_BURST_SIZE) begin
         $sformat(message, "%m: burst_count %0d > MAX_BURST_SIZE %0d ", 
             burst_size, MAX_BURST_SIZE);
         print(VERBOSITY_FAILURE, message);
      end else begin
         client_response.burst_count = burst_size;
      end
   endfunction 

   function automatic void set_response_data( // public
      bit [AV_DATA_W-1:0] data, 
      int                 index
   );
      // Set the transaction read data in the response descriptor.
      // For burst transactions, the command descriptor holds an array
      // of data, with each element individually set by this method.
      $sformat(message, "%m: method called arg0 %0d arg1 %0d", data, index);
      print(VERBOSITY_DEBUG, message);
               
      if (__check_transaction_index(index))
         client_response.data[index] = data;
   endfunction 

   function automatic void push_response(); // public
      // Push the fully populated response transaction descriptor onto
      // response queue. The BFM will pop response descriptors off the
      // queue as soon as they are available, read them and drive the
      // Avalon interface response plane.
      $sformat(message, "%m: push response");
      print(VERBOSITY_DEBUG, message);

      if (reset) begin
         $sformat(message, "%m: Illegal command while reset asserted"); 
         print(VERBOSITY_ERROR, message);
         ->signal_fatal_error;
      end
      if (USE_WRITERESPONSE || client_response.request == REQ_READ)
         response_queue.push_front(client_response);
   endfunction 

   function automatic void pop_command(); // public
      // Pop the command descriptor from the queue so that it can be
      // queried with the get_command methods by the test bench.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);

      if (reset) begin
         $sformat(message, "%m: Illegal command while reset asserted"); 
         print(VERBOSITY_ERROR, message);
         ->signal_fatal_error;
      end
               
      client_command = command_queue.pop_back();

      case(client_command.request) 
         REQ_READ: $sformat(message, "%m: read addr %0x", 
                            client_command.address);
         REQ_WRITE: $sformat(message,"%m: write addr %0x",
                             client_command.address);
         REQ_IDLE: $sformat(message, "%m: idle transaction");
           default: $sformat(message, "%m: illegal transaction");
      endcase
      print(VERBOSITY_DEBUG, message);
   endfunction

   function automatic Request_t get_command_request(); // public
      // Get the received command descriptor to determine command request type.
      // A command type may be REQ_READ or REQ_WRITE. These type values
      // are defined in the enumerated type called Request_t which is
      // imported with the package named avalon_mm_pkg.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
               
      return client_command.request;
   endfunction 

   function automatic logic [AV_ADDRESS_W-1:0] get_command_address(); // public
      // Query the received command descriptor for the transaction address.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
               
      return client_command.address;      
   endfunction 

   function automatic [AV_BURSTCOUNT_W-1:0] get_command_burst_count();// public
      // Query the received command descriptor for the transaction burst count.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
               
      return client_command.burst_count;      
   endfunction 

   function automatic logic [AV_DATA_W-1:0] get_command_data( // public
      int index
   );
      // Query the received command descriptor for the transaction write data.
      // The burst commands with burst count greater than 1, the index
      // selects the write data cycle.
      $sformat(message, "%m: method called arg0 %0d", index);
      print(VERBOSITY_DEBUG, message);
               
      if (__check_transaction_index(index))
         return client_command.data[index];
      else
         return('x);
   endfunction 

   function automatic logic [AV_NUMSYMBOLS-1:0] get_command_byte_enable(// public
      int index
   );
      // Query the received command descriptor for the transaction byte enable.
      // The burst commands with burst count greater than 1, the index
      // selects the data cycle.
      $sformat(message, "%m: method called arg0 %0d", index);
      print(VERBOSITY_DEBUG, message);
               
      if (__check_transaction_index(index))
         return client_command.byte_enable[index];
      else
         return('x); 
   endfunction 

   function automatic int get_command_burst_cycle();  // public
      // Write burst commands are received and processed by the slave BFM as
      // a sequence of discrete commands. The number of commands corresponds
      // to the burst count. A separate command descriptor is constructed for
      // each write burst cycle, corresponding to a partially completed burst.
      // Write data is incrementally added to each new descriptor in each burst
      // cycle until the command descriptor in final burst cycle contains 
      // the full burst command data array. 
      // The burst cycle field returned by this method tells the test bench
      // which burst cycle was active when this descriptor was constructed.
      // This facility enables the testbench to query partially completed 
      // write burst operations. In other words, the testbench can query 
      // the write data word on each burst cycle as it arrives and begin to 
      // process it immediately rather than waiting until the entire burst
      // has been received. This makes it possible to perform pipelined write 
      // burst processing in the test bench.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
               
      return client_command.burst_cycle;
   endfunction

   function automatic void set_interface_wait_time( // public
       int wait_cycles, 
       int index
   );
      // Specify zero or more wait states to be asserted in each Avalon
      // bus burst cycle by driving waitrequest active.
      // With write burst commands, each write data cycle will be forced
      // to wait the number of cycles corresponding to the cycle index. 
      // With read burst commands, there is only one command cycle
      // corresponding to index 0 which can be forced to wait.
      $sformat(message, "%m: method called arg0 %0d arg1 %0d", wait_cycles, index);
      print(VERBOSITY_DEBUG, message);

      if (USE_WAIT_REQUEST == 0) begin
         $sformat(message, "%m: USE_WAIT_REQUEST is 0 (disabled) \
only fixed wait latencies as defined by the parameters \
AV_READ_WAIT_TIME and AV_WRITE_WAIT_TIME can be used");
         print(VERBOSITY_WARNING, message);
         return;
      end else begin
         if (__check_transaction_index(index)) begin
            if ((AV_REGISTERINCOMINGSIGNALS) == 1 && (wait_cycles == 0)) begin
               $sformat(message, "%m: AV_REGISTERINCOMINGSIGNALS is 1, \
waitrequest will come from register and the wait cycles must be at least 1. \
BFM will reset the wait cycles to 1");
               print(VERBOSITY_WARNING, message);
            end else begin
               read_wait_time[index]  = wait_cycles;
               write_wait_time[index] = wait_cycles;
               
               $sformat(message, "%m: Set wait = %0d with index = %0d", 
                        wait_cycles, index);
               print(VERBOSITY_DEBUG, message);
               ->__signal_wait_cycles_set;
            end
         end 
      end
   endfunction 

   function automatic void set_command_transaction_mode( // public
       int mode
   );
      // By default, write burst commands are consolidated into a single
      // command transaction containing the write data for all burst cycles
      // in that command. This mode is set when the mode argument equals 0.
      // When the mode argument is set to 1, the default is overridden and
      // write burst commands yield one command transaction per burst cycle.

      $sformat(message, "%m: method called arg0 %0d ", mode);
      print(VERBOSITY_DEBUG, message);
      consolidate_write_burst_transactions = (mode == 0) ? 1:0;
   endfunction 

   function automatic logic get_command_arbiterlock(); // public
      // Query the received command descriptor for the transaction arbiterlock.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      return client_command.arbiterlock;      
   endfunction 

   function automatic logic get_command_lock(); // public
      // Query the received command descriptor for the transaction lock.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      return client_command.lock;      
   endfunction 

   function automatic logic get_command_debugaccess(); // public
      // Query the received command descriptor for the transaction debugaccess.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      return client_command.debugaccess;      
   endfunction 

   function automatic void set_max_response_queue_size( // public
      int   size
   );
      // Set the maximum pending response queue size threshold. 
      // The public event signal_max_response_queue_size
      // will fire when the threshold is exceeded.
      max_response_queue_size	= size;
   endfunction 

   function automatic void set_min_response_queue_size( // public
      int   size
   );
      // Set the minimum pending response queue size threshold. 
      // The public event signal_min_response_queue_size
      // will fire when the queue level is below this threshold.
      min_response_queue_size	= size;
   endfunction 

   /// New API methods for 10.1   
     
                              
   function automatic logic [AV_TRANSACTIONID_W-1:0] get_command_transaction_id(); // public
      // Query the received command descriptor for the transaction ID.
      $sformat(message, "%m: This API is no longer supported");
      print(VERBOSITY_DEBUG, message);
      
      return client_command.transaction_id;
   endfunction 

   function automatic logic get_command_write_response_request(); // public
      // Query the received command descriptor for value of the 
      // write_response_request field. If it is one, then the master has 
      // requested a write response.
      $sformat(message, "%m: This API is no longer supported");
      print(VERBOSITY_DEBUG, message);
      
      return USE_WRITERESPONSE;
   endfunction 

   function automatic void set_response_request( // public
      Request_t request
   );
      // Sets the transaction type to read or write in the 
      // response descriptor. The enumeration type defines
      // REQ_READ = 0 and REQ_WRITE = 1.

      client_response.request = request;

      $sformat(message, "%m: method called arg0 %0d", request);
      print(VERBOSITY_DEBUG, message);      
   endfunction 
   
   function automatic void set_read_response_status( // public
      AvalonResponseStatus_t  status,
      int                     index
   );
      // Set the read response status.
      $sformat(message, "%m: method called arg0 %0d", status);
      print(VERBOSITY_DEBUG, message);

      if (client_response.request == REQ_READ) begin
         if (USE_READRESPONSE == 1) begin
            client_response.response[index] = status;
         end else begin
            $sformat(message, "%m: Read response is disabled.");
            print(VERBOSITY_WARNING, message);
         end
      end else begin
         $sformat(message, "%m: Read response set on write response transaction");
         print(VERBOSITY_WARNING, message);
      end
   endfunction 

   function automatic void set_write_response_status( // public
      AvalonResponseStatus_t  status
   );
      // Set the write response status code.
      $sformat(message, "%m: method called arg0 %0d", status);
      print(VERBOSITY_DEBUG, message);

     if (client_response.request == REQ_WRITE) begin
         if (USE_WRITERESPONSE == 1) begin
            client_response.response = status;
         end else begin
            $sformat(message, "%m: Write response is disabled.");
            print(VERBOSITY_WARNING, message);
         end
      end else begin
         $sformat(message, "%m: Write response set on read response transaction");
         print(VERBOSITY_WARNING, message);
      end
   endfunction 

   function automatic void set_read_response_id( // public
      bit [AV_TRANSACTIONID_W-1:0] id
   );
      // Set the transaction ID sent out on the avs_readid pin
      $sformat(message, "%m: This API is no longer supported");
      print(VERBOSITY_DEBUG, message);
      
      client_response.read_id = id;
   endfunction 

   function automatic void set_write_response_id( // public
      bit [AV_TRANSACTIONID_W-1:0] id
   );
      // Set the transaction ID sent out on the avs_writeid pin      
      $sformat(message, "%m: This API is no longer supported");
      print(VERBOSITY_DEBUG, message);
      
      client_response.write_id = id;
   endfunction 
   
   function automatic bit get_slave_bfm_status(); // public
      // Query the availability to accept new transaction.
      // Return 1 when slave BFM is accumulate maximum pending writes
      // and maximum pending reads 
      // Return 0 when slave BFM not yet accumulate maximum pending transactions
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);

      return slave_is_full;
   endfunction

   function automatic bit is_slave_cannot_take_in_more_writes(); // public
      // Query the availability to accept new write transaction.
      // Return 1 when slave BFM is accumulate maximum pending writes
      // Return 0 when slave BFM not yet accumulate maximum pending writes
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);

      return slave_cannot_take_in_more_writes;
   endfunction
   
   function automatic bit is_slave_cannot_take_in_more_reads(); // public
      // Query the availability to accept new read transaction.
      // Return 1 when slave BFM is accumulate maximum pending reads
      // Return 0 when slave BFM not yet accumulate maximum pending reads
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);

      return slave_cannot_take_in_more_reads;
   endfunction
   
   function automatic int get_pending_read_latency_cycle(); // public
      // Query the pending ready latency cycles for current read response.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);

      return get_pending_response_latency_cycle();
   endfunction
   
   function automatic int get_pending_response_latency_cycle(); // public
      // Query the pending ready latency cycles for current response.
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);

      return required_response_latency_cycle;
   endfunction
   
   function automatic logic get_clken();  // public
      // Return the clken status
      $sformat(message, "%m: method called");      
      print(VERBOSITY_DEBUG, message);
      return clken_register;
   endfunction 
   
   function automatic void set_idle_state_output_configuration( // public
      // Set the configuration of output signal value during interface idle
      IdleOutputValue_t idle_config
   );
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      
      idle_output_config = idle_config;
   endfunction
   
   function automatic IdleOutputValue_t get_idle_state_output_configuration(); // public
      // Get the configuration of output signal value during interface idle
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      
      return idle_output_config;
   endfunction
   
   function automatic void set_idle_state_waitrequest_configuration( // public
      // Set the configuration of waitrequest signal value during interface idle
      IdleOutputValue_t idle_config
   );
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      
      if(idle_config == RANDOM || idle_config == UNKNOWN) begin
         $sformat(message,"%m: Idle configuration value RANDOM and UNKNOWN not supported for waitrequest");
         print(VERBOSITY_WARNING, message);
      end else begin
         idle_waitrequest_config = idle_config;
      end
   endfunction
   
   function automatic IdleOutputValue_t get_idle_state_waitrequest_configuration(); // public
      // Get the configuration of waitrequest signal value during interface idle
      $sformat(message, "%m: method called");
      print(VERBOSITY_DEBUG, message);
      
      return idle_waitrequest_config;
   endfunction
   
   function automatic int get_pending_read_transactions(); // public
      // Return numbers of outstanding read transactions 
      return pending_read_counter;
   endfunction
   
   function automatic int get_pending_write_transactions(); // public
      // Return numbers of outstanding write transactions 
      return pending_write_counter;
   endfunction
   
   //=cut      
   //--------------------------------------------------------------------------
   // Private Methods
   // Note that private methods and events are prefixed with '__'
   //--------------------------------------------------------------------------

   function automatic int __check_transaction_index(int index);
      if (index > lindex(MAX_BURST_SIZE)) begin
         $sformat(message,"%m: Cycle index %0d exceeds MAX_BURST_SIZE-1 %0d",
                  index, lindex(MAX_BURST_SIZE));
         print(VERBOSITY_ERROR, message);
         ->signal_fatal_error;
         return 0;
      end else begin
         return 1;
      end
   endfunction
   
   function automatic void __init_descriptors();
      pending_read_counter = 0;
      pending_write_counter = 0;
      slave_is_full = 0;
      response_is_valid = 0;
      client_response = '0;
      client_command = '0;
   endfunction   
   
   function automatic void __init_queues();
      command_queue = {};
      issued_command_queue = {};   
      response_queue = {};
   endfunction        
   
   function automatic void __drive_read_response_idle();
      avs_readdatavalid = '0;
      case (idle_output_config)
         LOW: begin
            avs_readdata = '0;
            avs_readid   = '0;
            if (!avs_writeresponsevalid) begin
              avs_response = '0;
            end
         end
         HIGH: begin
            avs_readdata = '1;
            avs_readid   = '1;
            if (!avs_writeresponsevalid) begin
              avs_response = '1;
            end
         end
         RANDOM: begin
            avs_readdata = $random;
            avs_readid   = $random;
            if (!avs_writeresponsevalid) begin
              avs_response = $random;
            end
         end
         UNKNOWN: begin
            avs_readdata = 'x;
            avs_readid   = 'x;
            if (!avs_writeresponsevalid) begin
              avs_response = 'x;
            end
         end
         default: begin
            avs_readdata = 'x;
            avs_readid   = 'x;
            if (!avs_writeresponsevalid) begin
              avs_response = 'x;
            end
         end
      endcase
   endfunction

   function automatic void __drive_write_response_idle();
      avs_writeresponsevalid = '0;
      case (idle_output_config)
         LOW: begin
            avs_writeid = '0;
         end
         HIGH: begin
            avs_writeid = '1;
         end
         RANDOM: begin
            avs_writeid = $random;
         end
         UNKNOWN: begin
            avs_writeid = 'x;
         end
         default: begin
            avs_writeid = 'x;
         end
      endcase
   endfunction

   function automatic void __drive_response_idle();
      __drive_read_response_idle();
      __drive_write_response_idle();            
   endfunction      
   
   function automatic void __drive_waitrequest_idle();
      if (!reset) begin
         case (idle_waitrequest_config)
            LOW: begin
               avs_waitrequest = 1'b0;
            end
            HIGH: begin
               avs_waitrequest = 1'b1;
            end
            default: begin
               avs_waitrequest = default_waitrequest_idle;
            end
         endcase
      end else begin
         avs_waitrequest = 1'b1;
      end
   endfunction
   
   task automatic __reset();
      __drive_response_idle();
      __init_queues();
      __init_descriptors();
      avs_waitrequest = 1'b1;
      disable fork;
      disable monitor_request;
      disable drive_response;
      drive_response_semaphore = new(1);
   endtask

   function automatic logic [lindex(AV_DATA_W):0] __byte_mask_data(
      logic [lindex(AV_DATA_W):0] data,
      logic [lindex(AV_NUMSYMBOLS):0] byte_enable
    );
      bit [lindex(AV_DATA_W):0]  mask;

      for (int i=0; i < AV_NUMSYMBOLS; i++) begin
         for (int j=0; j < AV_SYMBOL_W; j++) begin
            mask[(i*AV_SYMBOL_W)+j] = byte_enable[i];
         end
      end
      return(data & mask);
   endfunction

   function automatic string __request_str(Request_t request);
      case(request)
         REQ_READ: return "Read";
         REQ_WRITE: return "Write";
         REQ_IDLE: return "Idle";
      endcase 
   endfunction
   
   function automatic void __print_command(string text, 
                                           SlaveCommand_t command);
      string message;

      print_divider(VERBOSITY_DEBUG);                      
      $sformat(message, "%m: %s", text);      
      print(VERBOSITY_DEBUG, message);      
      $sformat(message, "Request:     %s", __request_str(command.request));
      print(VERBOSITY_DEBUG, message);
      $sformat(message, "Address:     %0x", command.address);
      print(VERBOSITY_DEBUG, message);      
      $sformat(message, "Burst Count: %0x", command.burst_count);
      print(VERBOSITY_DEBUG, message);
      for (int i=0; i<command.burst_count; i++) begin
         $sformat(message, "  index: %0d data: %0x enables: %0x idles: %0d", 
                  i, command.data[i], 
                  command.byte_enable[i], command.idle[i]);
         print(VERBOSITY_DEBUG, message);
      end
   endfunction

   function automatic void __print_current_command(string text);
      string message;
      __print_command(text, current_command);
   endfunction

   function automatic void __print_client_command(string text);
      string message;
      __print_command(text, client_command);
   endfunction
   
   function automatic void __print_response(string text, SlaveResponse_t response);
      string message;
      print_divider(VERBOSITY_DEBUG);
      $sformat(message, "%m: %s", text);
      print(VERBOSITY_DEBUG, message);
      $sformat(message, "Request:     %s", __request_str(response.request));
      print(VERBOSITY_DEBUG, message);     
      
      if (response.request == REQ_READ) begin
         print(VERBOSITY_DEBUG, message);
         $sformat(message, "Burst Count: %0x", response.burst_count);
         for (int i=0; i<response.burst_count; i++) begin
            $sformat(message, "  index: %0d data: %0x read latency: %0d",
                     i, response.data[i], response.response_latency[i]);
            print(VERBOSITY_DEBUG, message);
            $sformat(message, "  index: %0d read response status: %0s",i, response.response[i]);
            print(VERBOSITY_DEBUG, message);
         end
      end else begin
         $sformat(message, "  write response latency: %0d", response.response_latency[0]);
         print(VERBOSITY_DEBUG, message);
         $sformat(message, "  write response status: %0s", response.response);
         print(VERBOSITY_DEBUG, message);
      end
      print_divider(VERBOSITY_DEBUG);        
   endfunction
   
   function automatic void __hello();
      // Introduction Message to console      
      $sformat(message, "%m: - Hello from altera_avalon_mm_slave_bfm");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Revision: #1 $");
      print(VERBOSITY_INFO, message);            
      $sformat(message, "%m: -   $Date: 2023/12/11 $");
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   AV_ADDRESS_W             = %0d", 
               AV_ADDRESS_W);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   AV_SYMBOL_W              = %0d", 
               AV_SYMBOL_W);
      print(VERBOSITY_INFO, message);      
      $sformat(message, "%m: -   AV_NUMSYMBOLS            = %0d", 
               AV_NUMSYMBOLS);
      print(VERBOSITY_INFO, message);      
      $sformat(message, "%m: -   AV_BURSTCOUNT_W          = %0d", 
               AV_BURSTCOUNT_W);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   REGISTER_WAITREQUEST     = %0d", 
               REGISTER_WAITREQUEST);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   AV_FIX_READ_LATENCY      = %0d", 
               AV_FIX_READ_LATENCY);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   AV_MAX_PENDING_READS     = %0d", 
               AV_MAX_PENDING_READS);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   AV_MAX_PENDING_WRITES    = %0d", 
               AV_MAX_PENDING_WRITES);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   AV_READ_WAIT_TIME        = %0d", 
               AV_READ_WAIT_TIME);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   AV_WRITE_WAIT_TIME       = %0d", 
               AV_WRITE_WAIT_TIME);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_READ                 = %0d", 
               USE_READ);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_WRITE                = %0d", 
               USE_WRITE);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_ADDRESS              = %0d", 
               USE_ADDRESS);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_BYTE_ENABLE          = %0d", 
               USE_BYTE_ENABLE);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_BURSTCOUNT           = %0d", 
               USE_BURSTCOUNT);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_READ_DATA            = %0d", 
               USE_READ_DATA);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_READ_DATA_VALID      = %0d",
               USE_READ_DATA_VALID);
      print(VERBOSITY_INFO, message);      
      $sformat(message, "%m: -   USE_WRITE_DATA           = %0d", 
               USE_WRITE_DATA);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_BEGIN_TRANSFER       = %0d", 
               USE_BEGIN_TRANSFER);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_BEGIN_BURST_TRANSFER = %0d", 
               USE_BEGIN_BURST_TRANSFER);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_WAIT_REQUEST         = %0d", 
               USE_WAIT_REQUEST);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_ARBITERLOCK          = %0d", 
               USE_ARBITERLOCK);
      $sformat(message, "%m: -   USE_LOCK                 = %0d", 
               USE_LOCK);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_DEBUGACCESS          = %0d", 
               USE_DEBUGACCESS);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_TRANSACTIONID        = %0d", 
               USE_TRANSACTIONID);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_WRITERESPONSE        = %0d", 
               USE_WRITERESPONSE);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_READRESPONSE         = %0d", 
               USE_READRESPONSE);
      print(VERBOSITY_INFO, message);
      $sformat(message, "%m: -   USE_CLKEN                = %0d", 
               USE_CLKEN);
      print(VERBOSITY_INFO, message);      
      print_divider(VERBOSITY_INFO);      
   endfunction
   
   //--------------------------------------------------------------------------
   // Internal Machinery
   //--------------------------------------------------------------------------

   initial begin
      if (PRINT_HELLO)
         __hello();

      drive_response_semaphore = new(1); // drive_responses are forked
      
      if (USE_READ_DATA_VALID == 0 && USE_BURSTCOUNT > 0 && USE_READ == 1) begin
         $sformat(message, 
         "%m: USE_READ_DATA_VALID must be enabled if USE_READ and USE_BURSTCOUNT enabled");
         print(VERBOSITY_ERROR, message);
         ->signal_fatal_error;
      end 
      if (USE_BURSTCOUNT > 0 && 
            (AV_BURSTCOUNT_W < 1 || AV_BURSTCOUNT_W > 11)) begin
         $sformat(message,
             "%m: Illegal AV_BURSTCOUNT_W specified - range must be [1..11]");
         print(VERBOSITY_WARNING, message);
      end

      if (USE_WAIT_REQUEST == 0) begin
         for (int i=0; i<MAX_BURST_SIZE; i++) begin
            read_wait_time[i] =  AV_READ_WAIT_TIME;
            write_wait_time[i] =  AV_WRITE_WAIT_TIME;	    
         end
      end else begin
         if (AV_REGISTERINCOMINGSIGNALS) begin
            for (int i=0; i<MAX_BURST_SIZE; i++) begin
               read_wait_time[i] = 1;
               write_wait_time[i] = 1;
            end
         end
      end
   end

   always @(posedge clk) begin
      if (response_queue.size() > max_response_queue_size) begin       
         ->signal_max_response_queue_size;
      end else if (response_queue.size() < min_response_queue_size) begin
         ->signal_min_response_queue_size;
      end
   end
   
   always @(signal_fatal_error) abort_simulation();            
   
   always @(posedge clk) begin
      if (clk_is_enable())
         clock_counter <= clock_counter + 1;
   end
   
   //--------------------------------------------------------------------------
   // Avalon Bus Monitor
   //--------------------------------------------------------------------------

   always @(posedge clk or posedge reset) begin
      clken_register <= avs_clken;
      if (reset) begin
         __reset();
      end else begin
         if (clk_is_enable())
            #1 monitor_request();  
      end
   end

   // monitor outstanding transactions status
   // Slaves with pipelined transactions have a defined maximum latency.
   // Emit a warning and issue a (public) event which can be monitored
   // by the test bench if the limit is exceeded.

   // Note: We may consider asserting a waitrequest when the queued 
   // up read commands exceed this limit. This is not implemented.
   always@(posedge clk) begin
      if ((pending_read_counter < AV_MAX_PENDING_READS) || AV_MAX_PENDING_READS == 0) begin
         slave_is_full = 0;
         slave_cannot_take_in_more_reads = 0;
      end else begin
         slave_cannot_take_in_more_reads = 1;
         if (pending_read_counter > AV_MAX_PENDING_READS) begin
             $sformat(message, 
             "%m: Pipelined read commands %0d > AV_MAX_PENDING_READS %0d", 
             pending_read_counter, AV_MAX_PENDING_READS);
             print(VERBOSITY_WARNING, message);
             ->signal_error_exceed_max_pending_reads; 
         end
      end
      if (USE_WRITERESPONSE) begin
         if ((pending_write_counter < AV_MAX_PENDING_WRITES) || AV_MAX_PENDING_WRITES == 0) begin
            slave_is_full = 0;
            slave_cannot_take_in_more_writes = 0;
         end else begin
            slave_cannot_take_in_more_writes = 1;
            if (pending_write_counter > AV_MAX_PENDING_WRITES) begin
               $sformat(message, 
               "%m: Pipelined write commands %0d > AV_MAX_PENDING_WRITES %0d", 
               pending_write_counter, AV_MAX_PENDING_WRITES);
               print(VERBOSITY_WARNING, message);
               ->signal_error_exceed_max_pending_writes; 
            end
         end
      end else begin
         slave_cannot_take_in_more_writes = 1;
      end      
      if (slave_cannot_take_in_more_writes && slave_cannot_take_in_more_reads)
         slave_is_full = 1;
   end
   
   bit burst_mode = 0;
   int addr_offset = 0;
   task automatic monitor_request();
      if (avs_read && avs_write) begin
         current_command.address = avs_address;
         $sformat(message, "%m: Error - both write and read active at address: %0d", 
                  current_command.address);
         print(VERBOSITY_FAILURE, message);
         ->signal_fatal_error;
      end else if (avs_write) begin        
         if (USE_BURSTCOUNT && !burst_mode) begin
            current_command = '0;
            addr_offset = 0;
            if (addr_offset == avs_burstcount-1) begin
               burst_mode = 0;
            end else
               burst_mode = 1;
         end else begin 
            if (burst_mode) begin
               addr_offset++;
               if (addr_offset == current_command.burst_count-1)
                  burst_mode = 0;
            end else begin
               current_command = '0;
               burst_mode = 0;
               addr_offset = 0;
            end  
         end
         construct_command(current_command, addr_offset);

         if ((consolidate_write_burst_transactions &&
            (addr_offset == current_command.burst_count-1)) ||
            !consolidate_write_burst_transactions) begin
             
            command_queue.push_front(current_command);
            $sformat(message, "%m: write - addr: %0x", current_command.address);
            print(VERBOSITY_DEBUG, message);

            ->signal_command_received;
            if (USE_WRITERESPONSE) begin
               if (consolidate_write_burst_transactions || 
                  (!consolidate_write_burst_transactions && (addr_offset == current_command.burst_count-1))) begin
                  issued_command_queue.push_front(construct_issued_command(current_command));
               end 
            end
         end
             
         // test program may react to the signal by calling the
         // set_interface_wait_time method
         fork: wait_set_write
            begin
               @(__signal_wait_cycles_set);
            end
            begin
               #1;
            end
         join_any: wait_set_write
         disable wait_set_write;

         repeat(write_wait_time[addr_offset]) begin
            avs_waitrequest = 1'b1;
            @(posedge clk);
            wait_posedge_enabled_clk();
         end
         avs_waitrequest = 1'b0;
         if (addr_offset == 0 && USE_WRITERESPONSE)
            pending_write_counter++;
      end else if (avs_read) begin 
         addr_offset = 0;
         current_command = '0;
         construct_command(current_command, addr_offset);
         command_queue.push_front(current_command);
         issued_command_queue.push_front(construct_issued_command(current_command));
         $sformat(message, "%m: read - addr: %0x", current_command.address);
         print(VERBOSITY_DEBUG, message);
         ->signal_command_received;
          
         // test program may react to the signal by calling the
         // set_interface_wait_time method
         fork: wait_set_read
            begin
               @(__signal_wait_cycles_set);
            end
            begin
               #1;
            end
         join_any: wait_set_read
         disable wait_set_read;

         repeat(read_wait_time[addr_offset]) begin
            avs_waitrequest = 1'b1;
            @(posedge clk);
            wait_posedge_enabled_clk();
         end
         avs_waitrequest = 1'b0;
         pending_read_counter++;
      end else begin
         __drive_waitrequest_idle();
      end
   endtask
   
   task automatic wait_posedge_enabled_clk();
      if (USE_CLKEN) begin
         while (!avs_clken) begin
            @(posedge clk);
         end
      end
   endtask
   
   task automatic wait_negedge_enabled_clk();
      if (USE_CLKEN) begin
         while (!avs_clken) begin
            @(negedge clk);
         end
      end
   endtask
   
   function automatic IssuedCommand_t construct_issued_command(ref SlaveCommand_t command);
      construct_issued_command.time_stamp = clock_counter;
      construct_issued_command.command = command;  // not used for now
      return construct_issued_command;
   endfunction

   task automatic construct_command(ref SlaveCommand_t command,
                                    int offset);
      // according to the Avalon spec, we expect that the master does 
      // not drive writedata and byteenable during read request, but
      // this behaviour may be violated in custom components
      if (avs_read) begin
         command.request = REQ_READ;
         command.byte_enable = avs_byteenable;
      end else if (avs_write) begin
         command.request = REQ_WRITE;
         command.data[offset] = avs_writedata; 
         command.byte_enable[offset] = avs_byteenable; 
      end else begin
         $sformat(message, "%m: Cannot construct unknown command received.");
         print(VERBOSITY_ERROR, message);
      end
      command.arbiterlock = avs_arbiterlock;
      command.lock = avs_lock;
      command.debugaccess = avs_debugaccess;
      command.transaction_id = avs_transactionid;
      if (offset == 0) begin
         if (USE_BURSTCOUNT == 1)
            command.burst_count = avs_burstcount;
         else
            command.burst_count = 1;
         command.address = avs_address;
      end
      command.burst_cycle = offset; 
   endtask
   
   //--------------------------------------------------------------------------
   // Avalon Bus Drivers
   //--------------------------------------------------------------------------
   int response_sequence_counter = 0;
   int last_response_sequence_counter  = 0;
   SlaveResponse_t current_response;
   IssuedCommand_t issued_command;
   always @(negedge clk or posedge reset) begin  
      // slave responses are driven mid cycle
      if (reset) begin
         response_sequence_counter = 0;
         last_response_sequence_counter = 0;
         required_response_latency_cycle = 0;
         __reset();
      end else begin
         if (clk_is_enable()) begin
            if (response_queue.size() > 0 && issued_command_queue.size() > 0) begin
               current_response = response_queue.pop_back();
               issued_command = issued_command_queue.pop_back();
               response_sequence_counter++;
               __print_response("Popped Response Queue", current_response);
               
               // Schedule the response to be driven in a future time slot
               // Do this each clock cycle without blocking on previous responses
               if (((issued_command.command.request == REQ_WRITE) && USE_WRITERESPONSE) || 
                   issued_command.command.request == REQ_READ) begin
                  fork
                     begin
                        drive_response(current_response, 
                                       response_sequence_counter);
                     end
                  join_none
               end
            end 
         end
      end 
   end

   task automatic drive_response(SlaveResponse_t   current_response,
                                 int               response_sequence_counter
   );
      int next_scheduled_response_cycle = 0;
      int temp_required_response_latency = 0;
      response_is_valid = 0;
      wait(__signal_required_response_latency_cycle_deducted.triggered);
      temp_required_response_latency = get_pending_response_latency_cycle();
      
      // do not drive a response while in wait state
      while (avs_waitrequest) begin
         if ((temp_required_response_latency > 0) && (current_response.response_latency[0] > 0)) begin
            current_response.response_latency[0]--;
            temp_required_response_latency--;
         end
         @(negedge clk);
         wait_negedge_enabled_clk();
         wait(__signal_required_response_latency_cycle_deducted.triggered);
      end
      
      if (current_response.request == REQ_READ && USE_READ_DATA_VALID == 0) begin
         repeat (AV_FIX_READ_LATENCY) begin
            @(negedge clk);
            wait_negedge_enabled_clk();
         end
      end
      
      for (int i=0; i<current_response.burst_count; i++) begin
         $sformat(message, "%m: current response %0d - latency = %0d", 
                  response_sequence_counter, current_response.response_latency[i]);
                  print(VERBOSITY_DEBUG, message);
         if (((current_response.request == REQ_WRITE) && (i == 0)) || 
             (current_response.request == REQ_READ))
            next_scheduled_response_cycle = clock_counter + current_response.response_latency[i];

         if (i==0) begin
            // Backward compatibility, zero response latency cycle behave same as one latency cycles 
            if (current_response.response_latency[0] == 0)
               next_scheduled_response_cycle += 1;
            calculate_required_response_latency_cycle(current_response);
         end
         if (USE_READ_DATA_VALID || (current_response.request == REQ_WRITE)) begin
            while (clock_counter < next_scheduled_response_cycle) begin
               @(negedge clk);
               wait_negedge_enabled_clk();
            end
         end
         //  Race condition handling: 
         //  Wait until previous thread finish before driven response for current thread 
         if (drive_response_semaphore.try_get(1) > 0)
            drive_response_semaphore.put(1);
         else
            wait(__signal_returned_key.triggered);
      
         // allow only one thread to drive the bus at a time
         if (current_response.request == REQ_READ ||
            (current_response.request == REQ_WRITE && (i == 0))) begin
            if ((!USE_READ_DATA_VALID || (clock_counter == next_scheduled_response_cycle)) && drive_response_semaphore.try_get(1) > 0) begin
               response_is_valid = 1;
               if (response_sequence_counter >= last_response_sequence_counter) begin
                  last_response_sequence_counter = response_sequence_counter; 
               end else begin
                  $sformat(message, 
                     "%m: Response sequence count %0d < previous", 
                  response_sequence_counter);
                  print(VERBOSITY_ERROR, message);
               end
               
               if (current_response.request == REQ_READ) begin
                  if (USE_READRESPONSE) begin
                     avs_response = current_response.response[i];
                     avs_readid = current_response.read_id;
                     $sformat(message, "%m: Read Response status: %0h",
                              current_response.response[i]);
                     print(VERBOSITY_DEBUG, message);
                  end
            
                  if (USE_READ_DATA_VALID) begin
                     avs_readdatavalid = 1;
                  end
                  avs_readdata = current_response.data[i];
                  __drive_write_response_idle();
               end else begin
                  avs_response = current_response.response[i];
                  avs_writeid = current_response.write_id;
                  avs_writeresponsevalid = 1;
                  $sformat(message, "%m: Write Response status: %0h",
                           current_response.response[i]);
                  __drive_read_response_idle();
               end
 
               if (current_response.request == REQ_READ && (pending_read_counter > 0) &&
                   (i == current_response.burst_count - 1))
                  pending_read_counter--;
               else if (current_response.request == REQ_WRITE && (pending_write_counter > 0)) 
                  pending_write_counter--;
 
               @(negedge clk);
               wait_negedge_enabled_clk();
               -> __signal_returned_key;
               drive_response_semaphore.put(1);
            end else begin 
               $sformat(message, 
                        "%m: Response transaction %0d, cycle %0d - schedule conflict",
                        response_sequence_counter, i);
               print(VERBOSITY_ERROR, message);	       
            end
         end
      end
         
      ->signal_response_issued;
   endtask
   
   always @(negedge clk) begin
      // If no drive_response forked task is driving the bus, we drive bus 
      // to idle state
      // We ensure that this always block is scheduled after any possible
      // blocks which call forked drive_response tasks.
      // That is, driving the response bus to idle has lower priority
      #0;
      if (drive_response_semaphore.try_get(1) > 0) begin
         __drive_response_idle();
         drive_response_semaphore.put(1);
      end     
   end

   
   function void calculate_required_response_latency_cycle(SlaveResponse_t response);
      required_response_latency_cycle = 0;
      if (response.request == REQ_READ) begin
         for (int j = 0; j < response.burst_count; j++) begin
            required_response_latency_cycle += response.response_latency[j];
         end
         required_response_latency_cycle += response.burst_count - 1;
      end else begin
         required_response_latency_cycle += response.response_latency[0];
      end
      if (response.response_latency[0] == 0)
         required_response_latency_cycle++;
   endfunction
   
   // assign value to required_response_latency_cycle in multiple always block
   // use __signal_required_response_latency_cycle_deducted to notify other always block
   // to avoid race condition
   always@(negedge clk or posedge reset) begin
      if (reset) begin
         required_response_latency_cycle = 0;
      end else begin
         if (required_response_latency_cycle > 0)
            required_response_latency_cycle--;
      end
      -> __signal_required_response_latency_cycle_deducted;
   end
   
   function bit clk_is_enable();
      return (!USE_CLKEN || avs_clken == 1);
   endfunction
      
   // synthesis translate_on  
endmodule
   
// =head1 SEE ALSO
// avalon_mm_master_bfm
// =cut



 
