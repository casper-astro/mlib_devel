MODULE=async_dram

VCC=iverilog
FLAGS=-Wall
DEFINES=-DDEBUG
DEFINES+=-DDESPERATE_DEBUG
VSIM=vvp

LIB_DIR=/cygdrive/c/Xilinx/10.1/ISE/verilog/src/XilinxCoreLib
SRC_DIR=../hdl/verilog
TB_DIR=./hdl
LOG_DIR=./gen

INCLUDE=-I$(SRC_DIR) -I$(TB_DIR) -I$(LIB_DIR)

DEEP_FIFO_DEFINES=-DBRAM_FIFOS=1
SHALLOW_FIFO_DEFINES=-DBRAM_FIFOS=0
WIDE_DATA_DEFINES=-DC_WIDE_DATA=1
NO_WIDE_DATA_DEFINES=-DC_WIDE_DATA=0
TAG_BUFFER_DEFINES=-DTAG_BUFFER_EN=1
NO_TAG_BUFFER_DEFINES=-DTAG_BUFFER_EN=0
HALF_BURST_DEFINES=-DC_HALF_BURST=1
NO_HALF_BURST_DEFINES=-DC_HALF_BURST=0

FIFOS=$(SRC_DIR)/rd_fifo_bram.v $(SRC_DIR)/rd_fifo_dist.v $(SRC_DIR)/transaction_fifo_bram.v $(SRC_DIR)/transaction_fifo_bram.v $(SRC_DIR)/transaction_fifo_dist.v $(SRC_DIR)/data_fifo_bram.v $(SRC_DIR)/data_fifo_dist.v
SRC=$(SRC_DIR)/$(MODULE).v 
TB_SRC=$(TB_DIR)/TB_$(MODULE).v $(TB_DIR)/dram_controller.v $(FIFOS)
LIB_SRC=$(LIB_DIR)/FIFO_GENERATOR_V4_3.v 

MSG_FILES=$(LOG_DIR)/nowidedata_shallow_fullburst_notag.txt $(LOG_DIR)/widedata_shallow_fullburst_notag.txt $(LOG_DIR)/nowidedata_deep_fullburst_notag.txt $(LOG_DIR)/widedata_deep_fullburst_notag.txt

$(LOG_DIR)/nowidedata_shallow_fullburst_notag.txt: $(TB_DIR)/nowidedata_shallow_fullburst_notag.o
	$(VSIM) $^ > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

$(LOG_DIR)/nowidedata_deep_fullburst_notag.txt: $(TB_DIR)/nowidedata_deep_fullburst_notag.o
	$(VSIM) $^ > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

$(LOG_DIR)/widedata_deep_fullburst_notag.txt: $(TB_DIR)/widedata_deep_fullburst_notag.o
	$(VSIM) $^ > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

$(LOG_DIR)/widedata_shallow_fullburst_notag.txt: $(TB_DIR)/widedata_shallow_fullburst_notag.o 
	$(VSIM) $^ > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

OBJS=$(TB_DIR)/widedata_deep_fullburst_notag.o $(TB_DIR)/nowidedata_deep_fullburst_notag.o $(TB_DIR)/widedata_shallow_fullburst_notag.o $(TB_DIR)/nowidedata_shallow_fullburst_notag.o

$(TB_DIR)/widedata_deep_fullburst_notag.o: $(SRC) $(TB_SRC) $(LIB_SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) $(WIDE_DATA_DEFINES) $(DEEP_FIFO_DEFINES) $(NO_HALF_BURST_DEFINES) $(NO_TAG_BUFFER_DEFINES) -o $@ $^

$(TB_DIR)/nowidedata_deep_fullburst_notag.o: $(SRC) $(TB_SRC) $(LIB_SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) $(NO_WIDE_DATA_DEFINES) $(DEEP_FIFO_DEFINES) $(NO_HALF_BURST_DEFINES) $(NO_TAG_BUFFER_DEFINES) -o $@ $^

$(TB_DIR)/widedata_shallow_fullburst_notag.o: $(SRC) $(TB_SRC) $(LIB_SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) $(WIDE_DATA_DEFINES) $(SHALLOW_FIFO_DEFINES) $(NO_HALF_BURST_DEFINES) $(NO_TAG_BUFFER_DEFINES) -o $@ $^

$(TB_DIR)/nowidedata_shallow_fullburst_notag.o: $(SRC) $(TB_SRC) $(LIB_SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) $(NO_WIDE_DATA_DEFINES) $(SHALLOW_FIFO_DEFINES) $(NO_HALF_BURST_DEFINES) $(NO_TAG_BUFFER_DEFINES) -o $@ $^

sim: $(MSG_FILES)

clean:
	rm -rf $(OBJS) $(OBJ) $(MSG_FILES)

