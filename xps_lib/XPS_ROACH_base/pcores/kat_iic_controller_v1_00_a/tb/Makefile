MODULE=kat_iic_controller

VCC=iverilog
FLAGS=-Wall
DEFINES=-DDEBUG 
DEFINES+=-DDESPERATE_DEBUG
VSIM=vvp

SRC_DIR=../hdl/verilog
TB_DIR=./hdl
GEN_DIR=./gen
INCLUDE=-I$(SRC_DIR)

SRC=$(SRC_DIR)/$(MODULE).v $(SRC_DIR)/miic_ops.v $(SRC_DIR)/op_fifo.v $(SRC_DIR)/rx_fifo.v ./simhdl/FIFO_GENERATOR_V4_4.v
TB_SRC=$(TB_DIR)/TB_$(MODULE).v
OBJ=$(GEN_DIR)/$(MODULE).o
TB_OBJ=$(GEN_DIR)/TB_$(MODULE).o

MSG_FILE=$(GEN_DIR)/msgs.txt

sim: $(MSG_FILE)

$(MSG_FILE): $(TB_OBJ)
	$(VSIM) $^ > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

$(TB_OBJ): $(TB_SRC) $(SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) -o $@ $^

clean:
	rm -rf $(TB_OBJ) $(OBJ) $(MSG_FILE)
