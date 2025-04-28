module top 
    #(
        parameter input_width = 5, //agg = 7, DNN_hidden = 14, DNN_out = 19
        parameter output_width = 21
     )

(
    x0_node0, x1_node0, x2_node0, x3_node0, 
    x0_node1, x1_node1, x2_node1, x3_node1, 
    x0_node2, x1_node2, x2_node2, x3_node2, 
    x0_node3, x1_node3, x2_node3, x3_node3, 
    w04, w14, w24, w34, 
    w05, w15, w25, w35, 
    w06, w16, w26, w36, 
    w07, w17, w27, w37, 
    w48, w58, w68, w78, 
    w49, w59, w69, w79, 
    out0_node0, out1_node0, 
    out0_node1, out1_node1, 
    out0_node2, out1_node2, 
    out0_node3, out1_node3, 
    in_ready, 
    out10_ready_node0, out11_ready_node0, 
    out10_ready_node1, out11_ready_node1, 
    out10_ready_node2, out11_ready_node2, 
    out10_ready_node3, out11_ready_node3, 
    clk, rst_n
); 
 
input logic signed[input_width-1:0] x0_node0, x1_node0, x2_node0, x3_node0; 
input logic signed[input_width-1:0] x0_node1, x1_node1, x2_node1, x3_node1; 
input logic signed[input_width-1:0] x0_node2, x1_node2, x2_node2, x3_node2; 
input logic signed[input_width-1:0] x0_node3, x1_node3, x2_node3, x3_node3; 
input logic signed[4:0] w04, w14, w24, w34; 
input logic signed[4:0] w05, w15, w25, w35; 
input logic signed[4:0] w06, w16, w26, w36; 
input logic signed[4:0] w07, w17, w27, w37; 
input logic signed[4:0] w48, w58, w68, w78; 
input logic signed[4:0] w49, w59, w69, w79; 
input clk;
input rst_n;
input in_ready;

output logic signed[output_width-1:0] out0_node0, out1_node0;
output logic signed[output_width-1:0] out0_node1, out1_node1; 
output logic signed[output_width-1:0] out0_node2, out1_node2; 
output logic signed[output_width-1:0] out0_node3, out1_node3; 
output logic out10_ready_node0, out11_ready_node0; 
output logic out10_ready_node1, out11_ready_node1; 
output logic out10_ready_node2, out11_ready_node2; 
output logic out10_ready_node3, out11_ready_node3; 

//Implementation of GNN 

logic[3:0] agg_ready;

// Clock Gated Version
logic gated_clk;
assign gated_clk = in_ready & clk;

//PERFORM AGGREGATION OF INPUTS
//node 0 aggregation
logic signed[input_width+1:0] agg0_x01, agg0_x02, agg0_x03, agg0_x04;
always_ff@(posedge gated_clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg0_x01, agg0_x02, agg0_x03, agg0_x04, agg_ready[0]} <= '0;
    end
    else begin
    agg0_x01 <= ((x0_node0)) + ((x0_node1)) + ((x0_node2));
    agg0_x02 <= ((x1_node0)) + ((x1_node1)) + ((x1_node2));
    agg0_x03 <= ((x2_node0)) + ((x2_node1)) + ((x2_node2));
    agg0_x04 <= ((x3_node0)) + ((x3_node1)) + ((x3_node2));
    agg_ready[0] <= in_ready;
    end
end

//node 1 aggregation
logic signed[input_width+1:0] agg1_x01, agg1_x02, agg1_x03, agg1_x04;
always_ff@(posedge gated_clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg1_x01, agg1_x02, agg1_x03, agg1_x04, agg_ready[1]} <= '0;
    end
    else begin
    agg1_x01 <= ((x0_node0)) + ((x0_node1)) + ((x0_node3));
    agg1_x02 <= ((x1_node0)) + ((x1_node1)) + ((x1_node3));
    agg1_x03 <= ((x2_node0)) + ((x2_node1)) + ((x2_node3));
    agg1_x04 <= ((x3_node0)) + ((x3_node1)) + ((x3_node3));
    agg_ready[1] <= in_ready;

    end
end

