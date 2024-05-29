class master_monitor extends uvm_monitor;
  `uvm_component_utils(master_monitor)
	
    virtual ahb_intf.MMON_MP vif;
    master_xtn xtnn;
    master_agt_config ahb_cfg;
    uvm_analysis_port #(master_xtn) monitor_port;
	
    extern function new (string name = "master_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_data();
    extern function void report_phase(uvm_phase phase);
endclass


//-----------Constructor----------//
  function master_monitor::new(string name="master_monitor",uvm_component parent);
     super.new (name, parent);
     monitor_port = new("monitor_port", this);
  endfunction


//-----------Build Phase---------//
  function void master_monitor::build_phase(uvm_phase phase);
     super.build_phase(phase);
       if(!uvm_config_db #(master_agt_config)::get(this, "", "master_agt_config", ahb_cfg))
       `uvm_fatal("CONFIG","Cannot get() m_cfg from uvm_config_db. Have you set it?")
  endfunction


//----------Connect Phase---------//
  function void master_monitor::connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     vif=ahb_cfg.vif; //configurations virtual handle is assigned to monitors virtual
  endfunction


//---------------------Run Phase-----------------------//
  task master_monitor::run_phase(uvm_phase phase);
   repeat(3) @(vif.mmon_cb);
   //with comment(unspecified,wrap,incr)    
   //without comment (single,unspecified transfer)
     forever
     begin
     collect_data();
     end
  endtask


//--------------------collect data---------------------//
  task master_monitor::collect_data();
     master_xtn xtnn;
	
        xtnn=master_xtn::type_id::create("master_xtn");
        //@(vif.mmon_cb);
        xtnn.HREADY=vif.mmon_cb.HREADY;
        xtnn.HTRANS=vif.mmon_cb.HTRANS;
        xtnn.HBURST=vif.mmon_cb.HBURST;
        xtnn.HSIZE=vif.mmon_cb.HSIZE;
        xtnn.HWRITE=vif.mmon_cb.HWRITE;
        xtnn.HWRITE=1'b0;
		xtnn.HADDR=vif.mmon_cb.HADDR;
		xtnn.HRESP=vif.mmon_cb.HRESP;
   @(vif.mmon_cb);
   while(!vif.mmon_cb.HREADY)
          @(vif.mmon_cb); 
          if(xtnn.HWRITE)
            xtnn.HWDATA=vif.mmon_cb.HWDATA;
          else
            xtnn.HRDATA=vif.mmon_cb.HRDATA;
            
          monitor_port.write(xtnn);
          `uvm_info("AHB MONITOR",$sformatf("Printing from monitor \n %s",xtnn.sprint()),UVM_LOW)
          ahb_cfg.mon_data_count++;
  endtask
  

//------------------- report phase ---------------------//
  function void master_monitor::report_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("Report:AHB_Monitor Collected %0d Transactions",ahb_cfg.mon_data_count), UVM_LOW)
  endfunction
 


