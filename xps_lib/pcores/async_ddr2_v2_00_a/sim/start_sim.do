# load the libraries
vlib work
vmap work work
vmap unisim               /opt/Xilinx/iselib/unisim             
vmap unisims_ver          /opt/Xilinx/iselib/unisims_ver         
vmap XilinxCoreLib        /opt/Xilinx/iselib/XilinxCoreLib      
vmap XilinxCoreLib_ver    /opt/Xilinx/iselib/XilinxCoreLib_ver  

# compile the design
do load_async_ddr2.do

# DDR2 controller and infrastructure
vlib ddr2_controller_v2_00_a
vlib ddr2_infrastructure_v2_00_a
vmap ddr2_controller_v2_00_a ./ddr2_controller_v2_00_a
vmap ddr2_infrastructure_v2_00_a ./ddr2_infrastructure_v2_00_a

# compile the design and its test bench
vcom -93 sim_bench.vhd

# setup simulation
vsim -L XilinxCoreLib_ver -L unisims_ver -t 1ps work.sim_bench

# setup wave display
do wave.do

# simulate
run 30us
