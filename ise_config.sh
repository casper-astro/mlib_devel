export XILINX_PATH=/opt/Xilinx/14.7/ISE_DS
export USE_VIVADO_RUNTIME_FOR_MATLAB=0
export MATLAB_PATH=/opt/Matlab/R2015b
export MLIB_DEVEL_PATH=~/work/git_work/ska_sa/projects/mlib_devel
export PLATFORM=lin64

export SYSGEN_SCRIPT=$MLIB_DEVEL_PATH/startsg_ise
export MATLAB=$MATLAB_PATH
export CASPER_BASE_PATH=$MLIB_DEVEL_PATH
export HDL_ROOT=$CASPER_BASE_PATH/jasper_library/hdl_sources
export XPS_BASE_PATH=$MLIB_DEVEL_PATH/xps_base
source $XILINX_PATH/settings64.sh
