`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:40:35 04/25/2008 
// Design Name: 
// Module Name:    del_interleave 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module del_interleave(
input				clk,
input				clk_bit,
input				rst_n,
input				syn_in,//syn_in should be gived by the synchronous system
input				din_bit,


output reg [7:0]		dout_byte,
output reg				syn_out
);
reg [7:0] shift_reg0 [186:0]; //17*11=187
reg [7:0] shift_reg1 [169:0]; //17*10=170
reg [7:0] shift_reg2 [152:0];  //17*9=153
reg [7:0] shift_reg3 [135:0];  //17*8=136
reg [7:0] shift_reg4 [118:0];  //17*7=119
reg [7:0] shift_reg5 [101:0];  //17*6=102
reg [7:0] shift_reg6 [84:0];   //17*5=85
reg [7:0] shift_reg7 [67:0];   //17*4=68
reg [7:0] shift_reg8 [50:0];   //17*3=51
reg [7:0] shift_reg9 [33:0];   //17*2=34
reg [7:0] shift_reg10 [16:0];   //17


reg [3:0]	i_count;
reg 			din_bit_reg;
reg			syn_in_reg;
integer		i;

wire			syn_pos;
reg [7:0]	bit_buf1;
reg [7:0]	bit_buf2;
reg			syn_buf1;
reg			syn_buf2;
reg [2:0]	s2p_count;
//reg			syn_byte_reg;
reg [7:0]	d_il_byte;
//reg [7:0]	d_il_byte_reg;
reg			syn_byte;

//buffer the data and syn
always @(posedge clk_bit or negedge rst_n)
begin
	if(!rst_n)
	begin
		syn_in_reg <= 1'b0;
		din_bit_reg <= 1'b0;
	end
	else
	begin
		syn_in_reg <= syn_in;
		din_bit_reg <= din_bit;
	end
end
/***************************************************************
//   Serial   to  Parallel
***************************************************************/
//bit_buf1
always  @(posedge clk_bit or negedge rst_n)
begin
	if(!rst_n)
		begin
			bit_buf1 <= 7'd0;
			syn_buf1 <= 1'd0;
		end
	else
		begin
			bit_buf1[7 - s2p_count] <= din_bit_reg;
			syn_buf1 <= syn_in_reg;
		end
end
//bit_buf2
always  @(posedge clk_bit or negedge rst_n)
begin
	if(!rst_n)
		begin
			bit_buf2 <= 7'd0;
			syn_buf2 <= 1'd0;
		end
	else	if(s2p_count == 3'd0)
		begin
			bit_buf2 <= bit_buf1;
			syn_buf2 <= syn_buf1;
		end
end
//p2s_count
assign syn_pos = syn_in & ~syn_in_reg;  	// good!!
always  @(posedge clk_bit or negedge rst_n)
begin
	if(!rst_n)
		s2p_count <= 3'd0;
	else if(syn_pos)
		s2p_count <= 3'd0;
	else
		s2p_count <= s2p_count + 3'd1;
end

/***************************************************************
//   del_interleave
***************************************************************/
//buffer the byte and syn 
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			d_il_byte <= 8'd0;
			syn_byte  <= 1'd0;
		end
	else
		begin
			d_il_byte <= bit_buf2;
			syn_byte  <= syn_buf2;			
		end
end
//i_count counter
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		i_count <= 4'd0;	//I mend the gen
	else if(syn_buf2 || i_count == 4'd11)
		i_count <= 4'd0;
	else
		i_count <= i_count + 4'd1;
end
 
//reg	rst_n_reg;
//always @(posedge clk )//or negedge rst_n)
//begin
//	rst_n_reg <= rst_n;
//end 

always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		dout_byte <= 8'd0;
		syn_out   <= 1'b0; 
//	end 
//	else	if(!rst_n_reg) 
//		begin 
//		dout_byte <= 8'd0;
//		syn_out   <= 1'b0;		 
//		 
//		for(i = 1; i < 17; i = i+1)
//			shift_reg10[i]	<= 	shift_reg10[i-1];
//		shift_reg10[0] 	<= 8'd0;
//		for(i = 1; i < 34; i = i+1)
//			shift_reg9[i]	<= 	shift_reg9[i-1];
//		shift_reg9[0] 	<= 8'd0;
//		for(i = 1; i < 51; i = i+1)
//			shift_reg8[i]	<= 	shift_reg8[i-1];
//		shift_reg8[0] 	<= 8'd0;
//		for(i = 1; i < 68; i = i+1)
//			shift_reg7[i]	<= 	shift_reg7[i-1];
//		shift_reg7[0] 	<= 8'd0;
//		for(i = 1; i < 85; i = i+1)
//			shift_reg6[i]	<= 	shift_reg6[i-1];
//		shift_reg6[0] 	<= 8'd0;
//		for(i = 1; i < 102; i = i+1)
//			shift_reg5[i]	<= 	shift_reg5[i-1];
//		shift_reg5[0] 	<= 8'd0;
//		for(i = 1; i < 119; i = i+1)
//			shift_reg4[i]	<= 	shift_reg4[i-1];
//		shift_reg4[0] 	<= 8'd0;
//		for(i = 1; i < 136; i = i+1)
//			shift_reg3[i]	<= 	shift_reg3[i-1];
//		shift_reg3[0] 	<= 8'd0;
//		for(i = 1; i < 153; i = i+1)
//			shift_reg2[i]	<= 	shift_reg2[i-1];
//		shift_reg2[0] 	<= 8'd0;
//		for(i = 1; i < 170; i = i+1)
//			shift_reg1[i]	<= 	shift_reg1[i-1];
//		shift_reg1[0] 	<= 8'd0;
//		for(i = 1; i < 187; i = i+1)
//			shift_reg0[i]	<= 	shift_reg0[i-1];
//		shift_reg0[0] 	<= 8'd0; 
		
//		for(i = 0; i < 17; i = i+1)
//			shift_reg10[i] 	<= 8'd0;
//		for(i = 0; i < 34; i = i+1)
//			shift_reg9[i] 	<= 8'd0;
//		for(i = 0; i < 51; i = i+1)
//			shift_reg8[i] 	<= 8'd0;
//		for(i = 0; i < 68; i = i+1)
//			shift_reg7[i] 	<= 8'd0;
//		for(i = 0; i < 85; i = i+1)
//			shift_reg6[i] 	<= 8'd0;
//		for(i = 0; i < 102; i = i+1)
//			shift_reg5[i] 	<= 8'd0;
//		for(i = 0; i < 119; i = i+1)
//			shift_reg4[i] 	<= 8'd0; 
//		for(i = 0; i < 136; i = i+1)
//			shift_reg3[i] 	<= 8'd0;
//		for(i = 0; i < 153; i = i+1)
//			shift_reg2[i] 	<= 8'd0;
//		for(i = 0; i < 170; i = i+1)
//			shift_reg1[i] 	<= 8'd0;
//		for(i = 0; i < 187; i = i+1)
//			shift_reg0[i] 	<= 8'd0;
			
//			begin
//				shift_reg10[i] 			<= 8'd0;
//				
//				shift_reg9[i] 			<= 8'd0;
//				shift_reg9[i+17] 		<= 8'd0;
//				
//				shift_reg8[i] 			<= 8'd0;
//				shift_reg8[i+17] 		<= 8'd0;
//				shift_reg8[i+34] 		<= 8'd0;
//				
//				shift_reg7[i] 			<= 8'd0;
//				shift_reg7[i+17] 		<= 8'd0;
//				shift_reg7[i+34] 		<= 8'd0;
//				shift_reg7[i+51] 		<= 8'd0;
//				
//				shift_reg6[i] 			<= 8'd0;
//				shift_reg6[i+17] 		<= 8'd0;
//				shift_reg6[i+34] 		<= 8'd0;
//				shift_reg6[i+51] 		<= 8'd0;
//				shift_reg6[i+68] 		<= 8'd0;
//				
//				shift_reg5[i] 			<= 8'd0;
//				shift_reg5[i+17] 		<= 8'd0;
//				shift_reg5[i+34] 		<= 8'd0;
//				shift_reg5[i+51] 		<= 8'd0;
//				shift_reg5[i+68] 		<= 8'd0;
//				shift_reg5[i+85] 		<= 8'd0;
//				
//				shift_reg4[i] 			<= 8'd0;
//				shift_reg4[i+17] 		<= 8'd0;
//				shift_reg4[i+34] 		<= 8'd0;
//				shift_reg4[i+51] 		<= 8'd0;
//				shift_reg4[i+68] 		<= 8'd0;
//				shift_reg4[i+85] 		<= 8'd0;
//				shift_reg4[i+102] 	<= 8'd0;
//				
//				shift_reg3[i] 			<= 8'd0;
//				shift_reg3[i+17] 		<= 8'd0;
//				shift_reg3[i+34] 		<= 8'd0;
//				shift_reg3[i+51] 		<= 8'd0;
//				shift_reg3[i+68] 		<= 8'd0;
//				shift_reg3[i+85] 		<= 8'd0;
//				shift_reg3[i+102] 	<= 8'd0;				
//				shift_reg3[i+119] 	<= 8'd0;
//				
//				shift_reg2[i] 			<= 8'd0;
//				shift_reg2[i+17] 		<= 8'd0;
//				shift_reg2[i+34] 		<= 8'd0;
//				shift_reg2[i+51] 		<= 8'd0;
//				shift_reg2[i+68] 		<= 8'd0;
//				shift_reg2[i+85] 		<= 8'd0;
//				shift_reg2[i+102] 	<= 8'd0;				
//				shift_reg2[i+119] 	<= 8'd0;
//				shift_reg2[i+136] 	<= 8'd0;
//				
//				shift_reg1[i]			<= 8'd0;
//				shift_reg1[i+17] 		<= 8'd0;
//				shift_reg1[i+34] 		<= 8'd0;
//				shift_reg1[i+51] 		<= 8'd0;
//				shift_reg1[i+68] 		<= 8'd0;
//				shift_reg1[i+85] 		<= 8'd0;
//				shift_reg1[i+102]		<= 8'd0;				
//				shift_reg1[i+119]		<= 8'd0;
//				shift_reg1[i+136]		<= 8'd0;
//				shift_reg1[i+153]		<= 8'd0;
//				
//				shift_reg0[i] 			<= 8'd0;
//				shift_reg0[i+17] 		<= 8'd0;
//				shift_reg0[i+34] 		<= 8'd0;
//				shift_reg0[i+51] 		<= 8'd0;
//				shift_reg0[i+68] 		<= 8'd0;
//				shift_reg0[i+85] 		<= 8'd0;
//				shift_reg0[i+102]		<= 8'd0;				
//				shift_reg0[i+119]		<= 8'd0;
//				shift_reg0[i+136]		<= 8'd0;
//				shift_reg0[i+153]		<= 8'd0;
//				shift_reg0[i+170]		<= 8'd0;		
//			end
	end
	else
	begin
		syn_out <= syn_byte;
		case(i_count)
		
			4'd0 :
			begin
				for(i = 1;i <= 186;i = i+1)
					begin
						shift_reg0[i] <= shift_reg0[i-1];
					end
				shift_reg0[0] <= d_il_byte;
				dout_byte <= shift_reg0[186];
			end
			
			4'd1 :
			begin
				for(i = 1;i <= 169;i = i+1)
					begin
						shift_reg1[i] <= shift_reg1[i-1];
					end
				shift_reg1[0] <= d_il_byte;
				dout_byte <= shift_reg1[169];
			end
			
			4'd2 :
			begin
				for(i = 1;i <= 152;i = i+1)
					begin
						shift_reg2[i] <= shift_reg2[i-1];
					end
				shift_reg2[0] <= d_il_byte;
				dout_byte <= shift_reg2[152];
			end
			
			4'd3 :
			begin
				for(i = 1;i <= 135;i = i+1)
					begin
						shift_reg3[i] <= shift_reg3[i-1];
					end
				shift_reg3[0] <= d_il_byte;
				dout_byte <= shift_reg3[135];
			end
			
			4'd4 :
			begin
				for(i = 1;i <= 118;i = i+1)
					begin
						shift_reg4[i] <= shift_reg4[i-1];
					end
				shift_reg4[0] <= d_il_byte;
				dout_byte <= shift_reg4[118];
			end
			
			4'd5 :
			begin
				for(i = 1;i <= 101;i = i+1)
					begin
						shift_reg5[i] <= shift_reg5[i-1];
					end
				shift_reg5[0] <= d_il_byte;
				dout_byte <= shift_reg5[101];
			end
			
			4'd6 :
			begin
				for(i = 1;i <= 84;i = i+1)
					begin
						shift_reg6[i] <= shift_reg6[i-1];
					end
				shift_reg6[0] <= d_il_byte;
				dout_byte <= shift_reg6[84];
			end
			
			4'd7 :
			begin
				for(i = 1;i <= 67;i = i+1)
					begin
						shift_reg7[i] <= shift_reg7[i-1];
					end
				shift_reg7[0] <= d_il_byte;
				dout_byte <= shift_reg7[67];
			end
			
			4'd8 :
			begin
				for(i = 1;i <= 50;i = i+1)
					begin
						shift_reg8[i] <= shift_reg8[i-1];
					end
				shift_reg8[0] <= d_il_byte;
				dout_byte <= shift_reg8[50];
			end
			
			4'd9 :
			begin
				for(i = 1;i <= 33;i = i+1)
					begin
						shift_reg9[i] <= shift_reg9[i-1];
					end
				shift_reg9[0] <= d_il_byte;
				dout_byte <= shift_reg9[33];
			end
			
			4'd10:
			begin
				for(i = 1;i <= 16;i = i+1)
					begin
						shift_reg10[i] <= shift_reg10[i-1];
					end
				shift_reg10[0] <= d_il_byte;
				dout_byte <= shift_reg10[16];
			end
			
			4'd11:
			begin
				dout_byte <= d_il_byte;
			end

			default:
			begin
				dout_byte <= 8'd0;
				syn_out <= 1'b0;
			end
		endcase
	end
end


endmodule