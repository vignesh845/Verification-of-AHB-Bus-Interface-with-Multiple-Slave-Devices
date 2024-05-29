class test extends uvm_test;
   `uvm_component_utils(test)
   
   env_config m_cfg;
   env envh;
   virtual ahb_intf vif;
   
   master_agt_config ahb_mcfg[];
   slave_agt_config ahb_scfg[];
   
   int no_of_ahb_magents=1;
   int no_of_ahb_sagents=1;
   
   bit has_scoreboard=1;
   bit has_virtual_sequencer=1;
   bit has_coverage=1;
   
   extern function new(string name="test",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void end_of_elaboration_phase(uvm_phase phase);
endclass


//----------Constructor-----------//
  function test::new(string name="test",uvm_component parent);
     super.new(name,parent);
  endfunction


//-----------Build Phase----------//
  function void test::build_phase(uvm_phase phase);
     super.build_phase(phase);	

     envh = env::type_id::create("env", this);
     m_cfg = env_config::type_id::create("env_config", this);
    
     if(m_cfg.has_ahb_magent)
	begin
	m_cfg.ahb_mcfg=new[no_of_ahb_magents];
	end
	
     if(m_cfg.has_ahb_sagent)
	begin
	m_cfg.ahb_scfg=new[no_of_ahb_sagents];
	end
    
     ahb_mcfg=new[no_of_ahb_magents];
     ahb_scfg=new[no_of_ahb_sagents];
	
     foreach(ahb_scfg[i])
	begin
        ahb_scfg[i]=slave_agt_config::type_id::create($sformatf("ahb_scfg[%0d]",i));
        if(!uvm_config_db #(virtual ahb_intf)::get(this,"","vif",ahb_scfg[i].vif))
        `uvm_fatal("TEST","cannot get config data");

         ahb_scfg[i].is_active=UVM_ACTIVE;
         m_cfg.ahb_scfg[i]=ahb_scfg[i];
        end
	
     foreach(ahb_mcfg[i])
        begin
        ahb_mcfg[i]=master_agt_config::type_id::create($sformatf("ahb_mcfg[%0d]",i));
        if(!uvm_config_db #(virtual ahb_intf)::get(this,"","vif",ahb_mcfg[i].vif))
        `uvm_fatal("TEST","cannot get config data");

         ahb_mcfg[i].is_active=UVM_ACTIVE;
         m_cfg.ahb_mcfg[i]=ahb_mcfg[i];
        end
	
     m_cfg.no_of_ahb_magents=no_of_ahb_magents;
     m_cfg.no_of_ahb_sagents=no_of_ahb_sagents;
     m_cfg.has_scoreboard=has_scoreboard;
     m_cfg.has_coverage = has_coverage;
     m_cfg.has_virtual_sequencer=has_virtual_sequencer;	

     uvm_config_db#(env_config) ::set(this,"*","env_config",m_cfg);	
  endfunction


//-------------end_of_elaboration_phase------------------//
  function void test::end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     $display("\n                       ||*^*||");
     uvm_top.print_topology;
  endfunction





/////////////////3X73ND3D 7357 C4535\\\\\\\\\\\\\\\


/*~~~~~~~~~~~~~~~single transfer~~~~~~~~~~~~~~~~~*/
class single_test extends test;
   `uvm_component_utils(single_test)
   
    vsingle_seq ahb_seqh;

      extern function new(string name="single_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function single_test::new(string name="single_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void single_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task single_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=vsingle_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #100;
	phase.drop_objection(this);
endtask
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/





/*^^^^^^^^^^^^^ Unspecified Length ^^^^^^^^^^^^^^*/
class unspecified_test extends test;
   `uvm_component_utils(unspecified_test)
   
    vunspecified_seq ahb_seqh;

      extern function new(string name="unspecified_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function unspecified_test::new(string name="unspecified_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void unspecified_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task unspecified_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=vunspecified_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #100;
	phase.drop_objection(this);
endtask
/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/





/*::::::::::::::::; Wrapping 4 ;:::::::::::::::::*/
class wrap4_test extends test;
   `uvm_component_utils(wrap4_test)
   
    vwrap4_seq ahb_seqh;

      extern function new(string name="wrap4_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function wrap4_test::new(string name="wrap4_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void wrap4_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task wrap4_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=vwrap4_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #150;
	phase.drop_objection(this);
endtask
/*:::::::::::::::::::::::::::::::::::::::::::::::*/





/*M4N11M4N11M4N11M4N Increment 4 11M4N11M4N11M4N11*/
class incr4_test extends test;
   `uvm_component_utils(incr4_test)
   
    vincr4_seq ahb_seqh;

      extern function new(string name="incr4_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function incr4_test::new(string name="incr4_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void incr4_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task incr4_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=vincr4_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #300;
	phase.drop_objection(this);
endtask
/*M4N11M4N11M4N11M4N11M4N1M4N11M4N11M4N11M4N11M4N1*/





/*|_|-|_|-|_|-|_|-|_|-| Wrapping 8 |_|-|_|-|_|-|_|*/
class wrap8_test extends test;
   `uvm_component_utils(wrap8_test)
   
    vwrap8_seq ahb_seqh;

      extern function new(string name="wrap8_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function wrap8_test::new(string name="wrap8_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void wrap8_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task wrap8_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=vwrap8_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #50;
	phase.drop_objection(this);
endtask
/*|_|-|_|-|_|-|_|-|_|-|_|-|_|-|_|-|_|-|_|-|_|-|_|*/





/*""""""""""""""""" Increment 8 """"""""""""""""""*/
class incr8_test extends test;
   `uvm_component_utils(incr8_test)
   
    vincr8_seq ahb_seqh;

      extern function new(string name="incr8_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function incr8_test::new(string name="incr8_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void incr8_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task incr8_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=vincr8_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #100;
	phase.drop_objection(this);
endtask
/*"""""""""""""""""""""""""""""""""""""""""""""""*/






/*YYYYYYYYYYYYYYYYYY Wrapping 16 YYYYYYYYYYYYYYYY*/
class wrap16_test extends test;
   `uvm_component_utils(wrap16_test)
   
    vwrap16_seq ahb_seqh;

      extern function new(string name="wrap16_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function wrap16_test::new(string name="wrap16_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void wrap16_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task wrap16_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=vwrap16_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #50;
	phase.drop_objection(this);
endtask
/*YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY*/





/****************** Increment 16 *****************/
class incr16_test extends test;
   `uvm_component_utils(incr16_test)
   
    wincr16_seq ahb_seqh;

      extern function new(string name="incr16_test",uvm_component parent);
      extern function void build_phase(uvm_phase phase);
      extern task run_phase(uvm_phase phase);
endclass

function incr16_test::new(string name="incr16_test",uvm_component parent);
   super.new(name,parent);
endfunction

function void incr16_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction

task incr16_test::run_phase(uvm_phase phase);

   phase.raise_objection(this);
	ahb_seqh=wincr16_seq::type_id::create("ahb_seqh");
	ahb_seqh.start(envh.vseqrh);
  #50;
	phase.drop_objection(this);
endtask
/*************************************************/



