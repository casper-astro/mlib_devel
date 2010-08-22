##############################################################################
##
## ***************************************************************************
## **                                                                       **
## ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
## **                                                                       **
## ** You may copy and modify these files for your own internal use solely  **
## ** with Xilinx programmable logic devices and Xilinx EDK system or       **
## ** create IP modules solely for Xilinx programmable logic devices and    **
## ** Xilinx EDK system. No rights are granted to distribute any files      **
## ** unless they are distributed in Xilinx programmable logic devices.     **
## **                                                                       **
## ***************************************************************************
##
##############################################################################
## Filename:          C:\bee2\plb_ddr2\bfmsim\bfm_sim_xps.make
## Description:       Custom Makefile for EDK BFM Simulation Only
## Date:              Mon Jul 25 10:57:14 2005 (by Create and Import Peripheral Wizard)
##############################################################################


include bfm_system_incl.make

BRAMINIT_ELF_FILE_ARGS = 

SUBMODULE_OPT = 

BFC_CMD = xilbfc

BFL_SCRIPTS = \
	sample.bfl

BFM_SCRIPTS = \
	scripts/sample.do

DO_SCRIPT = scripts/run.do

############################################################
# EXTERNAL TARGETS
############################################################

bfl: $(BFM_SCRIPTS)

sim: $(BEHAVIORAL_SIM_SCRIPT) $(BFM_SCRIPTS)
	@echo "*********************************************"
	@echo "Start BFM simulation ..."
	@echo "*********************************************"
	cd simulation/behavioral; \
	$(SIM_CMD) -do ../../$(DO_SCRIPT) &

simmodel: $(BEHAVIORAL_SIM_SCRIPT)

clean: simclean
	rm -rf $(BFM_SCRIPTS)

simclean:
	rm -rf simulation/behavioral

############################################################
# BEHAVIORAL SIMULATION GENERATION FLOW
############################################################

$(BEHAVIORAL_SIM_SCRIPT): $(MHSFILE)
	@echo "*********************************************"
	@echo "Create behavioral simulation models ..."
	@echo "*********************************************"
	simgen $(MHSFILE) $(SIMGEN_OPTIONS) -m behavioral
	cat simulation/behavioral/bfm_system.do | sed -e "s/vlog\(.*\)/vlog +define+MODELSIM\1/g" > simulation/behavioral/bfm_system.do.sed
	mv simulation/behavioral/bfm_system.do.sed simulation/behavioral/bfm_system.do


$(BFM_SCRIPTS):
	@echo "*********************************************"
	@echo "Compile bfl script(s) for BFM simulation ..."
	@echo "*********************************************"
	cd scripts; \
	$(BFC_CMD) $(BFL_SCRIPTS)


