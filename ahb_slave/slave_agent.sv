class slave_agent extends uvm_agent;
	
	`uvm_component_utils(slave_agent)

	slave_driver sdrvh;
	slave_monitor smonh;
	slave_seqr sseqrh;

	slave_agt_config apb_cfg;

	extern function new(string name = "slave_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase (uvm_phase phase);
endclass

//-------------Constructor--------//
	function slave_agent::new(string name="slave_agent", uvm_component parent);
		super.new(name,parent);
  endfunction


//------------Build Phase---------//
	function void slave_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(slave_agt_config)::get(this,"","slave_agt_config",apb_cfg))
		`uvm_fatal("CONFIG","Cannot get() ahb_cfg from uvm_config_db.Have you set it?")

        	smonh = slave_monitor::type_id::create("smonh",this);
        	if(apb_cfg.is_active==UVM_ACTIVE)
        	begin
        		sdrvh=slave_driver::type_id::create("sdrvh",this);
         	  sseqrh=slave_seqr::type_id::create("sseqrh",this);
        	end
  endfunction


//-------------connect phase---------//
	function void slave_agent::connect_phase(uvm_phase phase);
		super.connect_phase(phase);
        	if(apb_cfg.is_active==UVM_ACTIVE)
        	begin
       		  sdrvh.seq_item_port.connect(sseqrh.seq_item_export);
        	end
  endfunction

