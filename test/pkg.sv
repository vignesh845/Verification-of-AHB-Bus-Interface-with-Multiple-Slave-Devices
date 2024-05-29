 package pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "master_agt_config.sv"
  `include "slave_agt_config.sv"
  `include "env_config.sv"

  `include "master_xtn.sv"
  `include "master_driver.sv"
  `include "master_monitor.sv"
  `include "master_seqr.sv"
  `include "master_agent.sv"
  `include "master_agt_top.sv"
  `include "master_seqs.sv"

  `include "slave_xtn.sv"
  `include "slave_driver.sv"
  `include "slave_monitor.sv"
  `include "slave_seqr.sv"
  `include "slave_agent.sv"
  `include "slave_agt_top.sv"
  `include "slave_seqs.sv"
 
  `include "virtual_seqr.sv"
  `include "virtual_seqs.sv"
  `include "sb.sv"
  `include "env.sv"
  `include "test.sv"
endpackage
