module rtl_top#(
  parameter DWIDTH = 32,
  parameter ADDR_WIDTH= 16,
  parameter AWIDTH = 32,
  parameter ENDIANNESS =0
) (
  input hclk,
  input hreset,
  
  // AHB Slave Interface
  input hsel,
  input [31:0] haddr,
  input [2:0] hburst,
  input [1:0] htrans,
  input [31:0] hwdata,
  input hwrite,
  input [2:0] hsize,
  input hmastlock,
  
  output hresp,
  output [31:0] hrdata,
  output hready
);

// Internal wires
wire hsel_sram, hsel_fifo;

// Decoder Module
decoder decoder_inst (
  .haddr(haddr),
  .hsel_sram(hsel_sram),
  .hsel_fifo(hsel_fifo)
);

// SRAM and FIFO Interfaces
wire [DWIDTH-1:0] sram_rdata,rdata;
wire fiford;
wire [3:0] sram_wen;
wire [DWIDTH-1:0] sram_wdata,wdata;
wire [ADDR_WIDTH-3:0] sram_addr;
wire [AWIDTH-1:0] waddr,raddr;
wire fifowr;

// AHB to SRAM/FIFO Modules (Instantiate based on selection)
    ahb_to_sram #(ADDR_WIDTH,ENDIANNESS) sram_interface (
      .hclk(hclk),
      .hresetn(hreset),
     
      .hsel(hsel_sram),
      .haddr(haddr),
    //  .hburst(hburst),
      .htrans(htrans),
      .hrdata(hrdata),
      .hwdata(hwdata),
      .hwrite(hwrite),
      .hsize(hsize),
     // .hmastlock(hmastlock),
     
      .hresp(hresp),
      .hready(hready),
      .hreadyout(hreadyout),
      .sram_rdata(sram_rdata),
     // .sram_rdata(sram_rdata),
      .sram_addr(sram_addr),
      .sram_cs(sram_cs),
      .sram_wen(sram_wen),
      .sram_wdata(sram_wdata)
    );


// FIFO Interface (always instantiated)
asyn_fifo #(DWIDTH, AWIDTH) fifo_interface (
  .rdata(rdata),
  .wfull(fifowr),
  .rempty(fiford),
  .wdata(wdata),
  .fiford(hsel_fifo & htrans[1] & !hwrite), // Read from FIFO
  .rclk(hclk),
  .rrst(hreset),
  .fifowr(hsel_fifo & htrans[1] & hwrite),  // Write to FIFO
  .wclk(hclk),
  .wrst(hreset)
);
assign hsel = hsel_sram ? 1'b0 : hsel_fifo;
// Data Selection and Output
assign hrdata = (hsel) ? sram_rdata : rdata;

// Ready Signal (may need modification based on implementation)
assign hready = 1'b1; // Might need to consider SRAM/FIFO access times

endmodule
