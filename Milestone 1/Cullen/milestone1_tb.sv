module milestone1_tb();

reg [4:0] x0, x1, x2, x3;
reg [4:0] w04, w14, w24, w34;
reg [4:0] w05, w15, w25, w35;
reg [4:0] w06, w16, w26, w36;
reg [4:0] w07, w17, w27, w37;
reg [4:0] w48, w58, w68, w78;
reg [4:0] w49, w59, w69, w79;

reg clk;

wire [16:0] out0, out1;
wire out10_ready, out11_ready;

reg in_ready;

top top(.x0(x0), .x1(x1), .x2(x2), .x3(x3), 
        .w04(w04), .w14(w14), .w24(w24), .w34(w34), 
        .w05(w05), .w15(w15), .w25(w25), .w35(w35),
        .w06(w06), .w16(w16), .w26(w26), .w36(w36),
        .w07(w07), .w17(w17), .w27(w27), .w37(w37),
        .w48(w48), .w58(w58), .w68(w68), .w78(w78),
        .w49(w49), .w59(w59), .w69(w69), .w79(w79),
        .out0(out0), .out1(out1),
        .in_ready(in_ready), .out0_ready(out10_ready), .out1_ready(out11_ready),
        .clk(clk));


initial begin
    clk = 0;
    in_ready = 0;
  //Provided tb values
    x0 = 5'b00100;
    x1 = 5'b00010;
    x2 = 5'b00100;
    x3 = 5'b00001;
    
    w04 = 5'b00011;
    w14 = 5'b00010;
    w24 = 5'b01101;
    w34 = 5'b11010;
    w05 = 5'b10111;
    w15 = 5'b00001;
    w25 = 5'b11100;
    w35 = 5'b01110;
    w06 = 5'b00011;
    w16 = 5'b00110;
    w26 = 5'b10001;
    w36 = 5'b01111;
    w07 = 5'b01001;
    w17 = 5'b10110;
    w27 = 5'b01111;
    w37 = 5'b10110;
    w48 = 5'b00000;
    w58 = 5'b11111;
    w68 = 5'b00011;
    w78 = 5'b10101;
    w49 = 5'b10100;
    w59 = 5'b10001;
    w69 = 5'b10001;
    w79 = 5'b00110;
    
    @(negedge clk);
    in_ready = 1;
    
    @(negedge clk)
	  in_ready = 0;

    @(posedge out10_ready)
	if (out0 == -17'd726 && out1 == -17'd348)begin
	  $display("Output with provided values correct");
	end
	else begin
	  $display("Output with provided values incorrect");
	  $display("Expected: out0 = %h, out1 = %h", -17'd726, -17'd348);
	  $display("Received: out0 = %h, out1 = %h", out0, out1);
	  $finish();
	end
    @(posedge clk);
    // $stop();

  //Other provided random values (xlsx page 2)
    @(negedge clk)
    in_ready = 1; 
    
    x0 = 5'd4;
    x1 = 5'd2;
    x2 = 5'd4;
    x3 = 5'd1;
    
    w04 = 5'd3;
    w14 = 5'd2;
    w24 = 5'd13;
    w34 = 5'd0;
    w05 = 5'd0;
    w15 = 5'd0;
    w25 = 5'd0;
    w35 = 5'd14;
    w06 = 5'd3;
    w16 = 5'd6;
    w26 = 5'd0;
    w36 = 5'd15;
    w07 = 5'd9;
    w17 = 5'd0;
    w27 = 5'd15;
    w37 = 5'd0;
    w48 = 5'd0;
    w58 = 5'd0;
    w68 = 5'd3;
    w78 = 5'd11;
    w49 = 5'd12;
    w59 = 5'd0;
    w69 = 5'd0;
    w79 = 5'd6;

    @(negedge clk)
	in_ready = 0;

    @(posedge out10_ready)
	if (out0 == 17'd1173 && out1 == 17'd1392)begin
	  $display("Output with random values correct");
	end
	else begin
	  $display("Output with random values incorrect");
	  $display("Expected: out0 = %h, out1 = %h", 17'd1173, 17'd1392);
	  $display("Received: out0 = %h, out1 = %h", out0, out1);
	  $finish();
	end

  //All 0s
    @(negedge clk)
    in_ready = 1; 
    
    x0 = 0;
    x1 = 0;
    x2 = 0;
    x3 = 0;
    
    w04 = 0;
    w14 = 0;
    w24 = 0;
    w34 = 0;
    w05 = 0;
    w15 = 0;
    w25 = 0;
    w35 = 0;
    w06 = 0;
    w16 = 0;
    w26 = 0;
    w36 = 0;
    w07 = 0;
    w17 = 0;
    w27 = 0;
    w37 = 0;
    w48 = 0;
    w58 = 0;
    w68 = 0;
    w78 = 0;
    w49 = 0;
    w59 = 0;
    w69 = 0;
    w79 = 0;

    @(negedge clk)
	in_ready = 0;

    @(posedge out10_ready)
	if (out0 == 17'd0 && out1 == 17'd0)begin
	  $display("Output with all 0s correct");
	end
	else begin
	  $display("Output with all 0s incorrect");
	  $display("Expected: out0 = %h, out1 = %h", 17'd0, 17'd0);
	  $display("Received: out0 = %h, out1 = %h", out0, out1);
	  $finish();
	end

  //All max positive values
    @(negedge clk)
    in_ready = 1; 
    
    x0 = 5'd15;
    x1 = 5'd15;
    x2 = 5'd15;
    x3 = 5'd15;
    
    w04 = 5'd15;
    w14 = 5'd15;
    w24 = 5'd15;
    w34 = 5'd15;
    w05 = 5'd15;
    w15 = 5'd15;
    w25 = 5'd15;
    w35 = 5'd15;
    w06 = 5'd15;
    w16 = 5'd15;
    w26 = 5'd15;
    w36 = 5'd15;
    w07 = 5'd15;
    w17 = 5'd15;
    w27 = 5'd15;
    w37 = 5'd15;
    w48 = 5'd15;
    w58 = 5'd15;
    w68 = 5'd15;
    w78 = 5'd15;
    w49 = 5'd15;
    w59 = 5'd15;
    w69 = 5'd15;
    w79 = 5'd15;

    @(negedge clk)
	  in_ready = 0;

    @(posedge out10_ready)
	  if (out0 == 17'd54000 && out1 == 17'd54000)
	    $display("Output with max positive values correct");
	  else
    begin
      $display("Output with max positive values incorrect");
      $display("Expected: out0 = %h, out1 = %h", 17'd54000, 17'd54000);
      $display("Received: out0 = %h, out1 = %h", out0, out1);
      $finish();
	  end

  //All max negative values
    @(negedge clk)
    in_ready = 1; 
    
    x0 = -5'd16;
    x1 = -5'd16;
    x2 = -5'd16;
    x3 = -5'd16;
    
    w04 = -5'd16;
    w14 = -5'd16;
    w24 = -5'd16;
    w34 = -5'd16;
    w05 = -5'd16;
    w15 = -5'd16;
    w25 = -5'd16;
    w35 = -5'd16;
    w06 = -5'd16;
    w16 = -5'd16;
    w26 = -5'd16;
    w36 = -5'd16;
    w07 = -5'd16;
    w17 = -5'd16;
    w27 = -5'd16;
    w37 = -5'd16;
    w48 = -5'd16;
    w58 = -5'd16;
    w68 = -5'd16;
    w78 = -5'd16;
    w49 = -5'd16;
    w59 = -5'd16;
    w69 = -5'd16;
    w79 = -5'd16;

    @(negedge clk)
	  in_ready = 0;

    @(posedge out10_ready)
	  if (out0 == -17'd65536 && out1 == -17'd65536)
	    $display("Output with max negative values correct");
	else
    begin
      $display("Output with max negative values incorrect");
      $display("Expected: out0 = %h, out1 = %h", -17'd65536, -17'd65536);
      $display("Received: out0 = %h, out1 = %h", out0, out1);
      $finish();
    end

  // Individual value tests complete!

  @(posedge clk);
  $display("Now to Fill the pipeline!!");

  // First set of inputs
  @(negedge clk);
  in_ready = 1;
  {x0, x1, x2, x3} = {5'd0, 5'd0, 5'd0, 5'd0};
  
  // Second set of inputs
  @(negedge clk);
  in_ready = 1;
  {x0, x1, x2, x3} = {-5'd1, -5'd1, -5'd1, -5'd1};
  
  // Third set of inputs
  @(negedge clk);
  in_ready = 1;
  {x0, x1, x2, x3} = {5'd0, 5'd0, 5'd0, 5'd0};
  
  // Fourth set of inputs
  @(negedge clk);
  in_ready = 1;
  {x0, x1, x2, x3} = {-5'd1, -5'd1, -5'd1, -5'd1};
  
  // 5th Set
  @(negedge clk);
  in_ready = 1;
  {x0, x1, x2, x3} = {-5'd1, -5'd1, 5'd1, -5'd1};

  // 6th Set
  @(negedge clk);
  in_ready = 0;
  {x0, x1, x2, x3} = {-5'd1, 5'd1, 5'd1, -5'd1};

  repeat(5) @(posedge clk);
  $stop("Test Complete!");
end

always
  #5 clk = ~clk;




endmodule
