/*
Neuron_17bit.sv
This module implements the output neurons required
for the DNN in the Milestone 1 for ECE 755 Project.
*/

module Neuron_17bit
    (
        // Universal Inputs
        input clk, 
        input rst_n,
        // Input Ready
        input input_ready,
        // Input & Weight Pairs
        input signed [11:0] in0,
        input signed [4:0] w0,

        input signed [11:0] in1,
        input signed [4:0] w1,
        
        input signed [11:0] in2,
        input signed [4:0] w2,
        
        input signed [11:0] in3,
        input signed [4:0] w3,
        // Output Signals
        output logic result_ready,
        output logic signed [16:0] result
    );

// Internal Variables

// Multiply Phase
logic signed [14:0] r0, r1, r2, r3;

// Accumulate Pipe
logic input_ready_ff;
reg signed [14:0] r0_ff, r1_ff, r2_ff, r3_ff;

//Step 1: Multiply all the Input & Weight Pairs
always_comb 
begin : Multiplier
    if (input_ready)
        begin
            r0 = in0 * w0;
            r1 = in1 * w1;
            r2 = in2 * w2;
            r3 = in3 * w3;
        end
    else
        begin
            r0 = 0;
            r1 = 0;
            r2 = 0;
            r3 = 0;
        end
end : Multiplier

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

// Step 2: Accumulate all the Multiplication Pairs
always_comb
    begin : Accumulate 
        if (input_ready_ff)
            begin
                result_ready    = 1;
                result          = (r0_ff + r1_ff + r2_ff + r3_ff);
            end
        else
            begin
                result_ready    = 0;
                result          = 0;
            end
    end : Accumulate

endmodule
