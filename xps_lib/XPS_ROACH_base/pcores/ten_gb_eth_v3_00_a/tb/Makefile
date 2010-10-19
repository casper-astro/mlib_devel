MODULE=ten_gig_eth

VLIB=vlib
VLC=vlog
VHC=vcom
VSIM=vsim

INCLUDE_DIR=./include
SRC_DIR=../hdl/vhdl
TB_DIR=./hdl
GEN_DIR=./gen
MS_LIB=$(GEN_DIR)/modelsim_lib

MS_INT_FILE = $(MS_LIB)/int_file
VLC_LOG_FILE=$(GEN_DIR)/vlc_msgs.txt
VHC_LOG_FILE=$(GEN_DIR)/vhc_msgs.txt
TOPLEVEL=TB_$(MODULE)
VLSRC=$(TB_DIR)/TB_$(MODULE).v $(TB_DIR)/CRC64.v
VHSRC=$(SRC_DIR)/ten_gig_eth_mac_UCB.vhd
INCLUDE=+incdir+$(INCLUDE_DIR)
INCLUDE+=+incdir+$(SRC_DIR)
DEFINES=+define+MODELSIM
DEFINES+=+define+DEBUG
DEFINES+=+define+SIMULATION


SIM_LOG_FILE=$(GEN_DIR)/msgs.txt
VSIM_SCRIPT=$(GEN_DIR)/vsim_script
VSIM_SCRIPT_COMMANDS="vsim $(TOPLEVEL);\
		      run -all;\
                      exit"
VSIM_FLAGS=-c -l $(SIM_LOG_FILE) -lib $(MS_LIB) -do $(VSIM_SCRIPT)

sim: $(SIM_LOG_FILE)

$(SIM_LOG_FILE): $(MS_INT_FILE) $(VSIM_SCRIPT)
	rm -rf $(SIM_LOG_FILE)
	$(VSIM) $(VSIM_FLAGS) > /dev/null 
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

$(VSIM_SCRIPT): $(MS_INT_FILE)
	echo $(VSIM_SCRIPT_COMMANDS)|sed -e 's/ *; */\n/g' > $@

$(MS_INT_FILE): $(MS_LIB) $(VLSRC) $(VHSRC)
	$(VLC) $(INCLUDE) $(DEFINES) -work $< $(VLSRC) > $(VLC_LOG_FILE)
	$(VHC) -work $< $(VHSRC) > $(VHC_LOG_FILE)
	@touch $@

$(MS_LIB): 
	$(VLIB) $@

clean:
	rm -Rf *.vcd .*.swp .*.*.swp  $(SIM_LOG_FILE) $(MS_LIB) $(VSIM_SCRIPT) work transcript $(MS_INT_FILE) $(GEN_DIR)/*
