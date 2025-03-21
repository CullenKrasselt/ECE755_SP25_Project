/*
ReLU_v2.sv
This module is for the ReLU activation function required for the DNN
in the Milestone 1 for ECE 755 Project.
*/

module ReLU_v2 
    #(
        parameter input_width  = 12,
        parameter output_width = 12
     )
    (
        // Universal Inputs
        input clk,
        input rst_n,
        // Input Ready Signal
        input input_ready,
        
        // Only compute when inputs are ready: connect to 
        // reduction & of all neuron output_ready signals
        input signed [input_width-1:0] in0,
        input signed [input_width-1:0] in1,
        input signed [input_width-1:0] in2,
        input signed [input_width-1:0] in3,
        output logic signed [output_width-1:0] out0,
        output logic signed [output_width-1:0] out1,
        output logic signed [output_width-1:0] out2,
        output logic signed [output_width-1:0] out3,
        output logic output_ready
    );

// Try the sign bit comparision to evaluate this. No Need, Synth Tool reduces it for me.
// assign out0 = (input_ready) ? ((in0 > 0) ? (in0) : (0)) : (0);
// assign out1 = (input_ready) ? ((in1 > 0) ? (in1) : (0)) : (0);
// assign out2 = (input_ready) ? ((in2 > 0) ? (in2) : (0)) : (0);
// assign out3 = (input_ready) ? ((in3 > 0) ? (in3) : (0)) : (0);
// assign output_ready = (input_ready); 

// logic [input_width-1:0] t0, t1, t2, t3;

// assign t0 = in0 & {input_width{input_ready}};
// assign t1 = in1 & {input_width{input_ready}};
// assign t2 = in2 & {input_width{input_ready}};
// assign t3 = in3 & {input_width{input_ready}};


always_ff @(posedge clk, negedge rst_n)
begin
    if (~rst_n)
        {out0, out1, out2, out3, output_ready} <= '0;
    else // if (input_ready)
        begin
            // Output Ready Signal
            output_ready <= (input_ready);

            // // ReLU Operation
            // out0 <= (input_ready) ? ((in0 > 0) ? (in0) : (0)) : (0);
            // out1 <= (input_ready) ? ((in1 > 0) ? (in1) : (0)) : (0);
            // out2 <= (input_ready) ? ((in2 > 0) ? (in2) : (0)) : (0);
            // out3 <= (input_ready) ? ((in3 > 0) ? (in3) : (0)) : (0);

            // ReLU Operation
            out0 <= ((in0 > 0) ? (in0) : (0));
            out1 <= ((in1 > 0) ? (in1) : (0));
            out2 <= ((in2 > 0) ? (in2) : (0));
            out3 <= ((in3 > 0) ? (in3) : (0));

            // // ReLU Operation
            // out0 <= ((t0 > 0) ? (t0) : (0));
            // out1 <= ((t1 > 0) ? (t1) : (0));
            // out2 <= ((t2 > 0) ? (t2) : (0));
            // out3 <= ((t3 > 0) ? (t3) : (0));

            // // ReLU Operation
            // out0 <= ((in0 & {input_width{(~in0[input_width-1])}}));
            // out1 <= ((in1 & {input_width{(~in1[input_width-1])}}));
            // out2 <= ((in2 & {input_width{(~in2[input_width-1])}}));
            // out3 <= ((in3 & {input_width{(~in3[input_width-1])}}));
        end
end

// assign output_ready = (input_ready); 

endmodule
