class master_seqr extends uvm_sequencer#(master_xtn);

	`uvm_component_utils(master_seqr)
  
  extern function new(string name = "master_seqr",uvm_component parent);
endclass


//------------Constructor---------//
	function master_seqr::new(string name="master_seqr",uvm_component parent);
	  super.new(name,parent);
  endfunction
