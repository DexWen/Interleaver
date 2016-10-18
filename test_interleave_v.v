`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:23:37 04/24/2008
// Design Name:   interleave
// Module Name:   E:/msy_xilinx/interleave/test_interleave.v
// Project Name:  interleave
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: interleave
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_interleave_v;

	// Inputs
	reg clk;
	reg clk_bit;
	reg rst_n;
	reg [7:0] din;
	reg syn_in;

	// Outputs
	wire [7:0] d_il_byte;
	wire syn_il_byte;
	wire dout_bit;

	// Instantiate the Unit Under Test (UUT)
	interleave uut (
		.clk(clk), 
		.clk_bit(clk_bit), 
		.rst_n(rst_n), 
		.din(din), 
		.syn_in(syn_in), 
		.d_il_byte(d_il_byte), 
		.syn_il_byte(syn_il_byte), 
		.dout_bit(dout_bit)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clk_bit = 0;
		rst_n = 0;
		din = 0;
		syn_in = 0;
		
		#80 rst_n = 1'd1;
		#100 rst_n = 1'd0;
		#1200 rst_n = 1'd1;

		// Wait 100 ns for global reset to finish
		#500000 $stop;
        
		// Add stimulus here

	end
  
always #10 clk_bit = ~clk_bit;  
always #80 clk = ~clk;
 
////stop counter
//reg [3:0] counter;
//always @ (posedge clk or negedge rst_n)
//begin
//	if(!rst_n)
//		begin
//			counter <= 4'd0;
//		end
//	else if(counter == 4'd15)
//		begin
//			counter <= counter;
//		end
//	else	if(syn_in == 1'd1)
//		begin
//			counter <= counter + 4'd1;
//		end
//end

//take the counter as din
always @ (posedge clk or negedge rst_n)
begin
	if (!rst_n)
		din <= 8'd66;
//	else	if(counter == 4'd15)
//		din <= 8'dx;
	else	if (din == 8'd203)
		din <= 8'd0;
	else  din <= din + 8'd1;
end

//
always @ (posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			syn_in <= 1'd0;
		end
//	else if(counter == 4'd15)
//		begin
//			syn_in <= 1'd0;
//		end
	else if (din == 8'd203)
		begin
			syn_in <= 1'd1;
		end
	else 
		begin
			syn_in <= 1'd0;
		end
end
	  
endmodule