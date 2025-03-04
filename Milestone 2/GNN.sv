module top ( x0_node0, x1_node0, x2_node0, x3_node0, 
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
clk); 
 
input logic signed[4:0] x0_node0, x1_node0, x2_node0, x3_node0; 
input logic signed[4:0] x0_node1, x1_node1, x2_node1, x3_node1; 
input logic signed[4:0] x0_node2, x1_node2, x2_node2, x3_node2; 
input logic signed[4:0] x0_node3, x1_node3, x2_node3, x3_node3; 
input logic signed[4:0] w04, w14, w24, w34; 
input logic signed[4:0] w05, w15, w25, w35; 
input logic signed[4:0] w06, w16, w26, w36; 
input logic signed[4:0] w07, w17, w27, w37; 
input logic signed[4:0] w48, w58, w68, w78; 
input logic signed[4:0] w49, w59, w69, w79; 
input clk; 
input in_ready;

output logic signed[20:0] out0_node0, out1_node0;
output logic signed[20:0] out0_node1, out1_node1; 
output logic signed[20:0] out0_node2, out1_node2; 
output logic signed[20:0] out0_node3, out1_node3; 
output logic out10_ready_node0, out11_ready_node0; 
output logic out10_ready_node1, out11_ready_node1; 
output logic out10_ready_node2, out11_ready_node2; 
output logic out10_ready_node3, out11_ready_node3; 

//Implementation of GNN 
logic rst_n;
assign rst_n = 1'b1;
logic[3:0] agg_ready;

//node 0 aggregation
logic signed[4:0] agg0_x01, agg0_x02, agg0_x03, agg0_x04;
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg0_x01, agg0_x02, agg0_x03, agg0_x04} <= '0;
    end
    else if(in_ready) begin
        {agg0_x01, agg0_x02, agg0_x03, agg0_x04} <= 
            {x0_node0, x1_node0, x2_node0, x3_node0} + 
            {x0_node1, x1_node1, x2_node1, x3_node1} +
            {x0_node2, x1_node2, x2_node2, x3_node2};
        agg_ready[0] <= 1'b1;
    end
end

//node 1 aggregation
logic signed[4:0] agg1_x01, agg1_x02, agg1_x03, agg1_x04;
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg1_x01, agg1_x02, agg1_x03, agg1_x04} <= '0;
    end
    else if(in_ready) begin
        {agg1_x01, agg1_x02, agg1_x03, agg1_x04} <= 
            {x0_node0, x1_node0, x2_node0, x3_node0} + 
            {x0_node1, x1_node1, x2_node1, x3_node1} +
            {x0_node3, x1_node3, x2_node3, x3_node3};
        agg_ready[1] <= 1'b1;
    end
end

//node 2 aggregation
logic signed[4:0] agg2_x01, agg2_x02, agg2_x03, agg2_x04;
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg2_x01, agg2_x02, agg2_x03, agg2_x04} <= '0;
    end
    else if(in_ready) begin
        {agg2_x01, agg2_x02, agg2_x03, agg2_x04} <= 
            {x0_node0, x1_node0, x2_node0, x3_node0} + 
            {x0_node2, x1_node2, x2_node2, x3_node2} +
            {x0_node3, x1_node3, x2_node3, x3_node3};
        agg_ready[2] <= 1'b1;
    end
end

//node 3 aggregation
logic signed[4:0] agg3_x01, agg3_x02, agg3_x03, agg3_x04;
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {agg3_x01, agg3_x02, agg3_x03, agg3_x04} <= '0;
    end
    else if(in_ready) begin
        {agg3_x01, agg3_x02, agg3_x03, agg3_x04} <= 
            {x0_node2, x1_node2, x2_node2, x3_node2} + 
            {x0_node1, x1_node1, x2_node1, x3_node1} +
            {x0_node3, x1_node3, x2_node3, x3_node3};
        agg_ready[3] <= 1'b1;
    end
end


//Hook up DNNs
logic[3:0] out0_ready, out1_ready;
logic[16:0] out0_n0, out1_n0;
DNN node0(
    .clk(clk),
    .rst_n(rst_n),
    .in_ready(agg_ready[0]),
    .x0(agg0_x01), .x1(agg0_x02), .x2(agg0_x03), .x3(agg0_x04),
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
    .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
    .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
    .w34(w34), .w35(w35), .w36(w36), .w37(w37), 
    .w48(w48), .w58(w58), .w68(w68), .w78(w78),
    .w49(w49), .w59(w59), .w69(w69), .w79(w79),
    .out0_ready(out0_ready[0]), .out1_ready(out1_ready[0]),
    .out0(out0_n0), .out1(out1_n0)
);

