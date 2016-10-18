`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:26:38 04/25/2008 
// Design Name: 
// Module Name:    interleave_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:  delay: 17*12 = 11 * 204
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module interleave_top(
input				clk,
input				clk_bit,
input				rst_n,
input [7:0]			din,
input				syn_in,

output wire [7:0]		dout_byte,
output wire				syn_out
);

wire	syn_out_bit;
wire	dout_bit;
interleave	interleave 
(
.clk(clk),
.clk_bit(clk_bit),
.rst_n(rst_n),
.din(din),
.syn_in(syn_in),

.d_il_byte(),
.syn_il_byte(),
.syn_out_bit(syn_out_bit),	//only used in test
.dout_bit(dout_bit)
);

del_interleave	del_interleave
(
.clk(clk),
.clk_bit(clk_bit),
.rst_n(rst_n),
.syn_in(syn_out_bit),//syn_in should be gived by the synchronous system
.din_bit(dout_bit),


.dout_byte(dout_byte),
.syn_out(syn_out)
);






endmodule