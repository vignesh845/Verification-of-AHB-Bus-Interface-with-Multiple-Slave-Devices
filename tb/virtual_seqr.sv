class virtual_seqr extends uvm_sequencer#(uvm_sequence_item);
  
	`uvm_component_utils(virtual_seqr)
	master_seqr mseqrh;
	slave_seqr sseqrh;
  env_config e_cfg;

 	extern function new(string name = "virtual_seqr",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass


function virtual_seqr::new(string name="virtual_seqr",uvm_component parent);
	super.new(name,parent);
endfunction


function void virtual_seqr::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
    super.build_phase(phase);
endfunction