logic[16:0] out0_n1, out1_n1;
DNN node1(
    .clk(clk),
    .rst_n(rst_n),
    .in_ready(agg_ready[1]),
    .x0(agg1_x01), .x1(agg1_x02), .x2(agg1_x03), .x3(agg1_x04),
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
    .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
    .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
    .w34(w34), .w35(w35), .w36(w36), .w37(w37), 
    .w48(w48), .w58(w58), .w68(w68), .w78(w78),
    .w49(w49), .w59(w59), .w69(w69), .w79(w79),
    .out0_ready(out0_ready[1]), .out1_ready(out1_ready[1]),
    .out0(out0_n1), .out1(out1_n1)
);

logic[16:0] out0_n2, out1_n2;
DNN node2(
    .clk(clk),
    .rst_n(rst_n),
    .in_ready(agg_ready[2]),
    .x0(agg2_x01), .x1(agg2_x02), .x2(agg2_x03), .x3(agg2_x04),
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
    .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
    .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
    .w34(w34), .w35(w35), .w36(w36), .w37(w37), 
    .w48(w48), .w58(w58), .w68(w68), .w78(w78),
    .w49(w49), .w59(w59), .w69(w69), .w79(w79),
    .out0_ready(out0_ready[2]), .out1_ready(out1_ready[2]),
    .out0(out0_n2), .out1(out1_n2)
);

logic[16:0] out0_n3, out1_n3;
DNN node3(
    .clk(clk),
    .rst_n(rst_n),
    .in_ready(agg_ready[3]),
    .x0(agg3_x01), .x1(agg3_x02), .x2(agg3_x03), .x3(agg3_x04),
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), 
    .w14(w14), .w15(w15), .w16(w16), .w17(w17), 
    .w24(w24), .w25(w25), .w26(w26), .w27(w27), 
    .w34(w34), .w35(w35), .w36(w36), .w37(w37), 
    .w48(w48), .w58(w58), .w68(w68), .w78(w78),
    .w49(w49), .w59(w59), .w69(w69), .w79(w79),
    .out0_ready(out0_ready[3]), .out1_ready(out1_ready[3]),
    .out0(out0_n3), .out1(out1_n3)
);

//Perform output aggregation
//node0
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {out0_node0, out1_node0} <= '0;
    end
    else if(out0_ready[0] | out1_ready[0])begin
        {out0_node0, out1_node0} <= 
            {out0_n0, out0_n1, out0_n2} + 
            {out1_n0, out1_n1, out1_n2};
        out10_ready_node0 <= out0_ready[0];
        out11_ready_node0 <= out1_ready[0];
    end
end

//node1
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {out0_node1, out1_node1} <= '0;
    end
    else if(out0_ready[1] | out1_ready[1])begin
        {out0_node1, out1_node1} <= 
            {out0_n0, out0_n1, out0_n3} + 
            {out1_n0, out1_n1, out1_n3};
        out10_ready_node1 <= out0_ready[1];
        out11_ready_node1 <= out1_ready[1];
    end
end

//node2
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {out0_node2, out1_node2} <= '0;
    end
    else if(out0_ready[2] | out1_ready[2])begin
        {out0_node2, out1_node2} <= 
            {out0_n0, out0_n3, out0_n2} + 
            {out1_n0, out1_n3, out1_n2};
        out10_ready_node2 <= out0_ready[2];
        out11_ready_node2 <= out1_ready[2];
    end
end

//node3
always_ff@(posedge clk, negedge rst_n)begin
    if(~rst_n)begin
        {out0_node3, out1_node3} <= '0;
    end
    else if(out0_ready[3] | out1_ready[3])begin
        {out0_node3, out1_node3} <= 
            {out0_n3, out0_n1, out0_n2} + 
            {out1_n3, out1_n1, out1_n2};
        out10_ready_node3 <= out0_ready[3];
        out11_ready_node3 <= out1_ready[3];
    end
end
endmodule