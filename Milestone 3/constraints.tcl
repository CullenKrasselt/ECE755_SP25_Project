## Clock with frequency of 2000ps = 0.5 GHz
## Trying 1 GHz
# Critical Path: Hidden Adder --> ReLU --> Aggregator
# Need to add FF stage at end of ReLU to alleviate pressure.
# create_clock -name "clk" -period 1000  { clk }
# create_clock -name "clk" -period 575  { clk }

### Notes on Performance Power Area Metrics for Power Gated Design
### Min Period: 575 ps, 6.88 mW, Area: 4071
### Min Energy: 2000ps, 1.88 mW, Area: 2800 

### Removing Power Gate on Neuron
### Min Period: 500 ps, 8.53 mW, Area: 4146
### Min Energy: 2000 ps, 1.788 mW, 2.359 mW, Area: 2750, 2674 (ReLU powre gate removed) 

### Removed all power gating, getting the following apart from Neuron Input Mask:
### Min Energy: 2000 ps, 2.257 mW, Area: 2404, Crit Path: 1164 ps

### Removed all power gating, getting the following:
### Min Energy: 2000 ps, 3.088 mW, Area: 2589, Crit Path: 964 ps 

### 03/19/25: No Power Gating at all.
### Min Latency: 68X ps, Area: 395X, Power: 8.1XX mW
### Finding Knee Point:
### L-2: 690 ps, Area: 3894, Power: 7.941 mW
### L-1: 700 ps, Area: 3855, Power: 7.782 mW
### L0:  750 ps, Area: 3654, Power: 6.987 mW
### L1:  800 ps, Area: 3482, Power: 6.356 mW
### L2:  900 ps, Area: 3044, Power: 5.329 mW
### L3:  955 ps, Area: 2813, Power: 4.859 mW
### L4: 1000 ps, Area: 2799, Power: 4.605 mW
### L5: 1111 ps, Area: 2770, Power: 4.132 mW
### L6: 1250 ps, Area: 2770, Power: 3.672 mW

### 03/19/25: Power Gating at Input Layer Aggregator Only. 
### Functionally Enough to Power gate everything if I am thinking correct.
### Min Latency: 676 ps, Area: 3673, Power: 11.638 mW
### Finding Knee Point:
### L-2: 690 ps, Area: 3983, Power: 6.622 mW
### L-1: 700 ps, Area: 3852, Power: 6.444 mW
### L0:  750 ps, Area: 3639, Power: 5.789 mW
### L1:  800 ps, Area: 3472, Power: 5.309 mW
### L2:  900 ps, Area: 3030, Power: 4.488 mW
### L3:  955 ps, Area: 2829, Power: 4.112 mW
### L4: 1000 ps, Area: 2816, Power: 3.913 mW
### L5: 1111 ps, Area: 2787, Power: 3.487 mW
### L6: 1250 ps, Area: 2787, Power: 3.099 mW

create_clock -name "clk" -period 690 { clk }
set_dont_touch_network [find port clk]

## Pointer to all inputs except clk_i
set prim_inputs [remove_from_collection [all_inputs] [find port clk]]
## Pointer to all inputs except clk_i and rst_n
## set prim_inputs_no_rst [remove_from_collection $prim_inputs [find port rst_ni]]
## Set clk_i uncertainty (skew)
set_clock_uncertainty 0.01 clk
set_clock_transition 32 clk

## Set input delay & drive on all inputs
set_input_delay -clock clk 0.1 [copy_collection $prim_inputs]
## rst_n goes to many places so don't touch
#set_dont_touch_network [find port rst_ni]

## Setting Reset to be very strongly driven. 
set_drive 000.1 rst_n

## Set output delay & load on all outputs
set_output_delay -clock clk 0.100 [all_outputs]
set_load 0.010 [all_outputs]

## Wire load model allows it to estimate internal parasitics 
#set_wire_load_model -name TSMC32K_Lowk_Conservative -library tcbn45gsbwptc
set_wire_load_mode "segmented" 

## Max transition time is important for Hot-E reasons 
#set_max_transition 0.1 [current_design]

set_max_fanout 128 top

## set_host_options -max_cores 8
