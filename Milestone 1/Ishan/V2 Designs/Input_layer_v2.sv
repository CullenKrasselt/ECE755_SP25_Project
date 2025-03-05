/*
Input_layer_v2.sv
This module implements the input layer for the DNN
for the Milestone 1 of the ECE 755 Project.

Use the following widths for DNN:
Input Layer: (5,5)

Use the following widths for the GNN:
Node0: // Recheck the values
    Input Layer: (7,7)
*/

module Input_layer_v2
    #(
        parameter input_width  = 5;
        parameter output_width = 5;
     )
    (
        // Universal Inputs
        input clk,
        input rst_n,
        // Input Ready Signal
        input input_ready,
        // Model Inputs
        input signed [input_width-1:0] in0,
        input signed [input_width-1:0] in1,
        input signed [input_width-1:0] in2,
        input signed [input_width-1:0] in3,
        // Module Outputs
        output logic signed [output_width-1:0] out0,
        output logic signed [output_width-1:0] out1,
        output logic signed [output_width-1:0] out2,
        output logic signed [output_width-1:0] out3,
        // Output Ready
        output logic output_ready
    );

always_ff @(posedge clk, negedge rst_n)
    begin
        if (~rst_n)
             {output_ready, out0, out1, out2, out3} <= '0;
        else
            begin
                output_ready <= input_ready;
                if (input_ready)
                    {out0, out1, out2, out3} <= {in0, in1, in2, in3};
                else
                    {out0, out1, out2, out3} <= '0;
            end
    end

endmodule
