/*
Hidden_layer.sv
This module implements the hidden layer for the DNN
for the Milestone 1 of the ECE 755 Project.
*/

module Hidden_layer
    (
        // Universal Signals
        input clk, 
        input rst_n,
        // Input Ready Signal
        input input_ready,
        // Neuron Weights: Static
        input signed [4:0] w04, w05, w06, w07, 
        input signed [4:0] w14, w15, w16, w17, 
        input signed [4:0] w24, w25, w26, w27, 
        input signed [4:0] w34, w35, w36, w37,
        // Neuron Inputs
        input signed [4:0] in0, in1, in2, in3,
        // Layer Outputs
        output logic signed [11:0] out0, out1, out2, out3,
        // Output Ready Signal
        output logic output_ready
    );

// Internal Signals
logic [3:0] nueron_ready;

// Instantiating the 12 bit Neurons
Neuron_12bit iN4
    (
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(input_ready),
        .in0(in0),
        .w0(w04),
        .in1(in1),
        .w1(w14),
        .in2(in2),
        .w2(w24),
        .in3(in3),
        .w3(w34),
        .result_ready(nueron_ready[0]),
        .result(out0)
    );

Neuron_12bit iN5
    (
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(input_ready),
        .in0(in0),
        .w0(w05),
        .in1(in1),
        .w1(w15),
        .in2(in2),
        .w2(w25),
        .in3(in3),
        .w3(w35),
        .result_ready(nueron_ready[1]),
        .result(out1)
    );

Neuron_12bit iN6
    (
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(input_ready),
        .in0(in0),
        .w0(w06),
        .in1(in1),
        .w1(w16),
        .in2(in2),
        .w2(w26),
        .in3(in3),
        .w3(w36),
        .result_ready(nueron_ready[2]),
        .result(out2)
    );

Neuron_12bit iN7
    (
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(input_ready),
        .in0(in0),
        .w0(w07),
        .in1(in1),
        .w1(w17),
        .in2(in2),
        .w2(w27),
        .in3(in3),
        .w3(w37),
        .result_ready(nueron_ready[3]),
        .result(out3)
    );

assign output_ready = &nueron_ready;

endmodule