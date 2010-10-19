#!/bin/bash

MODE=0    #0=stable libraries, 1=development libraries

while getopts "hd" flag
do
    #echo "$flag" $OPTIND $OPTARG
    case "$flag" in
        h) echo '-h : print this help text
-d : start simulink using the development libraries'
           exit;;
        d) MODE=1;;
    esac
done

cd /designs/casper_git/simulink_scripts/sandbox

if [ "$MODE" = "0" ]; then
    export MLIB_MODE=0
else
    export MLIB_MODE=1
fi
export MATLAB=/tools/matlab2009b
export XILINX=/tools/Xilinx/11.1/ISE
export XILINX_EDK=/tools/Xilinx/11.1/EDK
export PLATFORM=lin64
export XILINX_DSP=/tools/Xilinx/11.1/DSP_Tools/${PLATFORM}

if [ "$(hostname)" = "phaezar" ]; then
    if [ "$MODE" = "0" ]; then
        echo "$(hostname):Starting Simulink with stable libraries..."
        export BEE2_XPS_LIB_PATH=/designs/casper_git/mlib_devel/xps_lib
        export MLIB_ROOT=/designs/casper_git/mlib_devel
    else
        echo "$(hostname):Starting Simulink with development libraries..."
        export BEE2_XPS_LIB_PATH=/designs/casper_git/sandbox/mlib_devel/xps_lib
        export MLIB_ROOT=/designs/casper_git/sandbox/mlib_devel
    fi
elif [ "$(hostname)" = "maezar" ]; then
    if [ "$MODE" = "0" ]; then
        echo "$(hostname):Starting Simulink with stable libraries..."
        export BEE2_XPS_LIB_PATH=/designs/casper_git/mlib_devel/xps_lib
        export MLIB_ROOT=/designs/casper_git/mlib_devel
    else
        echo "$(hostname):Starting Simulink with development libraries..."
        export BEE2_XPS_LIB_PATH=/designs/casper_git/ox_devel/mlib_devel/xps_lib
        export MLIB_ROOT=/designs/casper_git/ox_devel/mlib_devel
    fi
fi

export PATH=${XILINX}/bin/${PLATFORM}:${XILINX_EDK}/bin/${PLATFORM}:${PATH}
export LD_LIBRARY_PATH=${XILINX}/bin/${PLATFORM}:${XILINX}/lib/${PLATFORM}:${XILINX_DSP}/sysgen/lib:${LD_LIBRARY_PATH}
export LMC_HOME=${XILINX}/smartmodel/${PLATFORM}/installed_lin
export PATH=${LMC_HOME}/bin:${XILINX_DSP}/common/bin:${PATH}
export INSTALLMLLOC=/tools/matlab2009b/bin/matlab
export TEMP=/tmp/
export TMP=/tmp/

export XILINXD_LICENSE_FILE=2100@192.168.126.11
$MATLAB/bin/matlab

