MODULE=gbe_udp

VCC=iverilog
FLAGS=-Wall -Wno-portbind
DEFINES=-DDEBUG
DEFINES+=-DDESPERATE_DEBUG
VSIM=vvp

SRC_DIR=../hdl
TB_DIR=./hdl
GEN_DIR=./gen

SRC=$(SRC_DIR)/$(MODULE).v $(SRC_DIR)/gbe_cpu_attach.v $(SRC_DIR)/gbe_rx.v $(SRC_DIR)/gbe_tx.v $(SRC_DIR)/gbe_arp_cache.v $(SRC_DIR)/gbe_cpu_buffer.v $(SRC_DIR)/gbe_ctrl_fifo.v $(SRC_DIR)/gbe_tx_packet_fifo.v $(SRC_DIR)/gbe_rx_ctrl_fifo.v $(SRC_DIR)/gbe_rx_packet_fifo.v
TB_SRC=$(TB_DIR)/TB_$(MODULE).v ./simhdl/BLK_MEM_GEN_V4_3.v ./simhdl/FIFO_GENERATOR_V7_2.v
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
