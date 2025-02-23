/*
ReLU.sv
This module is for the ReLU activation function required for the DNN
in the Milestone 1 for ECE 755 Project.
*/

module ReLU 
    (
        // Universal Inputs
        input clk, 
        input rst_n,
        // Only compute when inputs are ready: connect to 
        // reduction & of all neuron output_ready signals
        input input_ready,
        input signed [11:0] in_0,
        input signed [11:0] in_1,
        input signed [11:0] in_2,
        input signed [11:0] in_3,
        output logic signed [11:0] out_0,
        output logic signed [11:0] out_1,
        output logic out_ready_0,
        output logic out_ready_1
    );

// The ReLU stage also provides another pipe stage
// for the entire DNN implementation. 

// Internal Signals
reg signed [11:0] in_0_ff, in_1_ff, in_2_ff, in_3_ff;

// ReLU will be implemented as a simple check
// for the sign bit will be sufficient. 

always_ff @(posedge clk, negedge rst_n)
    begin : ReLU_Block
        if (~rst_n)
            begin
                out_ready_0 <= 0;
                out_ready_1 <= 0;
                out_0 <= 0;
                out_1 <= 0;
            end
        else if (input_ready)
    end : ReLU_Block

endmodule
