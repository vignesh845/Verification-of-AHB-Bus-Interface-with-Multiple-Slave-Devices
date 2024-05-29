class master_driver extends uvm_driver#(master_xtn);
   `uvm_component_utils(master_driver)
 
     virtual ahb_intf.MDRV_MP vif;
     master_xtn xtn;
     master_agt_config ahb_cfg;
	
     extern function new(string name = "master_driver", uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     extern task run_phase (uvm_phase phase);
     extern task send_to_dut(master_xtn xtn);
     extern function void report_phase(uvm_phase phase);
endclass


//-----------Constructor----------//
  function master_driver::new (string name = "master_driver", uvm_component parent);
     super.new (name, parent);
  endfunction


//-----------Build Phase---------//
  function void master_driver::build_phase (uvm_phase phase);
     super.build_phase(phase);
	if(!uvm_config_db #(master_agt_config)::get(this, "", "master_agt_config", ahb_cfg))
	`uvm_fatal("CONFIG","Cannot get() m_cfg from uvm_config_db. Have you set it?")
  endfunction


//----------Connect Phase---------//
  function void master_driver::connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      vif=ahb_cfg.vif;
  endfunction


//--------------------------Run Phase--------------------------//
  task master_driver::run_phase(uvm_phase phase);
      @(vif.mdrv_cb);
      vif.mdrv_cb.HRESETn <= 1'b0;
      @(vif.mdrv_cb);
      vif.mdrv_cb.HRESETn <= 1'b1;
	forever 
	begin
    seq_item_port.get_next_item(req);
	  send_to_dut(req);
	  seq_item_port.item_done();
	end
  endtask
 

//------------------send to dut---------------------//
  task master_driver::send_to_dut(master_xtn xtn);
     
      vif.mdrv_cb.HTRANS<=xtn.HTRANS;
      vif.mdrv_cb.HBURST<=xtn.HBURST;
	  vif.mdrv_cb.HSIZE<=xtn.HSIZE;
      vif.mdrv_cb.HWRITE<=xtn.HWRITE;
      vif.mdrv_cb.HADDR<=xtn.HADDR;
      //vif.mdrv_cb.HREADY<=1'b1;
      //vif.mdrv_cb.HRESP<=xtn.HRESP;
      @(vif.mdrv_cb);
      while(!vif.mdrv_cb.HREADY)
     @(vif.mdrv_cb);
       if(xtn.HWRITE) //replace xtn by vif.mdrv_cb ((Sampling of clocking block output signal is not allowed))
         vif.mdrv_cb.HWDATA <= xtn.HWDATA;
       else	
         vif.mdrv_cb.HWDATA <= 32'h0;
         
     `uvm_info("AHB DRIVER",$sformatf("Printing from driver \n %s",xtn.sprint()),UVM_LOW)
         $display("*****************FROM DRIVER WRITE IS DONE **********************");
     ahb_cfg.drv_data_count++;
  endtask


//----------------------- report phase ---------------------//
  function void master_driver::report_phase (uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report:AHB_DRIVER sent %0d transaction",ahb_cfg.drv_data_count),UVM_LOW)
  endfunction

