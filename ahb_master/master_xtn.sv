class master_xtn extends uvm_sequence_item;
   
   `uvm_object_utils(master_xtn)
   
   bit Hclk,HRESETn;
   bit [1:0]HRESP;
   bit HREADY;
   bit [31:0] HRDATA; //o/p so not random
   
   rand bit HWRITE;
   rand bit [2:0]HSIZE;
   rand bit [1:0]HTRANS;
   rand bit [31:0]HADDR;
   rand bit [2:0]HBURST;
   rand bit [31:0]HWDATA;
   rand bit [9:0]length;
   
   constraint valid_size{HSIZE inside {[0:2]};} 
       //since Hrdata and Hwdata are 32 bits wide
	     //2^0=1 byte of Hwdata,2^1=2 bytes,2^2=4 bytes of data
   
   constraint valid_length{(2^HSIZE)*length <= 1024;} 
        //length should not cross 1Kb

   constraint valid_haddr{(HSIZE == 1) ->HADDR % 2 == 0;
                          (HSIZE == 2) ->HADDR % 4 == 0;} 
                          // address should always be even
   

    //constraint valid_haddr1{HADDR inside {[32'h8000_0000 : 32'h8000_03ff],
      //                                    [32'h8400_0000 : 32'h8400_03ff];} 
   
   
    extern function new(string name="master_xtn");
    extern function void do_print(uvm_printer printer);
endclass


//------------Constructor---------//
	function master_xtn::new(string name = "master_xtn");
	   super.new(name);
  endfunction


//------------do_ptint------------//
  function void master_xtn::do_print(uvm_printer printer);
     super.do_print(printer);

      printer.print_field("HADDR", this.HADDR, 32, UVM_HEX);
      printer.print_field("HWDATA", this.HWDATA, 32, UVM_HEX);
      printer.print_field("HWRITE", this.HWRITE, 1, UVM_DEC);
      printer.print_field("HTRANS", this.HTRANS, 2, UVM_DEC);
      printer.print_field("HSIZE", this.HSIZE, 2, UVM_DEC);
      printer.print_field("HBURST", this.HBURST, 3, UVM_HEX);
      printer.print_field("HRDATA", this.HRDATA, 32, UVM_HEX);
      printer.print_field("length", this.length, 10, UVM_DEC);
  endfunction