//node 2 aggregation
logic signed[input_width+1:0] agg2_x01, agg2_x02, agg2_x03, agg2_x04;
always_ff@(posedge gated_clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg2_x01, agg2_x02, agg2_x03, agg2_x04, agg_ready[2]} <= '0;
    end
    else begin
    agg2_x01 <= ((x0_node0)) + ((x0_node2)) + ((x0_node3));
    agg2_x02 <= ((x1_node0)) + ((x1_node2)) + ((x1_node3));
    agg2_x03 <= ((x2_node0)) + ((x2_node2)) + ((x2_node3));
    agg2_x04 <= ((x3_node0)) + ((x3_node2)) + ((x3_node3));
    agg_ready[2] <= in_ready;
    end
end

//node 3 aggregation
logic signed[input_width+1:0] agg3_x01, agg3_x02, agg3_x03, agg3_x04;
always_ff@(posedge gated_clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg3_x01, agg3_x02, agg3_x03, agg3_x04, agg_ready[3]} <= '0;
    end
    else begin
    agg3_x01 <= ((x0_node1)) + ((x0_node2)) + ((x0_node3));
    agg3_x02 <= ((x1_node1)) + ((x1_node2)) + ((x1_node3));
    agg3_x03 <= ((x2_node1)) + ((x2_node2)) + ((x2_node3));
    agg3_x04 <= ((x3_node1)) + ((x3_node2)) + ((x3_node3));
    agg_ready[3] <= in_ready;
    end
end

//PERFORM HIDDEN LAYER
logic[3:0] hidden_ready;
//node0 hidden
logic signed [input_width+8:0] hidden0_out0, hidden0_out1, hidden0_out2, hidden0_out3;
Hidden_layer_v3 #(input_width+2, input_width+9) n0_hidden(
        .clk(clk), 
        .rst_n(rst_n),
        .input_ready(agg_ready[0]),
        .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
        .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
        .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
        .w34(w34), .w35(w35), .w36(w36), .w37(w37),
	    .in0(agg0_x01), .in1(agg0_x02), .in2(agg0_x03), .in3(agg0_x04),
        .out0(hidden0_out0), .out1(hidden0_out1), .out2(hidden0_out2), .out3(hidden0_out3),
        .output_ready(hidden_ready[0])
);

//node1 hidden
logic signed [input_width+8:0] hidden1_out0, hidden1_out1, hidden1_out2, hidden1_out3;
Hidden_layer_v3 #(input_width+2, input_width+9) n1_hidden(
        .clk(clk), 
        .rst_n(rst_n),
        .input_ready(agg_ready[1]),
        .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
        .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
        .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
        .w34(w34), .w35(w35), .w36(w36), .w37(w37),
	    .in0(agg1_x01), .in1(agg1_x02), .in2(agg1_x03), .in3(agg1_x04),
        .out0(hidden1_out0), .out1(hidden1_out1), .out2(hidden1_out2), .out3(hidden1_out3),
        .output_ready(hidden_ready[1])
);

//node2 hidden
logic signed [input_width+8:0] hidden2_out0, hidden2_out1, hidden2_out2, hidden2_out3;
Hidden_layer_v3 #(input_width+2, input_width+9) n2_hidden(
        .clk(clk), 
        .rst_n(rst_n),
        .input_ready(agg_ready[2]),
        .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
        .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
        .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
        .w34(w34), .w35(w35), .w36(w36), .w37(w37),
	    .in0(agg2_x01), .in1(agg2_x02), .in2(agg2_x03), .in3(agg2_x04),
        .out0(hidden2_out0), .out1(hidden2_out1), .out2(hidden2_out2), .out3(hidden2_out3),
        .output_ready(hidden_ready[2])
);

//node3 hidden
logic signed [input_width+8:0] hidden3_out0, hidden3_out1, hidden3_out2, hidden3_out3;
Hidden_layer_v3 #(input_width+2, input_width+9) n3_hidden(
        .clk(clk), 
        .rst_n(rst_n),
        .input_ready(agg_ready[3]),
        .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
        .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
        .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
        .w34(w34), .w35(w35), .w36(w36), .w37(w37),
	    .in0(agg3_x01), .in1(agg3_x02), .in2(agg3_x03), .in3(agg3_x04),
        .out0(hidden3_out0), .out1(hidden3_out1), .out2(hidden3_out2), .out3(hidden3_out3),
        .output_ready(hidden_ready[3])
);


