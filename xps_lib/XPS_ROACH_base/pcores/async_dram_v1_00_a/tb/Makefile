MODULE=async_dram

VCC=iverilog
FLAGS=-Wall
DEFINES=-DDEBUG
DEFINES+=-DDESPERATE_DEBUG
VSIM=vvp

LIB_DIR=/cygdrive/c/Xilinx/10.1/ISE/verilog/src/XilinxCoreLib
SRC_DIR=../hdl/verilog
TB_DIR=./hdl
LOG_FILE=./gen

INCLUDE=-I$(SRC_DIR) -I$(TB_DIR) -I$(LIB_DIR)

SRC=$(SRC_DIR)/$(MODULE).v 
TB_SRC=$(TB_DIR)/TB_$(MODULE).v $(SRC_DIR)/rd_fifo.v $(SRC_DIR)/transaction_fifo.v $(SRC_DIR)/operation_fifo.v $(TB_DIR)/dram_controller.v
LIB_SRC=$(LIB_DIR)/FIFO_GENERATOR_V4_3.v 

TB_OBJ=$(GEN_DIR)/TB_$(MODULE).o 
MSG_FILE=$(LOG_FILE)/msgs.txt

sim: $(MSG_FILE)

$(MSG_FILE): $(TB_OBJ)
	$(VSIM) $^ > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

$(TB_OBJ): $(SRC) $(TB_SRC) $(LIB_SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) -o $@ $^

clean:
	rm -rf $(LIB_OBJ) $(TB_OBJ) $(OBJ) $(MSG_FILE)
