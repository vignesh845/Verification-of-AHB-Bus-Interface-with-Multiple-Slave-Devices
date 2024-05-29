module top;

	import pkg::*;
	import uvm_pkg::*; 
	`include "uvm_macros.svh"
   bit clock;

        initial
          begin
           clock = 1'b0;
             forever #10 clock = ~clock;
           end

        //interface instantiation
        ahb_intf vif(clock);
      //  rtl_top DUT(.hclk(vif.HCLK), .hreset(vif.HRESETn), .htrans(vif.HTRANS), .hsize(vif.HSIZE), .hwdata(vif.HWDATA), .haddr(vif.HADDR), .hwrite(vif.HWRITE), .hready(), .hresp(), .hrdata());


        rtl_top DUT(.hclk(vif.HCLK), .hreset(vif.HRESETn), .htrans(vif.HTRANS), .hsize(vif.HSIZE), .hwdata(vif.HWDATA), .haddr(vif.HADDR), .hwrite(vif.HWRITE), .hsel(), .hburst(), .hmastlock(), .hrdata(vif.HRDATA), .hresp(vif.HRESP), .hready(vif.HREADY));


        initial
          begin
          uvm_config_db#(virtual ahb_intf)::set(null, "*", "vif", vif);
          
          run_test();
        end
endmodule