//PERFORM RELU

logic[3:0] relu_ready;
//node0 ReLU
logic signed [input_width+8:0] relu0_out0, relu0_out1, relu0_out2, relu0_out3;
ReLU_v3 #(input_width+9, input_width+9) n0_ReLU(
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(hidden_ready[0]),
        .in0(hidden0_out0),
        .in1(hidden0_out1),
        .in2(hidden0_out2),
        .in3(hidden0_out3),
        .out0(relu0_out0),
        .out1(relu0_out1),
        .out2(relu0_out2),
        .out3(relu0_out3),
        .output_ready(relu_ready[0])
);
//node1 ReLU
logic signed [input_width+8:0] relu1_out0, relu1_out1, relu1_out2, relu1_out3;
ReLU_v3 #(input_width+9, input_width+9) n1_ReLU(
    .clk(clk),
    .rst_n(rst_n),
    .input_ready(hidden_ready[1]),
    .in0(hidden1_out0),
    .in1(hidden1_out1),
    .in2(hidden1_out2),
    .in3(hidden1_out3),
    .out0(relu1_out0),
    .out1(relu1_out1),
    .out2(relu1_out2),
    .out3(relu1_out3),
    .output_ready(relu_ready[1])
);

//node2 ReLU
logic signed [input_width+8:0] relu2_out0, relu2_out1, relu2_out2, relu2_out3;
ReLU_v3 #(input_width+9, input_width+9) n2_ReLU(
    .clk(clk),
    .rst_n(rst_n),
    .input_ready(hidden_ready[2]),
    .in0(hidden2_out0),
    .in1(hidden2_out1),
    .in2(hidden2_out2),
    .in3(hidden2_out3),
    .out0(relu2_out0),
    .out1(relu2_out1),
    .out2(relu2_out2),
    .out3(relu2_out3),
    .output_ready(relu_ready[2])
);

//node3 ReLU
logic signed [input_width+8:0] relu3_out0, relu3_out1, relu3_out2, relu3_out3;
ReLU_v3 #(input_width+9, input_width+9) n3_ReLU(
    .clk(clk),
    .rst_n(rst_n),
    .input_ready(hidden_ready[3]),
    .in0(hidden3_out0),
    .in1(hidden3_out1),
    .in2(hidden3_out2),
    .in3(hidden3_out3),
    .out0(relu3_out0),
    .out1(relu3_out1),
    .out2(relu3_out2),
    .out3(relu3_out3),
    .output_ready(relu_ready[3])
);

// Adding FF at the end of the ReLU path, by changing the ReLU module itself.

//PERFORM AGGREGATION AFTER RELU
logic[3:0] output_agg_ready;

// assign output_agg_ready = relu_ready;

//node 0 aggregation
logic signed[input_width+10:0] agg0_y01, agg0_y02, agg0_y03, agg0_y04;
always_ff@(posedge gated_clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg0_y01, agg0_y02, agg0_y03, agg0_y04} <= '0;
    end
    else begin
        agg0_y01 <= ((relu0_out0) + (relu1_out0)) + (relu2_out0);
    	agg0_y02 <= ((relu0_out1) + (relu1_out1)) + (relu2_out1);
    	agg0_y03 <= ((relu0_out2) + (relu1_out2)) + (relu2_out2);
    	agg0_y04 <= ((relu0_out3) + (relu1_out3)) + (relu2_out3);
        output_agg_ready[0] <= relu_ready[0];
    end
end

// node 1 Aggregation
logic signed [input_width+10:0] agg1_y01, agg1_y02, agg1_y03, agg1_y04;
always_ff @(posedge gated_clk, negedge rst_n) begin
    if (~rst_n) begin
        {agg1_y01, agg1_y02, agg1_y03, agg1_y04} <= '0;
    end
    else begin
        agg1_y01 <= ((relu0_out0) + (relu1_out0)) + (relu3_out0);
        agg1_y02 <= ((relu0_out1) + (relu1_out1)) + (relu3_out1);
        agg1_y03 <= ((relu0_out2) + (relu1_out2)) + (relu3_out2);
        agg1_y04 <= ((relu0_out3) + (relu1_out3)) + (relu3_out3);
        output_agg_ready[1] <= relu_ready[1];
    end
