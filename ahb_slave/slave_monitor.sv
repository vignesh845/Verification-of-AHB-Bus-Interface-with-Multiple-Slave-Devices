class slave_monitor extends uvm_monitor;
  `uvm_component_utils(slave_monitor)
	
    virtual ahb_intf.SMON_MP vif;
    slave_xtn xtnn;
    slave_agt_config ahb_cfg;
    uvm_analysis_port #(slave_xtn) monitor_port;
	
    extern function new (string name = "slave_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_data();
    extern function void report_phase(uvm_phase phase);
endclass


//-----------Constructor----------//
  function slave_monitor::new(string name="slave_monitor",uvm_component parent);
     super.new (name, parent);
     monitor_port = new("monitor_port", this);
  endfunction


//-----------Build Phase---------//
  function void slave_monitor::build_phase(uvm_phase phase);
     super.build_phase(phase);
       if(!uvm_config_db #(slave_agt_config)::get(this, "", "slave_agt_config", ahb_cfg))
       `uvm_fatal("CONFIG","Cannot get() m_cfg from uvm_config_db. Have you set it?")
  endfunction


//----------Connect Phase---------//
  function void slave_monitor::connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     vif=ahb_cfg.vif; //configurations virtual handle is assigned to monitors virtual
  endfunction


//---------------------Run Phase-----------------------//
  task slave_monitor::run_phase(uvm_phase phase);
   repeat(3) @(vif.smon_cb);
   //with comment(unspecified,wrap,incr)    
   //without comment (single,unspecified transfer)
     forever
     begin
     collect_data();
     end
  endtask


//--------------------collect data---------------------//
  task slave_monitor::collect_data();
     slave_xtn xtnn;
	
        xtnn=slave_xtn::type_id::create("slave_xtn");
        //@(vif.smon_cb);
        xtnn.HADDR=vif.smon_cb.HADDR;
       // xtnn.HWRITE<=vif.smon_cb.HWRITE;
       
        xtnn.HWRITE=1'b0;
	
		xtnn.HREADY=vif.smon_cb.HREADY;
  xtnn.HRESP=vif.smon_cb.HRESP;
 @(vif.smon_cb);
 while(!vif.smon_cb.HREADY & !vif.smon_cb.HSEL)
          @(vif.smon_cb); 
          if(xtnn.HWRITE==1'b0)
            xtnn.HRDATA=vif.smon_cb.HRDATA;
          else
            xtnn.HWDATA=vif.smon_cb.HWDATA;
            
          monitor_port.write(xtnn);
          `uvm_info("AHB MONITOR",$sformatf("Printing from monitor \n %s",xtnn.sprint()),UVM_LOW)
          ahb_cfg.mon_data_count++;
  endtask
  

//------------------- report phase ---------------------//
  function void slave_monitor::report_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("Report:AHB_Monitor Collected %0d Transactions",ahb_cfg.mon_data_count), UVM_LOW)
  endfunction
