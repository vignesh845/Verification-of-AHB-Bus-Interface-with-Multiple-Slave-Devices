module ahb_to_sram #(
  parameter ADDR_WIDTH          = 32,
  parameter ENDIANNESS          = 0
)
(

  input  wire                    hclk     ,
  input  wire                    hresetn  ,
  input  wire                    hsel     ,
  input  wire                    hready   ,
  input  wire              [1:0] htrans   ,
  input  wire              [2:0] hsize    ,
  input  wire                    hwrite   ,
  input  wire   [31:0] haddr    ,
  input  wire             [31:0] hwdata   ,

  output wire                    hreadyout,
  output wire                    hresp    ,
  output wire             [31:0] hrdata   ,

  input  wire             [31:0] sram_rdata,
  output wire   [ADDR_WIDTH-3:0] sram_addr,
  output wire              [3:0] sram_wen,
  output wire             [31:0] sram_wdata,
  output wire                    sram_cs  
);
  reg  [(ADDR_WIDTH-3):0]   buf_addr;
  reg  [ 3:0]               buf_we;
  reg                       buf_hit;
  reg  [31:0]               buf_data;
  reg                       buf_pend;
  reg                       buf_data_en;


  wire        ahb_access   = htrans[1] & hsel & hready;
  wire        ahb_write    = ahb_access &  hwrite;
  wire        ahb_read     = ahb_access & (~hwrite);

  wire [1:0]  unused       = {hsize[2],htrans[0]};

  wire        buf_pend_nxt = (buf_pend | buf_data_en) & ahb_read;

  wire        ram_write    = (buf_pend | buf_data_en)  & (~ahb_read);

  assign      sram_wen  = {4{ram_write}} & buf_we[3:0];

  assign      sram_addr = ahb_read ? haddr[ADDR_WIDTH-1:2] : buf_addr;

  assign      sram_cs   = (ahb_read | ram_write) ;


  wire       tx_byte    = (~hsize[1]) & (~hsize[0]);
  wire       tx_half    = (~hsize[1]) &  hsize[0];
  wire       tx_word    =   hsize[1];

  wire       byte_at_00;
  wire       byte_at_01;
  wire       byte_at_10;
  wire       byte_at_11;

  wire       half_at_00;
  wire       half_at_10;

  generate
    if(ENDIANNESS == 2) begin: WORD_BIG_ENDIAN
      assign       byte_at_00 = tx_byte &   haddr[1]  &   haddr[0];
      assign       byte_at_01 = tx_byte &   haddr[1]  & (~haddr[0]);
      assign       byte_at_10 = tx_byte & (~haddr[1]) &   haddr[0];
      assign       byte_at_11 = tx_byte & (~haddr[1]) & (~haddr[0]);

      assign       half_at_00 = tx_half &   haddr[1];
      assign       half_at_10 = tx_half & (~haddr[1]);
    end
    else begin : LITTLE_OR_BYTE_BIG_ENDIAN
      assign       byte_at_00 = tx_byte & (~haddr[1]) & (~haddr[0]);
      assign       byte_at_01 = tx_byte & (~haddr[1]) &   haddr[0];
      assign       byte_at_10 = tx_byte &   haddr[1]  & (~haddr[0]);
      assign       byte_at_11 = tx_byte &   haddr[1]  &   haddr[0];

      assign       half_at_00 = tx_half & (~haddr[1]);
      assign       half_at_10 = tx_half &   haddr[1];
    end
  endgenerate

  wire       word_at_00 = tx_word;

  wire       byte_sel_0 = word_at_00 | half_at_00 | byte_at_00;
  wire       byte_sel_1 = word_at_00 | half_at_00 | byte_at_01;
  wire       byte_sel_2 = word_at_00 | half_at_10 | byte_at_10;
  wire       byte_sel_3 = word_at_00 | half_at_10 | byte_at_11;

  wire [3:0] buf_we_nxt = { byte_sel_3 & ahb_write,
                           byte_sel_2 & ahb_write,
                           byte_sel_1 & ahb_write,
                           byte_sel_0 & ahb_write };


  always @(posedge hclk or negedge hresetn)
    if (~hresetn)
      buf_data_en <= 1'b0;
    else
      buf_data_en <= ahb_write;

  always @(posedge hclk or negedge hresetn)
    if (~hresetn)
     buf_data <= {32{1'b0}};
    else begin
      if (buf_we[3] & buf_data_en)
        buf_data[31:24] <= hwdata[31:24];
      if(buf_we[2] & buf_data_en)
        buf_data[23:16] <= hwdata[23:16];
      if(buf_we[1] & buf_data_en)
        buf_data[15: 8] <= hwdata[15: 8];
      if(buf_we[0] & buf_data_en)
        buf_data[ 7: 0] <= hwdata[ 7: 0];
    end

  always @(posedge hclk or negedge hresetn)
    if (~hresetn)
      buf_we <= 4'b0000;
    else if(ahb_write)
      buf_we <= buf_we_nxt;

  always @(posedge hclk or negedge hresetn)
  begin
    if (~hresetn)
      buf_addr <= {(ADDR_WIDTH-2){1'b0}};
    else if (ahb_write)
      buf_addr <= haddr[(ADDR_WIDTH-1):2];
  end

  wire  buf_hit_nxt = (haddr[ADDR_WIDTH-1:2] == buf_addr[ADDR_WIDTH-3:0]);


  wire [ 3:0] merge1  = {4{buf_hit}} & buf_we;

  assign hrdata =
    { merge1[3] ? buf_data[31:24] : sram_rdata[31:24],
      merge1[2] ? buf_data[23:16] : sram_rdata[23:16],
      merge1[1] ? buf_data[15: 8] : sram_rdata[15: 8],
      merge1[0] ? buf_data[ 7: 0] : sram_rdata[ 7: 0] };


  always @(posedge hclk or negedge hresetn)
    if (~hresetn)
      buf_hit <= 1'b0;
    else if(ahb_read)
      buf_hit <= buf_hit_nxt;

  always @(posedge hclk or negedge hresetn)
    if (~hresetn)
      buf_pend <= 1'b0;
    else
      buf_pend <= buf_pend_nxt;

  assign sram_wdata = (buf_pend) ? buf_data : hwdata[31:0];

  assign hreadyout = 1'b1;
  assign hresp     = 1'b0;
  
  endmodule
  
  module sram (
  input clk,
  input sram_wen,
  input sram_cs,
  input [7:0] sram_addr,  // Assuming 8-bit address (256 locations)
  input [7:0] sram_rdata,   // Assuming 8-bit data width
  output reg [7:0] sram_wdata
);

  // Memory size and data width explicitly defined
  parameter ADDRESS_WIDTH = 8; 
  parameter DATA_WIDTH = 8;

  // Internal memory array
  reg [DATA_WIDTH-1:0] mem [2**ADDRESS_WIDTH-1:0];

  // Read/Write operations
  always @(posedge clk) begin
    if (sram_wen) begin
      mem[sram_addr] <= sram_rdata;
    end else if (sram_cs) begin
      sram_wdata <= mem[sram_addr];
    end
  end

endmodule
