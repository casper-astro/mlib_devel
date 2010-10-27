BEGIN multiport_ddr2

## Peripheral options
OPTION IPTYPE        = PERIPHERAL
OPTION IMP_NETLIST   = TRUE
OPTION HDL           = VERILOG
OPTION CORE_STATE    = ACTIVE

## Bus interfaces
!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
BUS_INTERFACE BUS    = MEM_CMD_IN${i},     BUS_STD = MEM_CMD,   BUS_TYPE = TARGET
!TCL! }
BUS_INTERFACE BUS    = MEM_CMD_OUT,     BUS_STD = MEM_CMD,   BUS_TYPE = INITIATOR

## Parameters
PARAMETER C_WIDE_DATA    = 0, DT = INTEGER, RANGE = (0:1)
PARAMETER C_HALF_BURST   = 1, DT = INTEGER, RANGE = (0:1)
PARAMETER C_BURST_WINDOW = 0, DT = INTEGER
PARAMETER C_BWIND_WIDTH  = 0, DT = INTEGER

## Ports
# System ports
PORT Clk             = "",              DIR = I
PORT Rst             = "",              DIR = I

!TCL! for {set i 0} {$i < $NUM_PORTS} {incr i} {
# Memory interface in ${i} (non-shared)
PORT In${i}_Cmd_Address = Mem_Cmd_Address, DIR = I, BUS = MEM_CMD_IN${i},  VEC = [31:0]
PORT In${i}_Cmd_RNW     = Mem_Cmd_RNW,     DIR = I, BUS = MEM_CMD_IN${i}   
PORT In${i}_Cmd_Valid   = Mem_Cmd_Valid,   DIR = I, BUS = MEM_CMD_IN${i}   
PORT In${i}_Cmd_Tag     = Mem_Cmd_Tag,     DIR = I, BUS = MEM_CMD_IN${i},  VEC = [31:0]
PORT In${i}_Cmd_Ack     = Mem_Cmd_Ack,     DIR = O, BUS = MEM_CMD_IN${i}
PORT In${i}_Rd_Dout     = Mem_Rd_Dout,     DIR = O, BUS = MEM_CMD_IN${i},  VEC = [(144*(C_WIDE_DATA+1))-1:0]
PORT In${i}_Rd_Tag      = Mem_Rd_Tag,      DIR = O, BUS = MEM_CMD_IN${i},  VEC = [31:0]
PORT In${i}_Rd_Ack      = Mem_Rd_Ack,      DIR = I, BUS = MEM_CMD_IN${i}   
PORT In${i}_Rd_Valid    = Mem_Rd_Valid,    DIR = O, BUS = MEM_CMD_IN${i}   
PORT In${i}_Wr_Din      = Mem_Wr_Din,      DIR = I, BUS = MEM_CMD_IN${i},  VEC = [(144*(C_WIDE_DATA+1))-1:0]
PORT In${i}_Wr_BE       = Mem_Wr_BE,       DIR = I, BUS = MEM_CMD_IN${i},  VEC = [(18*(C_WIDE_DATA+1))-1:0]

!TCL! }

# Memory interface out (shared)
PORT Out_Cmd_Address = Mem_Cmd_Address, DIR = O, BUS = MEM_CMD_OUT,  VEC = [31:0]
PORT Out_Cmd_RNW     = Mem_Cmd_RNW,     DIR = O, BUS = MEM_CMD_OUT   
PORT Out_Cmd_Valid   = Mem_Cmd_Valid,   DIR = O, BUS = MEM_CMD_OUT   
PORT Out_Cmd_Tag     = Mem_Cmd_Tag,     DIR = O, BUS = MEM_CMD_OUT,  VEC = [31:0]
PORT Out_Cmd_Ack     = Mem_Cmd_Ack,     DIR = I, BUS = MEM_CMD_OUT
PORT Out_Rd_Dout     = Mem_Rd_Dout,     DIR = I, BUS = MEM_CMD_OUT,  VEC = [(144*(C_WIDE_DATA+1))-1:0]
PORT Out_Rd_Tag      = Mem_Rd_Tag,      DIR = I, BUS = MEM_CMD_OUT,  VEC = [31:0]
PORT Out_Rd_Ack      = Mem_Rd_Ack,      DIR = O, BUS = MEM_CMD_OUT   
PORT Out_Rd_Valid    = Mem_Rd_Valid,    DIR = I, BUS = MEM_CMD_OUT   
PORT Out_Wr_Din      = Mem_Wr_Din,      DIR = O, BUS = MEM_CMD_OUT,  VEC = [(144*(C_WIDE_DATA+1))-1:0]
PORT Out_Wr_BE       = Mem_Wr_BE,       DIR = O, BUS = MEM_CMD_OUT,  VEC = [(18*(C_WIDE_DATA+1))-1:0]

END
