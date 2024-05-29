class slave_xtn extends uvm_sequence_item;
   //`uvm_object_utils(slave_xtn)
   
   bit [31:0]HWDATA;
   bit [31:0]HADDR;
   rand bit HREADY;
   bit HWRITE;
   bit HRESP;
   rand bit HSEL;
   bit [2:0]HBURST;
   bit [2:0]HSIZE;
   rand bit [1:0]HTRANS;
   bit [9:0]length;
   rand bit [31:0]HRDATA;
   
   `uvm_object_utils_begin(slave_xtn)
     `uvm_field_int(HADDR, UVM_ALL_ON)
     `uvm_field_int(HWDATA, UVM_ALL_ON)
     `uvm_field_int(HWRITE, UVM_ALL_ON)
    // `uvm_field_int(HBURST, UVM_ALL_ON)
     `uvm_field_int(HSEL, UVM_ALL_ON)
     //`uvm_field_int(HTRANS, UVM_ALL_ON)
     //`uvm_field_int(length, UVM_ALL_ON)
    // `uvm_field_int(HRESP, UVM_ALL_ON)
     `uvm_field_int(HREADY, UVM_ALL_ON)
     `uvm_field_int(HRDATA, UVM_ALL_ON)
   `uvm_object_utils_end
   extern function new(string name = "slave_xtn");
endclass

//------------Constructor---------//
	function slave_xtn::new(string name = "slave_xtn");
	   super.new(name);
  endfunction
  
 