end

// node 2 Aggregation
logic signed [input_width+10:0] agg2_y01, agg2_y02, agg2_y03, agg2_y04;
always_ff @(posedge gated_clk, negedge rst_n) begin
    if (~rst_n) begin
        {agg2_y01, agg2_y02, agg2_y03, agg2_y04} <= '0;
    end
    else begin
        agg2_y01 <= ((relu0_out0) + (relu2_out0)) + (relu3_out0);
        agg2_y02 <= ((relu0_out1) + (relu2_out1)) + (relu3_out1);
        agg2_y03 <= ((relu0_out2) + (relu2_out2)) + (relu3_out2);
        agg2_y04 <= ((relu0_out3) + (relu2_out3)) + (relu3_out3);
        output_agg_ready[2] <= relu_ready[2];
    end
end

// node 3 Aggregation
logic signed [input_width+10:0] agg3_y01, agg3_y02, agg3_y03, agg3_y04;
always_ff @(posedge gated_clk, negedge rst_n) begin
    if (~rst_n) begin
        {agg3_y01, agg3_y02, agg3_y03, agg3_y04} <= '0;
    end
    else begin
        agg3_y01 <= ((relu1_out0) + (relu2_out0)) + (relu3_out0);
        agg3_y02 <= ((relu1_out1) + (relu2_out1)) + (relu3_out1);
        agg3_y03 <= ((relu1_out2) + (relu2_out2)) + (relu3_out2);
        agg3_y04 <= ((relu1_out3) + (relu2_out3)) + (relu3_out3);
        output_agg_ready[3] <= relu_ready[3];
    end
end

//PERFORM FINAL OUTPUT LAYER

//node0
Output_layer_v3 #(input_width+11, output_width) n0_out(
        .clk(clk),
        .rst_n(rst_n),
        .input_ready(output_agg_ready[0]),
        .w48(w48), .w58(w58), .w68(w68), .w78(w78),
        .w49(w49), .w59(w59), .w69(w69), .w79(w79),
        .in0(agg0_y01), .in1(agg0_y02), .in2(agg0_y03), .in3(agg0_y04),
        .out0(out0_node0), .out1(out1_node0),
        .out0_ready(out10_ready_node0), .out1_ready(out11_ready_node0)
);

//node1
Output_layer_v3 #(input_width+11, output_width) n1_out(
    .clk(clk),
    .rst_n(rst_n),
    .input_ready(output_agg_ready[1]),
    .w48(w48), .w58(w58), .w68(w68), .w78(w78),
    .w49(w49), .w59(w59), .w69(w69), .w79(w79),
    .in0(agg1_y01), .in1(agg1_y02), .in2(agg1_y03), .in3(agg1_y04),
    .out0(out0_node1), .out1(out1_node1),
    .out0_ready(out10_ready_node1), .out1_ready(out11_ready_node1)
);

//node2
Output_layer_v3 #(input_width+11, output_width) n2_out(
    .clk(clk),
    .rst_n(rst_n),
    .input_ready(output_agg_ready[2]),
    .w48(w48), .w58(w58), .w68(w68), .w78(w78),
    .w49(w49), .w59(w59), .w69(w69), .w79(w79),
    .in0(agg2_y01), .in1(agg2_y02), .in2(agg2_y03), .in3(agg2_y04),
    .out0(out0_node2), .out1(out1_node2),
    .out0_ready(out10_ready_node2), .out1_ready(out11_ready_node2)
);

//node3
Output_layer_v3 #(input_width+11, output_width) n3_out(
    .clk(clk),
    .rst_n(rst_n),
    .input_ready(output_agg_ready[3]),
    .w48(w48), .w58(w58), .w68(w68), .w78(w78),
    .w49(w49), .w59(w59), .w69(w69), .w79(w79),
    .in0(agg3_y01), .in1(agg3_y02), .in2(agg3_y03), .in3(agg3_y04),
    .out0(out0_node3), .out1(out1_node3),
    .out0_ready(out10_ready_node3), .out1_ready(out11_ready_node3)
);

endmodule