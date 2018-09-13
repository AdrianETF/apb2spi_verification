//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_slave_driver.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_SLAVE_DRIVER_SV
`define APB_UVC_SLAVE_DRIVER_SV

class apb_uvc_slave_driver extends uvm_driver #(apb_uvc_item);
  
  // registration macro
  `uvm_component_utils(apb_uvc_slave_driver)
  
  // virtual interface reference
  virtual interface apb_uvc_if m_vif;
  
  // configuration reference
  apb_uvc_agent_cfg m_cfg;
  
  // request item
  REQ m_req;
   
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // process item
  extern virtual task process_item(apb_uvc_item item);

endclass : apb_uvc_slave_driver

// constructor
function apb_uvc_slave_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb_uvc_slave_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

// run phase
task apb_uvc_slave_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);

  // init signals
  m_vif.PRDATA <= 32'b0;
  m_vif.PREADY <= 1'b0;
  m_vif.PSLVERR <= 1'b0;
  
  forever begin
    seq_item_port.get_next_item(m_req);
    process_item(m_req);
    seq_item_port.item_done();
  end
endtask : run_phase

// process item
task apb_uvc_slave_driver::process_item(apb_uvc_item item);
  // print item
  `uvm_info(get_type_name(), $sformatf("Item to be driven: \n%s", item.sprint()), UVM_HIGH)
  
  // wait until reset is de-asserted
  wait (m_vif.reset_n == 1);
  
  // drive signals
  @(posedge m_vif.PENABLE);
  m_vif.PREADY <= 0;
  for(int i = 0; i < item.pready_delay; i++) begin
    @(posedge m_vif.clock);
  end
  m_vif.PRDATA <= item.prdata;
  m_vif.PREADY <= 1'b1;
  m_vif.PSLVERR <= item.pslverr;
endtask : process_item

`endif // APB_UVC_SLAVE_DRIVER_SV
