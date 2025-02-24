/*
top.sv
This final top file is for the Milestone 1 for ECE 755 Project.
*/

module top 
    (
        x0, x1, x2, x3,
        w04, w05, w06, w07, 
        w14, w15, w16, w17, 
        w24, w25, w26, w27, 
        w34, w35, w36, w37, 
        w48, w58, w49, w59, 
        w68, w69, w78, w79, 
        out0, out1, 
        in_ready, 
        out0_ready, out1_ready, 
        clk
    );

input [4:0] x0, x1, x2, x3; 
input [4:0] w04, w05, w06, w07; 
input [4:0] w14, w15, w16, w17; 
input [4:0] w24, w25, w26, w27; 
input [4:0] w34, w35, w36, w37; 
input [4:0] w48, w58, w49, w59; 
input [4:0] w68, w69, w78, w79; 

input in_ready; 
input clk; 

output [16:0] out0, out1; 
output out0_ready, out1_ready; 

logic rst_n;
assign rst_n = 1'b1;
// Implementation of the neural network 
// Instantiating the DNN
DNN iDNN (.*);

endmodule