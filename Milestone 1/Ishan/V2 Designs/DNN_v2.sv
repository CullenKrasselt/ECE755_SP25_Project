/*
DNN_v2.sv
This file implements the DNN as required for
the Milestone 1 of ECE 755 course project.
*/

module DNN_v2
    #(
        parameter input_width = 5;
        parameter hidden_width = 12;
        parameter output_width = 17;
     )
    (
        // Universal Signals
        input clk,
        input rst_n,
        // DNN Input Ready
        input in_ready,
        // DNN Neuron Inputs
        input signed [input_width-1:0] x0, x1, x2, x3,
        // DNN Neuron Weights: Static
        input signed [4:0] w04, w05, w06, w07, 
        input signed [4:0] w14, w15, w16, w17, 
        input signed [4:0] w24, w25, w26, w27, 
        input signed [4:0] w34, w35, w36, w37, 
        input signed [4:0] w48, w58, w68, w78,
        input signed [4:0] w49, w59, w69, w79,
        // DNN Output Ready
        output logic out0_ready, out1_ready,
        // DNN Outputs
        output logic signed [output_width-1:0] out0, out1
    );

// Internal Connection resources

// Input Layer Outputs -> Hidden Layer Inputs
logic in_layer_ready;
logic signed [input_width-1:0] in_layer_out0;
logic signed [input_width-1:0] in_layer_out1;
logic signed [input_width-1:0] in_layer_out2;
logic signed [input_width-1:0] in_layer_out3;

// Hidden Layer Outputs -> ReLU Inputs
logic hidden_ready;
logic signed [hidden_width-1:0] hidden_out0;
logic signed [hidden_width-1:0] hidden_out1;
logic signed [hidden_width-1:0] hidden_out2;
logic signed [hidden_width-1:0] hidden_out3;

// ReLU Outputs -> Output Layer Inputs
logic relu_ready;
logic signed [hidden_width-1:0] relu_out0;
logic signed [hidden_width-1:0] relu_out1;
logic signed [hidden_width-1:0] relu_out2;
logic signed [hidden_width-1:0] relu_out3;

// Instantiating the Input Layer
Input_layer_v2 iInput
    #(input_width, input_width)
    (
        // Universal Signals
        .clk(clk),
        .rst_n(rst_n),
        // Input Ready
        .input_ready(in_ready),
        // DNN Inputs
        .in0(x0),   .in1(x1),   .in2(x2),   .in3(x3),
        // Input Layer Outputs
        .out0(in_layer_out0),   .out1(in_layer_out1),
        .out2(in_layer_out2),   .out3(in_layer_out3),
        // Input Layer Output Ready
        .output_ready(in_layer_ready)
    );

// Instantiating the Hidden Layer
Hidden_layer_v2 iHidden
    #(input_width, hidden_width)
    (
        // Universal Signals
        .clk(clk),
        .rst_n(rst_n),
        // Hidden Layer Input Ready
        .input_ready(in_layer_ready),
        // Hidden Layer Weights: Static
        .w04(w04),  .w14(w14),  .w24(w24),  .w34(w34),
        .w05(w05),  .w15(w15),  .w25(w25),  .w35(w35),
        .w06(w06),  .w16(w16),  .w26(w26),  .w36(w36),
        .w07(w07),  .w17(w17),  .w27(w27),  .w37(w37),
        // Hidden Layer Inputs
        .in0(in_layer_out0), .in1(in_layer_out1), 
        .in2(in_layer_out2), .in3(in_layer_out3),
        // Hidden Layer Outputs
        .out0(hidden_out0),     .out1(hidden_out1),
        .out2(hidden_out2),     .out3(hidden_out3),
        // Hidden Layer Output Ready
        .output_ready(hidden_ready)
    );

// Instantiating the ReLU Module
ReLU_v2 iReLU
    #(hidden_width, hidden_width)
    (
        // ReLU Input Ready
        .input_ready(hidden_ready),
        // ReLU Inputs
        .in0(hidden_out0), .in1(hidden_out1),
        .in2(hidden_out2), .in3(hidden_out3),
        // ReLU Outputs
        .out0(relu_out0),    .out1(relu_out1),
        .out2(relu_out2),    .out3(relu_out3),
        // ReLU Output Ready
        .output_ready(relu_ready)
    );

// Instantiating the Output Layer
Output_layer_v2 iOutput
    #(hidden_width, output_width)
    (
        // Universal Signals
        .clk(clk),
        .rst_n(rst_n),
        // Output Layer Input Ready
        .input_ready(relu_ready),
        // Output Layer Weights: Static
        .w48(w48),  .w58(w58),  .w68(w68),  .w78(w78),
        .w49(w49),  .w59(w59),  .w69(w69),  .w79(w79),
        // Output Layer Inputs
        .in0(relu_out0), .in1(relu_out1),
        .in2(relu_out2), .in3(relu_out3),
        // Output Layer Outputs
        .out0(out0),    .out1(out1),
        // Output Layer Output Ready
        .out0_ready(out0_ready),
        .out1_ready(out1_ready)
    );

endmodule