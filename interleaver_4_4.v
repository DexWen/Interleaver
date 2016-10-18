`timescale 1 ns / 1 ns

module interleaver_4_4 (clk, rst, leaver_i, write_i, addr, data_i, data_o);
input  clk;
input  rst;
input  leaver_i;
input  write_i;
input  [3:0]   addr;
input  [7:0]   data_i;
output [7:0]   data_o;
wire   [7:0]   temp_i;
reg    [7:0]   temp_o;
reg    [127:0] mem;
assign temp_i[7:0] = data_i[7:0];
assign data_o[7:0] = temp_o[7:0];
always @ (posedge clk)
   begin
       if(!rst)
         begin
            mem[127:0]  = 0;
            temp_o[7:0] = 0;
         end
   end
always @ (posedge clk)
   begin
      if(write_i)
             case(addr[3:0])
                 4'b0000:   mem[  7:  0] <= temp_i[7:0];
                 4'b0001:   mem[ 15:  8] <= temp_i[7:0];
                 4'b0010:   mem[ 23: 16] <= temp_i[7:0];
                 4'b0011:   mem[ 31: 24] <= temp_i[7:0];
                 4'b0100:   mem[ 39: 32] <= temp_i[7:0];
                 4'b0101:   mem[ 47: 40] <= temp_i[7:0];
                 4'b0110:   mem[ 55: 48] <= temp_i[7:0];
                 4'b0111:   mem[ 63: 56] <= temp_i[7:0];
                 4'b1000:   mem[ 71: 64] <= temp_i[7:0];
                 4'b1001:   mem[ 79: 72] <= temp_i[7:0];
                 4'b1010:   mem[ 87: 80] <= temp_i[7:0];
                 4'b1011:   mem[ 95: 88] <= temp_i[7:0];
                 4'b1100:   mem[103: 96] <= temp_i[7:0];
                 4'b1101:   mem[111:104] <= temp_i[7:0];
                 4'b1110:   mem[119:112] <= temp_i[7:0];
                 4'b1111:   mem[127:120] <= temp_i[7:0];
             endcase
        else if(leaver_i)
             case(addr[3:0])
                 4'b0000:   temp_o[7:0] <= mem[  7:  0];
                 4'b0001:   temp_o[7:0] <= mem[ 39: 32];
                 4'b0010:   temp_o[7:0] <= mem[ 71: 64];
                 4'b0011:   temp_o[7:0] <= mem[103: 96];
                 4'b0100:   temp_o[7:0] <= mem[ 15:  8];
                 4'b0101:   temp_o[7:0] <= mem[ 47: 40];
                 4'b0110:   temp_o[7:0] <= mem[ 79: 72];
                 4'b0111:   temp_o[7:0] <= mem[111:104];
                 4'b1000:   temp_o[7:0] <= mem[ 23: 16];
                 4'b1001:   temp_o[7:0] <= mem[ 55: 48];
                 4'b1010:   temp_o[7:0] <= mem[ 87: 80];
                 4'b1011:   temp_o[7:0] <= mem[119:112];
                 4'b1100:   temp_o[7:0] <= mem[ 31: 24];
                 4'b1101:   temp_o[7:0] <= mem[ 63: 56];
                 4'b1110:   temp_o[7:0] <= mem[ 95: 88];
                 4'b1111:   temp_o[7:0] <= mem[127:120];
             endcase
   end          
assign data_o[7:0] = temp_o[7:0];
endmodule

