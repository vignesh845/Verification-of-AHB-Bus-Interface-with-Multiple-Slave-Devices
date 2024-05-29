class sb extends uvm_scoreboard;
   `uvm_component_utils(sb)
   
   uvm_tlm_analysis_fifo #(master_xtn)fifo_mh;
   uvm_tlm_analysis_fifo #(slave_xtn)fifo_sh;
  
   env_config e_cfg;
   master_xtn mxtn;
   slave_xtn sxtn;
   
   
   extern function new(string name="sb",uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern function void check();
endclass

   master_xtn mxtn;
   slave_xtn sxtn;
   bit [31:0] ahb_maddr[$];
   bit [31:0] ahb_mdata_write[$];
   bit [31:0] ahb_mdata_read[$];
   
   bit [31:0] ahb_saddr[$];
   bit [31:0] ahb_sdata_write[$];
   bit [31:0] ahb_sdata_read[$];
   
   /*//////////////////// Constructor \\\\\\\\\\\\\\\\*/
   function sb::new(string name="sb",uvm_component parent);
	    super.new(name,parent);
 
      fifo_mh=new("fifo_mh",this);
      fifo_sh=new("fifo_sh",this);
      
      mxtn=new();
      sxtn=new();
   endfunction
/*\\\\\\\\\\\\\\\\\\\\\\//////////////////////////*/

/*""""""""""""""""""" Build_Phase '''''''''''''''''*/
   function void sb::build_phase(uvm_phase phase);
     super.build_phase(phase);
       if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
       `uvm_fatal("SB","cannot get config data");
   
   endfunction
/*'''''''''''''''''''''''"""""""""""""""""""""""""*/
/*[][][][][][][][][][ Run_Phase )()()()()()()()()()*/
   task sb::run_phase(uvm_phase phase);
   
   fork
   `uvm_info("SB","Inside run phase",UVM_LOW)
   
    begin
    forever
      begin
        fifo_mh.get(mxtn);    
        ahb_maddr.push_back(mxtn.HADDR);
        ahb_mdata_write.push_back(mxtn.HWDATA);
        ahb_mdata_read.push_back(mxtn.HRDATA);

      end
    end
    
    begin
    forever
      begin
        fifo_sh.get(sxtn);
        ahb_saddr.push_back(sxtn.HADDR);
        ahb_sdata_write.push_back(sxtn.HWDATA);
        ahb_sdata_read.push_back(sxtn.HRDATA);

      end
     end
   join
   check();
   endtask
/*()()()()()()()()()()()()[][][][][][][][][][][][]*/



/*+++++++++++++++++++++ Check ---------------------*/
 function void sb::check();
  
  mxtn.HADDR = ahb_maddr.pop_back();
  mxtn.HWDATA = ahb_mdata_write.pop_back();
  mxtn.HRDATA = ahb_mdata_read.pop_back();
  sxtn.HADDR = ahb_saddr.pop_back();
  sxtn.HWDATA = ahb_sdata_write.pop_back();
  sxtn.HRDATA = ahb_sdata_read.pop_back();

  // Compare data
  if (mxtn.HWDATA == sxtn.HWDATA) begin
    $display("DATA_MATCHED", $sformatf("Data matched: master HWDATA=%h, slave HWDATA=%h", mxtn.HWDATA, sxtn.HWDATA));
  end
  else begin
    $display("DATA_MISMATCHED", $sformatf("Data mismatched: master HWDATA=%h, slave HWDATA=%h", mxtn.HWDATA, sxtn.HWDATA));
  end

  if (mxtn.HRDATA == sxtn.HRDATA) begin
    $display("DATA_MATCHED", $sformatf("Data matched: master HRDATA=%h, slave HRDATA=%h", mxtn.HRDATA, sxtn.HRDATA));
  end
  else begin
    $display("DATA_MISMATCHED", $sformatf("Data mismatched: master HRDATA=%h, slave HRDATA=%h", mxtn.HRDATA, sxtn.HRDATA));
  end

  if (mxtn.HADDR == sxtn.HADDR) begin
    $display("ADDR_MATCHED", $sformatf("Address matched: master HADDR=%h, slave HADDR=%h", mxtn.HADDR, sxtn.HADDR));
  end
  else begin
    $display("DATA_MISMATCHED", $sformatf("Data mismatched: master HADDR=%h, slave HADDR=%h", mxtn.HADDR, sxtn.HADDR));
  end

endfunction
