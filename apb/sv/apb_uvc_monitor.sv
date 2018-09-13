//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_monitor.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_MONITOR_SV
`define APB_UVC_MONITOR_SV

class apb_uvc_monitor extends uvm_monitor;
  
  // registration macro
  `uvm_component_utils(apb_uvc_monitor)
  
  // analysis port
  uvm_analysis_port #(apb_uvc_item) m_aport;
  
  // virtual interface reference
  virtual interface apb_uvc_if m_vif;
  
  // configuration reference
  apb_uvc_agent_cfg m_cfg;
  
  // monitor item
  apb_uvc_item m_item;

  //apb_uvc_storage m_storage;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // handle reset
  extern virtual task handle_reset();
  // collect item
  extern virtual task collect_item();
  // print item
  extern virtual function void print_item(apb_uvc_item item);

endclass : apb_uvc_monitor

// constructor
function apb_uvc_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb_uvc_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // create port
  m_aport = new("m_aport", this);
  
  // create item
  m_item = apb_uvc_item::type_id::create("m_item", this);
endfunction : build_phase

// connect phase
task apb_uvc_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  forever begin
    fork : run_phase_fork_block
      begin
        handle_reset();
      end
      begin
        collect_item();    
      end
    join_any // run_phase_fork_block
    disable fork;
  end
endtask : run_phase

// handle reset
task apb_uvc_monitor::handle_reset();

  // wait reset assertion
  @(m_vif.reset_n iff m_vif.reset_n == 0);

  `uvm_info(get_type_name(), "Reset asserted.", UVM_HIGH)

endtask : handle_reset

// collect item
task apb_uvc_monitor::collect_item();  

  // wait until reset is de-asserted
  wait (m_vif.reset_n == 1);

  `uvm_info(get_type_name(), "Reset de-asserted. Starting to collect items...", UVM_HIGH)
  
  forever begin    

    m_item.pready_delay = 0;

    @(m_vif.PENABLE == 0);

    @(posedge m_vif.clock iff m_vif.PENABLE == 1);

    forever begin
      if(m_vif.PREADY == 1) begin
        break;
      end
      else begin
        m_item.pready_delay++;
        @(posedge m_vif.clock);
      end
    end
    
    // collect item
    m_item.paddr         = m_vif.PADDR;
    m_item.pwdata        = m_vif.PWDATA;
    m_item.prdata        = m_vif.PRDATA;
    m_item.pwrite        = m_vif.PWRITE;
    m_item.pstrb         = m_vif.PSTRB;
    m_item.pslverr       = m_vif.PSLVERR;
    
    // print item
    print_item(m_item);
    
    // write analysis port
    m_aport.write(m_item);   
 
  end // forever begin  

endtask : collect_item

// print item
function void apb_uvc_monitor::print_item(apb_uvc_item item);
  `uvm_info(get_type_name(), $sformatf("Item collected: \n%s", item.sprint()), UVM_HIGH)
endfunction : print_item

`endif // APB_UVC_MONITOR_SV
