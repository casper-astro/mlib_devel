MODULE=kat_ten_gb_eth

VCC=iverilog
FLAGS=-Wall
#FLAGS=-Wimplicit
DEFINES=-DSIMULATION
DEFINES+=-DDEBUG
#DEFINES+=-DDESPERATE_DEBUG
VSIM=vvp

SRC_DIR=../hdl/verilog
TB_DIR=./hdl
MODEL_DIR=./sim_models
GEN_DIR=./gen

INCLUDE=-I$(SRC_DIR)

SRC=$(SRC_DIR)/$(MODULE).v $(SRC_DIR)/arp_cache.v $(SRC_DIR)/tge_tx.v $(SRC_DIR)/tx_packet_ctrl_fifo.v  $(SRC_DIR)/tx_packet_fifo.v $(SRC_DIR)/ten_gig_eth_mac_ucb.v $(SRC_DIR)/opb_attach.v $(SRC_DIR)/cpu_buffer.v $(SRC_DIR)/tge_rx.v $(SRC_DIR)/rx_packet_fifo_bram.v $(SRC_DIR)/rx_packet_fifo_dist.v $(SRC_DIR)/rx_packet_ctrl_fifo.v $(SRC_DIR)/tx_fifo_ext.v

TB_SRC=$(TB_DIR)/TB_$(MODULE).v $(MODEL_DIR)/BLK_MEM_GEN_V2_8.v $(MODEL_DIR)/FIFO_GENERATOR_V4_4.v $(MODEL_DIR)/CRC64.v
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
