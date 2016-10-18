/******************************************************************************
// File name: 		interleave.v
// Rev:           		1.0
// Description:  		interleave I=12,M=17
// Verilog-standard:  	Verilog 2001
// Target Devices: 		NULL
// Tool versions:  		ISE 9.1
//----------------------------------------------------------------------------
// Coder:      		Xu Jiansong
// History:
// Date: 			2007/07/15
// Copyright:		FreeCore.Lib
*******************************************************************************/
`timescale 1ns/1ps

module interleave #(
parameter I = 12,
parameter M = 17
)
(
input				clk,
input				clk_bit,
input				rst_n,
input [7:0]			din,
input				syn_in,
output reg [7:0]	d_il_byte,
output reg			syn_il_byte,
output reg			syn_out_bit,	//only used in test
output reg			dout_bit
);

reg [7:0] shift_reg1 [16:0];   //17
reg [7:0] shift_reg2 [33:0];   //17*2=34
reg [7:0] shift_reg3 [50:0];   //17*3=51
reg [7:0] shift_reg4 [67:0];   //17*4=68
reg [7:0] shift_reg5 [84:0];   //17*5=85
reg [7:0] shift_reg6 [101:0];  //17*6=102
reg [7:0] shift_reg7 [118:0];  //17*7=119
reg [7:0] shift_reg8 [135:0];  //17*8=136
reg [7:0] shift_reg9 [152:0];  //17*9=153
reg [7:0] shift_reg10 [169:0]; //17*10=170
reg [7:0] shift_reg11 [186:0]; //17*11=187

reg [3:0]	i_count;
reg [7:0]	din_reg;
reg			syn_in_reg;
integer		i;

// reg [7:0]	d_il_byte;
// reg			syn_il_byte;

reg [2:0]	p2s_count;
reg			syn_byte_reg;
reg [7:0]	d_il_byte_reg;

//buffer the data and syn
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		din_reg <= 8'd0;
		syn_in_reg <= 0;
	end
	else
	begin
		din_reg <= din;
		syn_in_reg <= syn_in;
	end
end

//i_count counter
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		i_count <= 4'hf;
	else if(syn_in || i_count == 4'd11)
		i_count <= 4'd0;
	else
		i_count <= i_count + 4'd1;
end
 
//reg	rst_n_reg; 
//always @(posedge clk or negedge rst_n)
//begin 
//	if(!rst_n) 
//		rst_n_reg <= 1'd0; 
//	else 
//		rst_n_reg <= 1'd1; 
//end 
 
//here used the synchronous reset ,it should be asynchronous reset in the post simulation
always @(posedge clk )//or negedge rst_n)
begin
	if(~rst_n)
	begin 
		d_il_byte <= 8'd0;
		syn_il_byte <= 1'b0; 
	end 
	else	if(rst_n_reg) 
		begin 
		d_il_byte <= 8'd1;	//
		syn_il_byte <= 1'b0;		 
		
		for(i = 1; i < 17; i = i+1) 
			shift_reg1[i]	<= 	shift_reg1[i-1];
		shift_reg1[0] 	<= 8'd0;
		for(i = 1; i < 34; i = i+1) 
			shift_reg2[i]	<= 	shift_reg2[i-1];
		shift_reg2[0] 	<= 8'd0;
		for(i = 1; i < 51; i = i+1) 
			shift_reg3[i]	<= 	shift_reg3[i-1];
		shift_reg3[0] 	<= 8'd0;
		for(i = 1; i < 68; i = i+1) 
			shift_reg4[i]	<= 	shift_reg4[i-1];
		shift_reg4[0] 	<= 8'd0;
		for(i = 1; i < 85; i = i+1) 
			shift_reg5[i]	<= 	shift_reg5[i-1];
		shift_reg5[0] 	<= 8'd0;
		for(i = 1; i < 102; i = i+1) 
			shift_reg6[i]	<= 	shift_reg6[i-1];
		shift_reg6[0] 	<= 8'd0;
		for(i = 1; i < 119; i = i+1) 
			shift_reg7[i]	<= 	shift_reg7[i-1];
		shift_reg7[0] 	<= 8'd0;
		for(i = 1; i < 136; i = i+1) 
			shift_reg8[i]	<= 	shift_reg8[i-1];
		shift_reg8[0] 	<= 8'd0;
		for(i = 1; i < 153; i = i+1) 
			shift_reg9[i]	<= 	shift_reg9[i-1];
		shift_reg9[0] 	<= 8'd0;
		for(i = 1; i < 170; i = i+1) 
			shift_reg10[i]	<= 	shift_reg10[i-1];
		shift_reg10[0] 	<= 8'd0;
		for(i = 1; i < 187; i = i+1) 
			shift_reg11[i]	<= 	shift_reg11[i-1];
		shift_reg11[0] 	<= 8'd0;

//			begin
//				shift_reg1[i] 			<= 8'd0;
//				
//				shift_reg2[i] 			<= 8'd0;
//				shift_reg2[i+17] 		<= 8'd0;
//				
//				shift_reg3[i] 			<= 8'd0;
//				shift_reg3[i+17] 		<= 8'd0;
//				shift_reg3[i+34] 		<= 8'd0;
//				
//				shift_reg4[i] 			<= 8'd0;
//				shift_reg4[i+17] 		<= 8'd0;
//				shift_reg4[i+34] 		<= 8'd0;
//				shift_reg4[i+51] 		<= 8'd0;
//				
//				shift_reg5[i] 			<= 8'd0;
//				shift_reg5[i+17] 		<= 8'd0;
//				shift_reg5[i+34] 		<= 8'd0;
//				shift_reg5[i+51] 		<= 8'd0;
//				shift_reg5[i+68] 		<= 8'd0;
//				
//				shift_reg6[i] 			<= 8'd0;
//				shift_reg6[i+17] 		<= 8'd0;
//				shift_reg6[i+34] 		<= 8'd0;
//				shift_reg6[i+51] 		<= 8'd0;
//				shift_reg6[i+68] 		<= 8'd0;
//				shift_reg6[i+85] 		<= 8'd0;
//				
//				shift_reg7[i] 			<= 8'd0;
//				shift_reg7[i+17] 		<= 8'd0;
//				shift_reg7[i+34] 		<= 8'd0;
//				shift_reg7[i+51] 		<= 8'd0;
//				shift_reg7[i+68] 		<= 8'd0;
//				shift_reg7[i+85] 		<= 8'd0;
//				shift_reg7[i+102] 	<= 8'd0;
//				
//				shift_reg8[i] 			<= 8'd0;
//				shift_reg8[i+17] 		<= 8'd0;
//				shift_reg8[i+34] 		<= 8'd0;
//				shift_reg8[i+51] 		<= 8'd0;
//				shift_reg8[i+68] 		<= 8'd0;
//				shift_reg8[i+85] 		<= 8'd0;
//				shift_reg8[i+102] 	<= 8'd0;				
//				shift_reg8[i+119] 	<= 8'd0;
//				
//				shift_reg9[i] 			<= 8'd0;
//				shift_reg9[i+17] 		<= 8'd0;
//				shift_reg9[i+34] 		<= 8'd0;
//				shift_reg9[i+51] 		<= 8'd0;
//				shift_reg9[i+68] 		<= 8'd0;
//				shift_reg9[i+85] 		<= 8'd0;
//				shift_reg9[i+102] 	<= 8'd0;				
//				shift_reg9[i+119] 	<= 8'd0;
//				shift_reg9[i+136] 	<= 8'd0;
//				
//				shift_reg10[i]			<= 8'd0;
//				shift_reg10[i+17] 	<= 8'd0;
//				shift_reg10[i+34] 	<= 8'd0;
//				shift_reg10[i+51] 	<= 8'd0;
//				shift_reg10[i+68] 	<= 8'd0;
//				shift_reg10[i+85] 	<= 8'd0;
//				shift_reg10[i+102]	<= 8'd0;				
//				shift_reg10[i+119]	<= 8'd0;
//				shift_reg10[i+136]	<= 8'd0;
//				shift_reg10[i+153]	<= 8'd0;
//				
//				shift_reg11[i] 		<= 8'd0;
//				shift_reg11[i+17] 	<= 8'd0;
//				shift_reg11[i+34] 	<= 8'd0;
//				shift_reg11[i+51] 	<= 8'd0;
//				shift_reg11[i+68] 	<= 8'd0;
//				shift_reg11[i+85] 	<= 8'd0;
//				shift_reg11[i+102]	<= 8'd0;				
//				shift_reg11[i+119]	<= 8'd0;
//				shift_reg11[i+136]	<= 8'd0;
//				shift_reg11[i+153]	<= 8'd0;
//				shift_reg11[i+170]	<= 8'd0;
//			end
	end
	else
	begin
		syn_il_byte <= syn_in_reg;
		case(i_count)
		
			4'd0 :
			begin
				d_il_byte <= din_reg;
			end
			4'd1 :
			begin
				for(i = 1; i <= 16; i = i+1)
				begin
					shift_reg1[i] <= shift_reg1[i-1];
				end
				shift_reg1[0] <= din_reg;
				d_il_byte <= shift_reg1[16];
			end
			
			4'd2 :
			begin
				for(i = 1; i <= 33; i = i+1)
				begin
					shift_reg2[i] <= shift_reg2[i-1];
				end
				shift_reg2[0] <= din_reg;
				d_il_byte <= shift_reg2[33];
			end
			
			4'd3 :
			begin
				for(i = 1; i <= 50; i = i+1)
				begin
					shift_reg3[i] <= shift_reg3[i-1];
				end
				shift_reg3[0] <= din_reg;
				d_il_byte <= shift_reg3[50];
			end
			
			4'd4 :
			begin
				for(i = 1; i <= 67; i = i+1)
				begin
					shift_reg4[i] <= shift_reg4[i-1];
				end
				shift_reg4[0] <= din_reg;
				d_il_byte <= shift_reg4[67];
			end
			
			4'd5 :
			begin
				for(i = 1; i <= 84; i = i+1)
				begin
					shift_reg5[i] <= shift_reg5[i-1];
				end
				shift_reg5[0] <= din_reg;
				d_il_byte <= shift_reg5[84];
			end
			
			4'd6 :
			begin
				for(i = 1; i <= 101; i = i+1)
				begin
					shift_reg6[i] <= shift_reg6[i-1];
				end
				shift_reg6[0] <= din_reg;
				d_il_byte <= shift_reg6[101];
			end
			
			4'd7 :
			begin
				for(i = 1; i <= 118; i = i+1)
				begin
					shift_reg7[i] <= shift_reg7[i-1];
				end
				shift_reg7[0] <= din_reg;
				d_il_byte <= shift_reg7[118];
			end
			
			4'd8 :
			begin
				for(i = 1; i <= 135; i = i+1)
				begin
					shift_reg8[i] <= shift_reg8[i-1];
				end
				shift_reg8[0] <= din_reg;
				d_il_byte <= shift_reg8[135];
			end
			
			4'd9 :
			begin
				for(i = 1; i <= 152; i = i+1)
				begin
					shift_reg9[i] <= shift_reg9[i-1];
				end
				shift_reg9[0] <= din_reg;
				d_il_byte <= shift_reg9[152];
			end
			
			4'd10:
			begin
				for(i = 1; i <= 169; i = i+1)
				begin
					shift_reg10[i] <= shift_reg10[i-1];
				end
				shift_reg10[0] <= din_reg;
				d_il_byte <= shift_reg10[169];
			end
			
			4'd11:
			begin
				for(i = 1; i <= 186; i = i+1)
				begin
					shift_reg11[i] <= shift_reg11[i-1];
				end
				shift_reg11[0] <= din_reg;
				d_il_byte <= shift_reg11[186];
			end

			default:
			begin
				d_il_byte <= 8'd0;
				syn_il_byte <= 1'b0;
			end
		endcase
	end
end

/***************************************************************
//	Parallel  to Serial 
***************************************************************/
//gen the control signal
always @(posedge clk_bit or negedge rst_n)
begin
	if(!rst_n)
	begin
		syn_byte_reg <= 1'b0;
		d_il_byte_reg <= 7'd0;
	end
	else
	begin
		syn_byte_reg <= syn_il_byte;
		d_il_byte_reg <= d_il_byte;
	end
end

assign syn_pos = syn_il_byte & ~syn_byte_reg;  //very good!!

always  @(posedge clk_bit or negedge rst_n)
begin
	if(!rst_n)
		p2s_count <= 3'd0;
	else if(syn_pos)
		p2s_count <= 3'd0;
	else
		p2s_count <= p2s_count + 3'd1;
end

always @(posedge clk_bit or negedge rst_n)
begin
	if(!rst_n)
		dout_bit <= 1'b0;
	else
		begin
			dout_bit <= d_il_byte_reg[7 - p2s_count]; 
			syn_out_bit <= syn_byte_reg;
		end
end

endmodule