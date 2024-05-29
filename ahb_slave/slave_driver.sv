class slave_driver extends uvm_driver#(slave_xtn);
   `uvm_component_utils(slave_driver)
 
     virtual ahb_intf.SDRV_MP vif;
     slave_xtn xtn;
     slave_agt_config ahb_cfg;
	
     extern function new(string name = "slave_driver", uvm_component parent);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     extern task run_phase (uvm_phase phase);
     extern task send_to_dut(slave_xtn xtn);
     extern function void report_phase(uvm_phase phase);
endclass


//-----------Constructor----------//
  function slave_driver::new (string name = "slave_driver", uvm_component parent);
     super.new (name, parent);
  endfunction


//-----------Build Phase---------//
  function void slave_driver::build_phase (uvm_phase phase);
     super.build_phase(phase);
	if(!uvm_config_db #(slave_agt_config)::get(this, "", "slave_agt_config", ahb_cfg))
	`uvm_fatal("CONFIG","Cannot get() m_cfg from uvm_config_db. Have you set it?")
  endfunction


//----------Connect Phase---------//
  function void slave_driver::connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      vif=ahb_cfg.vif;
  endfunction


//--------------------------Run Phase--------------------------//
  task slave_driver::run_phase(uvm_phase phase);
      @(vif.sdrv_cb);
      vif.sdrv_cb.HRESETn <= 1'b0;
      @(vif.sdrv_cb);
      vif.sdrv_cb.HRESETn <= 1'b1;
	forever 
	begin
    seq_item_port.get_next_item(req);
	  send_to_dut(req);
	  seq_item_port.item_done();
	end
  endtask
 

//------------------send to dut---------------------//
  task slave_driver::send_to_dut(slave_xtn xtn);
     
   
      //vif.sdrv_cb.HREADY<=xtn.HREADY;
     // vif.sdrv_cb.HTRANS<=xtn.HTRANS;
     // vif.sdrv_cb.HBURST<=xtn.HBURST;
     // vif.sdrv_cb.HSIZE<=xtn.HSIZE;
     // vif.sdrv_cb.HWRITE<=xtn.HWRITE;
     // vif.sdrv_cb.HADDR<=xtn.HADDR;
      //vif.sdrv_cb.HWDATA<=xtn.HWDATA;
      vif.sdrv_cb.HRESP<=xtn.HRESP;
      @(vif.sdrv_cb);
      while(!vif.sdrv_cb.HREADY & !vif.sdrv_cb.HSEL)
     @(vif.sdrv_cb);
       if(xtn.HWRITE==1'b0) //replace xtn by vif.sdrv_cb ((Sampling of clocking block output signal is not allowed))
         begin
           vif.sdrv_cb.HRDATA <= {$urandom};
         end
       else	
         begin
           vif.sdrv_cb.HRDATA <= 32'h0;
         end
     `uvm_info("AHB SLAVE DRIVER",$sformatf("Printing from slave driver \n %s",xtn.sprint()),UVM_LOW)
         $display("*****************FROM SLAVE DRIVER WRITE IS DONE **********************");
     ahb_cfg.drv_data_count++;
  endtask


//----------------------- report phase ---------------------//
  function void slave_driver::report_phase (uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report:AHB_DRIVER sent %0d transaction",ahb_cfg.drv_data_count),UVM_LOW)
  endfunction

