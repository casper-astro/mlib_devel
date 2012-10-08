MODULE=ten_gig_eth
SRCDIR=../hdl
TBDIR=./hdl
GENDIR=./gen
VCC=iverilog
FLAGS=-Wall
DEFINES=-DIVERILOG
DEFINES+=-DSIMULATION
DEFINES+=-DDEBUG
DEFINES+=-DDESPERATE_DEBUG
DEFINES+=-DIVERILOG_060807DEV_WORKAROUND
VSIM=vvp
TB_OBJ=$(GENDIR)/TB_$(MODULE).o
TB_SRC=$(TBDIR)/TB_$(MODULE).v
MSG_FILE=$(GENDIR)/msgs.txt

sim: $(MSG_FILE)

$(MSG_FILE): $(TB_OBJ) 
	$(VSIM) $(TB_OBJ) > $@
	@!(cat $@ | grep FAILED && rm -rf $^)
	@(cat $@ | grep PASSED)

#$(TB_OBJ): $(TB_SRC) $(SRC)
$(TB_OBJ): $(TB_SRC)
	$(VCC) $(INCLUDE) $(FLAGS) $(DEFINES) -o $@ $^

clean:
	rm -Rf ./$(GENDIR)/*
