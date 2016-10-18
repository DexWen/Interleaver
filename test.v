//  Interface
//  
//    Build Name    : interleaver_4_4
//    Clock Domains : clk
//    Reset Signal  : rst  
//    Vector Input  : leaver_i(1)
//    Vector Input  : write_i(1)
//    Vector Input  : addr_i(4)
//    Vector Input  : data_i(8)
//    Vector Output : data_o(8)
//  
//  
//  

`timescale 1 ns / 1 ns

module interleaver_4_4_tb;
wire[7:0] data_o;
reg clk, rst, leaver_i, write_i;
reg[3:0] addr;
reg[7:0] data_i;
parameter DELY=500;
interleaver_4_4 myinterleaver(.clk(clk),.rst(rst),.leaver_i(leaver_i),.write_i(write_i),.addr(addr),.data_i(data_i),.data_o(data_o));
always #(DELY/2) clk=~clk;
always #(DELY)   addr[3:0]=addr[3:0]+4'b0001;
always #(DELY)   data_i[3:0]=data_i[3:0]+4'b0001;
initial
begin clk=0; rst=1; leaver_i=0; write_i=0; addr[7:0]=4'b0000; data_i[7:0]=8'b0000_0000;
#(DELY*10)  rst=0;
#(DELY*10)  rst=1; 
#(DELY*10)  addr[7:0]=4'b0000; data_i[7:0]=8'b0000_0000;
#(DELY*16) leaver_i=0; write_i=1;
#(DELY*47) leaver_i=1; write_i=0;
#(DELY*200) $stop;
end
endmodule