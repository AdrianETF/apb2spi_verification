//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_master_driver.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_MASTER_DRIVER_SV
`define APB_UVC_MASTER_DRIVER_SV

class apb_uvc_master_driver extends uvm_driver #(apb_uvc_item);
  
  // registration macro
  `uvm_component_utils(apb_uvc_master_driver)
  
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
  // handle reset
  extern virtual task handle_reset();

endclass : apb_uvc_master_driver

// constructor
function apb_uvc_master_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb_uvc_master_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

// run phase
task apb_uvc_master_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);

  // init signals
  m_vif.PADDR <= 32'b0;
  m_vif.PWDATA <= 32'b0;
  m_vif.PWRITE <= 0;
  m_vif.PSEL <= 0;
  m_vif.PENABLE <= 0;
  m_vif.PSTRB <= 4'b0;
  
  forever begin
    seq_item_port.get_next_item(m_req);
    fork
      begin
        process_item(m_req);
      end
      begin
        handle_reset();
      end
    join_any
    disable fork;
    m_vif.PSEL <= 1'b0;
    m_vif.PENABLE <= 1'b0;
    wait (m_vif.reset_n == 1);
    seq_item_port.item_done();
  end
endtask : run_phase

// handle reset
task apb_uvc_master_driver::handle_reset();
  // wait reset assertion
  @(m_vif.reset_n iff m_vif.reset_n == 0);
  `uvm_info(get_type_name(), "Reset asserted.", UVM_HIGH)
endtask : handle_reset

// process item
task apb_uvc_master_driver::process_item(apb_uvc_item item);
  // print item
  `uvm_info(get_type_name(), $sformatf("Item to be driven: \n%s", item.sprint()), UVM_HIGH)
  
  // wait until reset is de-asserted
  wait (m_vif.reset_n == 1);
  
  // drive signals
  for(int i = 0; i < item.ptrans_delay; i++) begin
    @(posedge m_vif.clock);
  end

  m_vif.PADDR <= item.paddr;
  m_vif.PWRITE <= item.pwrite;
  m_vif.PSTRB <= item.pstrb;
  m_vif.PSEL <= 1'b1;

  if(item.pwrite == 1'b1) begin
    m_vif.PWDATA <= item.pwdata;
  end

  @(posedge m_vif.clock);
  m_vif.PENABLE <= 1'b1;

  @(posedge m_vif.clock iff m_vif.PREADY == 1);
  m_vif.PENABLE <= 1'b0;
  m_vif.PSEL <= 1'b0;

endtask : process_item

`endif // APB_UVC_MASTER_DRIVER_SV
