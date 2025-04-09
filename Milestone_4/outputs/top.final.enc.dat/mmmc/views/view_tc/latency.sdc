set_clock_latency -source -early -max -rise  -140.665 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -143.084 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -140.665 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -143.084 [get_ports {clk}] -clock clk 
