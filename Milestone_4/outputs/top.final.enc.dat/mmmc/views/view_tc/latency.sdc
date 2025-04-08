set_clock_latency -source -early -max -rise  -144.91 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -145.79 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -144.91 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -145.79 [get_ports {clk}] -clock clk 
