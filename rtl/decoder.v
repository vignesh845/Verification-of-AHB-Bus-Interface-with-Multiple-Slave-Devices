module decoder(
input wire [31:0]haddr,
output hsel_sram,
output hsel_fifo);

assign hsel_sram = (haddr[3:0] == 4'h0) ? 1'b1:1'b0;
assign hsel_fifo = (haddr[3:0] == 4'h1) ? 1'b1:1'b0;
  

endmodule
