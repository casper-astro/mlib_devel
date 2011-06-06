MODULE=xaui_kat

SRCDIR=../hdl/verilog
TBDIR=./hdl
GENDIR=./gen

TB_OBJ=$(GENDIR)/TB_$(MODULE).o
TB_SRC=$(TBDIR)/TB_$(MODULE).v $(TBDIR)/sim_mgt.v
OBJ=$(GENDIR)/$(MODULE).o
SRC=$(SRCDIR)/$(MODULE).v $(SRCDIR)/pcs_rx.v $(SRCDIR)/fix_term.v $(SRCDIR)/deskew_state.v $(SRCDIR)/pcs_deskew.v $(SRCDIR)/pcs_tx.v $(SRCDIR)/tx_state.v $(SRCDIR)/pcs_sync.v $(SRCDIR)/sync_state.v
MSG_FILE=$(GENDIR)/msgs.txt

VCC=iverilog
INCLUDE=-I $(SRCDIR)
FLAGS=-Wall
DEFINES=-DIVERILOG
DEFINES+=-DSIMULATION
DEFINES+=-DDEBUG
DEFINES+=-DDESPERATE_DEBUG
DEFINES+=-DIVERILOG_060807DEV_WORKAROUND

VSIM=vvp

sim: $(MSG_FILE)

$(MSG_FILE): $(TB_OBJ) 
	$(VSIM) $(TB_OBJ) > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

#$(TB_OBJ): $(TB_SRC) $(SRC)

$(TB_OBJ): $(TB_SRC) $(SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) -o $@ $^

clean:
	rm -Rf ./$(GENDIR)/*
