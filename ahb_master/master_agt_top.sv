class master_agt_top extends uvm_env;

  `uvm_component_utils(master_agt_top)

   master_agent agt[];
   env_config m_cfg;
   integer i;
 
   extern function new (string name = "master_agt_top", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
endclass


//------------Constructor----------//
  function master_agt_top::new(string name = "master_agt_top", uvm_component parent);
      super.new(name,parent);
  endfunction


//------------------build phase -------------//
  function void master_agt_top::build_phase(uvm_phase phase);
     super.build_phase(phase);

     if(!uvm_config_db#(env_config)::get(this,"","env_config",m_cfg))
        `uvm_fatal("CONFIG","cannot get() cfg from uvm_config_db. Have you set() it?")
        //`uvm_fatal(get_type_name,"not able to get configuration")
	
	agt=new[m_cfg.no_of_ahb_magents];
	foreach(agt[i])
        begin
	agt[i]=master_agent::type_id::create($sformatf("agt[%0d]", i),this);
	uvm_config_db #(master_agt_config)::set(this,$sformatf("agt[%0d]*", i),"master_agt_config", m_cfg.ahb_mcfg[i]);
        end
  endfunction


