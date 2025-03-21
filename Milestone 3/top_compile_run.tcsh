#!/bin/tcsh

# source /cae/apps/env/mentor-QuestaSim-2023.2_1

# export PATH=./cae/apps/data/mentor-2023/questasim/bin:${PATH}

# echo "[ Info] Starting Compilation ..."

# \rm -rf ./LibTop modelsim.ini  vsim.wlf transcript wave.do
# echo "[ Info] Creating Library Object ..."

###################################################################################################
## Create QuestaSim design and library
###################################################################################################
# vlib LibTop
# vmap -quiet work $PWD/LibTop
# echo "[ Info] Compiling Netlist and Testbench ..."

###################################################################################################
## Compile Verilog source and testbench
###################################################################################################
## Syntax
## vlog -suppress vlog-2583 -sv +acc -nologo -quiet -work work \
## <list-of-source-files> \
## <list-of-source-files> \
## <list-of-source-files> \

# ./rtl/top.sv ./rtl/mlp.sv ./rtl/neuron4.sv \
vlog -suppress vlog-2583 -sv +acc -nologo -quiet -work ./ASAP_7nm \
    ./outputs/top.vg \
    ./top_tb_v1.sv \
    ./../'Ishan Verilog Designs'/ASAP_7nm_ASIC/asap7sc7p5t_28/Verilog/*.v

###################################################################################################
## Optimize design
###################################################################################################
echo "[ Info] Elaborating Design ..."
# Syntax
# vopt -quiet -suppress vopt-143 -work work -check_synthesis -o <name_of_top_design_>_opt <name_of_top_design>
# vopt -quiet -suppress vopt-143 -work work -check_synthesis -o mlp_opt top 

###################################################################################################
## Run simulation
###################################################################################################
echo "[ Info] Starting Simulation ..."
## Syntax
## vsim $1 -lib ./LibTop <name_of_testbench_module> -t ps -do ./run.do -sv_seed 10
vsim $1 -lib ./ASAP_7nm tb_top_v1 -t ps -do ./run.do -sv_seed 10
