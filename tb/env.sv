class env extends uvm_env;

   `uvm_component_utils(env)
   
   master_agt_top ahb_mtop;
   slave_agt_top ahb_stop;
   
   env_config e_cfg;
   sb sbh;
   virtual_seqr vseqrh;
           
   extern function new(string name = "env", uvm_component parent);
   extern function void build_phase (uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
endclass


//-----------Constructor-----------//
  function env::new(string name = "env", uvm_component parent);
     super.new(name, parent);
  endfunction


//-----------Build Phase-----------//
  function void  env::build_phase(uvm_phase phase);
     super.build_phase(phase);
    
     if(!uvm_config_db #(env_config)::get(this, "", "env_config", e_cfg))
      `uvm_fatal("env", "cannot get the env_config")
      
    if(e_cfg.has_ahb_magent)
       begin
       ahb_mtop = master_agt_top::type_id::create("ahb_mtop", this);
       //uvm_config_db #(master_agt_config)::set(this, "*", "master_agt_config", e_cfg.ahb_cfg);
       end
        
     if(e_cfg.has_ahb_sagent)
       begin
       ahb_stop = slave_agt_top::type_id::create("ahb_stop", this);
       //uvm_config_db #(slave_agt_config)::set(this, "agt*", "slave_agt_config", e_cfg.apb_cfg);
       end
        
     if(e_cfg.has_virtual_sequencer)
       vseqrh=virtual_seqr::type_id::create("vseqrh",this);
        
     if(e_cfg.has_scoreboard)
       begin
         sbh =sb::type_id::create("sbh",this);
       end
  endfunction


//-----------Connect Phase-----------//
  function void env::connect_phase(uvm_phase phase);
     if(e_cfg.has_virtual_sequencer)
      begin
        if(e_cfg.has_ahb_magent)
          vseqrh.mseqrh=ahb_mtop.agt[0].mseqrh;
        if(e_cfg.has_ahb_sagent)
          vseqrh.sseqrh=ahb_stop.agt[0].sseqrh;
      end

     if(e_cfg.has_scoreboard)
       begin
         ahb_mtop.agt[0].mmonh.monitor_port.connect(sbh.fifo_mh.analysis_export);
         ahb_stop.agt[0].smonh.monitor_port.connect(sbh.fifo_sh.analysis_export);
      end
  endfunction
