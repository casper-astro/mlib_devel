export XILINX_PATH=/opt/Xilinx/Vivado/2016.2
export USE_VIVADO_RUNTIME_FOR_MATLAB=1
export MATLAB_PATH=/opt/Matlab/R2016b
export MLIB_DEVEL_PATH=~/work/git_work/ska_sa/projects/mlib_devel
export PLATFORM=lin64

export SYSGEN_SCRIPT=$MLIB_DEVEL_PATH/startsg
export MATLAB=$MATLAB_PATH
export CASPER_BASE_PATH=$MLIB_DEVEL_PATH
export HDL_ROOT=$CASPER_BASE_PATH/jasper_library/hdl_sources
export XPS_BASE_PATH=$MLIB_DEVEL_PATH/xps_base
source $XILINX_PATH/settings64.sh
