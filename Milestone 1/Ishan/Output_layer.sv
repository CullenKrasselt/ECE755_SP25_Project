/*
Output_layer.sv
This module implements the output layer required
for the DNN in the Milestone 1 for ECE 755 Project.
*/

module Output_layer
    (
        //Universal Signals
        input clk,
        input rst_n,
        // Input Ready Signal
        input input_ready,
        // Neuron Weights: Static
        input signed [4:0] w48, w58, w68, w78,
        input signed [4:0] w49, w59, w69, w79,
        // Neuron Inputs
        input signed [11:0] in0, in1, in2, in3,
        // Layer Outputs
        output logic signed [16:0] out0, out1,
        // Output Ready Signals
        output logic out0_ready, out1_ready
    );

// Instantiating the 17 bit Neurons

Neuron_17bit iN8
    (
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(input_ready),
        .in0(in0),
        .w0(w48),
        .in1(in1),
        .w1(w58),
        .in2(in2),
        .w2(w68),
        .in3(in3),
        .w3(w78),
        .result_ready(out0_ready),
        .result(out0)
    );

Neuron_17bit iN9
    (
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(input_ready),
        .in0(in0),
        .w0(w49),
        .in1(in1),
        .w1(w59),
        .in2(in2),
        .w2(w69),
        .in3(in3),
        .w3(w79),
        .result_ready(out1_ready),
        .result(out1)
    );

endmodule