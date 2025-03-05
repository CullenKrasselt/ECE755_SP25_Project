/*
top_v2.sv
This final top file is for the Milestone 1 for ECE 755 Project.
*/

module top_v2 
    #(
        parameter input_width = 5;
        parameter hidden_width = 12;
        parameter output_width = 17;
     )
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

input [input_width-1:0] x0, x1, x2, x3; 
input [4:0] w04, w05, w06, w07; 
input [4:0] w14, w15, w16, w17; 
input [4:0] w24, w25, w26, w27; 
input [4:0] w34, w35, w36, w37; 
input [4:0] w48, w58, w49, w59; 
input [4:0] w68, w69, w78, w79; 

input in_ready; 
input clk; 

output [output_width-1:0] out0, out1; 
output out0_ready, out1_ready; 

logic rst_n;
assign rst_n = 1'b1;
// Implementation of the neural network 
// Instantiating the DNN
DNN_v2 iDNN #(input_width, hidden_width, output_width) (.*);

endmodule