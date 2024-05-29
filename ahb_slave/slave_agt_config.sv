class slave_agt_config extends uvm_object;

	`uvm_object_utils(slave_agt_config)

	virtual ahb_intf vif;
	uvm_active_passive_enum is_active;

	static int drv_data_count = 0;
  static int mon_data_count = 0;

	//Standard UVM Method
	extern function new(string name = "slave_agt_config");
endclass


//--------------- constructor -------------------//
	function slave_agt_config::new(string name = "slave_agt_config");
		super.new(name);
  endfunction
