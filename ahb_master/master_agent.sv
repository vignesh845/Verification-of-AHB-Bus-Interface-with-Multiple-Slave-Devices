class master_agent extends uvm_agent;
   `uvm_component_utils(master_agent)
	
    master_driver mdrvh;
    master_monitor mmonh;
    master_seqr mseqrh;
	
    master_agt_config ahb_cfg;
	
    extern function new(string name = "master_agent", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass


//------------Constructor--------------//
  function master_agent::new(string name = "master_agent", uvm_component parent);
     super.new (name, parent);
  endfunction


//-------------Build Phase--------------//
  function void master_agent::build_phase(uvm_phase phase);
     super.build_phase(phase);
	if(!uvm_config_db #(master_agt_config)::get(this, "", "master_agt_config", ahb_cfg))
	`uvm_fatal ("CONFIG","Cannot get() m_cfg from uvm_config_db. Have you set() it?")
	mmonh =master_monitor::type_id::create("mmonh", this);

        if(ahb_cfg.is_active == UVM_ACTIVE)
        begin
             mdrvh=master_driver::type_id::create("mdrvh", this);
             mseqrh=master_seqr::type_id::create("mseqrh", this);
        end
  endfunction


//-----------connect_phase------------//
  function void master_agent::connect_phase(uvm_phase phase);
     super.connect_phase(phase);
	if(ahb_cfg.is_active == UVM_ACTIVE)
        begin
        mdrvh.seq_item_port.connect(mseqrh.seq_item_export);
        end
  endfunction

