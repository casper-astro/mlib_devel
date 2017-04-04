#!/bin/bash

cd implementation

# do some things the makefile would do
cp ../data/system.ucf .

# run smartxplorer
smartxplorer -p xc6vsx475t-1-ff1759 -ucf system.ucf -wd smartxplorer system.ngc -l smartxplorer_hosts.txt -m 12 -bo "off"

# generate a bin file
cd smartxplorer/best_run
bitgen -w -g TdoPin:PULLNONE -g DriveDone:No -g StartUpClk:CCLK -g DONE_cycle:4 -g GTS_cycle:2 -g TckPin:PULLUP -g TdiPin:PULLUP -g TmsPin:PULLUP -g DonePipe:No -g GWE_cycle:6 -g LCK_cycle:NoWait -g Security:NONE -g Persist:No -g binary:Yes system.ncd
cp system.bit ../../
cp system.bin ../../

# return to working dir
cd ../../../

# done
