MODULE=x64_adc

VCC=iverilog
FLAGS=-Wall
#FLAGS=-Wimplicit
DEFINES=-DSIMULATION
DEFINES+=-DDEBUG
#DEFINES+=-DDESPERATE_DEBUG
VSIM=vvp

SRC_DIR=../hdl/verilog
TB_DIR=./hdl
MODEL_DIR=./simhdl
GEN_DIR=./gen

INCLUDE=-I$(SRC_DIR)

SRC=$(SRC_DIR)/$(MODULE).v $(SRC_DIR)/x64_adc_fcsample.v  $(SRC_DIR)/x64_adc_infrastructure.v  $(SRC_DIR)/x64_adc_serialise.v

TB_SRC=$(TB_DIR)/TB_$(MODULE).v $(MODEL_DIR)/BUFG.v  $(MODEL_DIR)/DCM.v  $(MODEL_DIR)/IBUFDS.v  $(MODEL_DIR)/IDDR.v  $(MODEL_DIR)/IODELAY.v
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
	rm -rf $(TB_OBJ) $(OBJ) $(MSG_FILE) dump.vcd
