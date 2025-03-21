/*
Neuron_v2.sv
This module will implement the MAC unit for the required neuron in
the DNN for the Milestone 1 of the ECE 755 Project. 

Use the following widths for DNN:
Hidden Layer: (5,12)
Output Layer: (12, 17)

Use the following widths for the GNN:
Node0: // Recheck the values
    Hidden Layer: (7,14)
    Output Layer: (14,21)
*/

module Neuron_v2
    #(
        parameter input_width = 5,
        parameter output_width = 12
     )
    (
        // Universal Signals
        input clk,
        input rst_n,
        // Input Ready Signal
        input input_ready,
        // Input & Weight Pairs
        input signed [input_width-1:0] in0,
        input signed [4:0] w0,

        input signed [input_width-1:0] in1,
        input signed [4:0] w1,
        
        input signed [input_width-1:0] in2,
        input signed [4:0] w2,
        
        input signed [input_width-1:0] in3,
        input signed [4:0] w3,

        // Output Signals
        output logic result_ready,
        output logic signed [output_width-1:0] result
    );

// Internal Variables

// Multiply Phase
logic signed [output_width-3:0] r0, r1, r2, r3;

// Accumulate Pipe
logic input_ready_ff;
// Look at the bit width here. // Recheck
reg signed [output_width-3:0] r0_ff, r1_ff, r2_ff, r3_ff;

// // Step 1: Multiply all the Input & Weight Pairs
// assign r0 = ((input_ready) ? (in0) : (0)) * (w0);
// assign r1 = ((input_ready) ? (in1) : (0)) * (w1);
// assign r2 = ((input_ready) ? (in2) : (0)) * (w2);
// assign r3 = ((input_ready) ? (in3) : (0)) * (w3);

assign r0 = (in0) * (w0);
assign r1 = (in1) * (w1);
assign r2 = (in2) * (w2);
assign r3 = (in3) * (w3);

// assign r0 = ((in0 & {input_width{input_ready}})) * (w0);
// assign r1 = ((in1 & {input_width{input_ready}})) * (w1);
// assign r2 = ((in2 & {input_width{input_ready}})) * (w2);
// assign r3 = ((in3 & {input_width{input_ready}})) * (w3);

// Pipeline Flop
always_ff @(posedge clk, negedge rst_n)
    begin : Pipeline
        if (~rst_n)
            {input_ready_ff, r0_ff, r1_ff, r2_ff, r3_ff} <= '0; 
        else
            begin
            input_ready_ff <= input_ready;
            {r0_ff, r1_ff, r2_ff, r3_ff} <= {r0, r1, r2, r3}; 
            end
    end : Pipeline

// // Step 2: Accumulate all the Multiplication Pairs
// always_comb
//     begin : Accumulate 
//         if (input_ready_ff)
//                 result          = (r0_ff + r1_ff) + (r2_ff + r3_ff);
//         else
//                 result          = 0;
//     end : Accumulate

// Step 2: Accumulate all the Multiplication Pairs

assign result = (r0_ff + r1_ff) + (r2_ff + r3_ff);
assign result_ready = input_ready_ff;

endmodule
