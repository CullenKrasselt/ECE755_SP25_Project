/*
ReLU.sv
This module is for the ReLU activation function required for the DNN
in the Milestone 1 for ECE 755 Project.
*/

module ReLU 
    (
        // Only compute when inputs are ready: connect to 
        // reduction & of all neuron output_ready signals
        input input_ready,
        input signed [11:0] in0,
        input signed [11:0] in1,
        input signed [11:0] in2,
        input signed [11:0] in3,
        output logic signed [11:0] out0,
        output logic signed [11:0] out1,
        output logic signed [11:0] out2,
        output logic signed [11:0] out3,
        output logic output_ready
    );

// Try the sign bit comparision to evaluate this.
assign out0 = (input_ready) ? ((in0 > 0) ? (in0) : (0)) : (0);
assign out1 = (input_ready) ? ((in1 > 0) ? (in1) : (0)) : (0);
assign out2 = (input_ready) ? ((in2 > 0) ? (in2) : (0)) : (0);
assign out3 = (input_ready) ? ((in3 > 0) ? (in3) : (0)) : (0);
assign output_ready = (input_ready); 

endmodule
