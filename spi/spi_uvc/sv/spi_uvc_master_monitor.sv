//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_monitor.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_MASTER_MONITOR_SV
`define SPI_UVC_MASTER_MONITOR_SV

class spi_uvc_master_monitor extends uvm_monitor;
  
  // registration macro
  `uvm_component_utils(spi_uvc_master_monitor)
  
  // analysis port
  uvm_analysis_port #(spi_uvc_item) m_aport;
  
  // virtual interface reference
  virtual interface spi_uvc_if m_vif;
  
  // configuration reference
  spi_uvc_agent_cfg m_cfg;
  
  // monitor item
  spi_uvc_item m_item;
  
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
  extern virtual function void print_item(spi_uvc_item item);

endclass : spi_uvc_master_monitor

// constructor
function spi_uvc_master_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void spi_uvc_master_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // create port
  m_aport = new("m_aport", this);
  
  // create item
  m_item = spi_uvc_item::type_id::create("m_item", this);
endfunction : build_phase

// connect phase
task spi_uvc_master_monitor::run_phase(uvm_phase phase);
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
task spi_uvc_master_monitor::handle_reset();
  // wait reset assertion
  @(m_vif.reset_n iff m_vif.reset_n == 0);
  `uvm_info(get_type_name(), "Reset asserted.", UVM_HIGH)
endtask : handle_reset

// collect item
task spi_uvc_master_monitor::collect_item();  
  // wait until reset is de-asserted
  wait (m_vif.reset_n == 1);
  `uvm_info(get_type_name(), "Reset de-asserted. Starting to collect items...", UVM_HIGH)
  forever begin    
    // wait signal change
    wait(m_vif.SS_N != 8'b11111111);
    `uvm_info(get_type_name(), $sformatf("Data size is : %d", m_cfg.data_size), UVM_LOW)
    // collect item
    for(int i = 0; i < m_cfg.data_size; i++) begin
      @(posedge m_vif.SCK);
      m_item.shift_buffer_rec[i] = m_vif.MISO;
      m_item.shift_buffer_trans[i] = m_vif.MOSI;
    end

    // wait signal change
    wait (m_vif.SS_N === 8'b11111111);
    
    // print item
    print_item(m_item);
    
    // write analysis port
    m_aport.write(m_item);    
  end // forever begin  
endtask : collect_item

// print item
function void spi_uvc_master_monitor::print_item(spi_uvc_item item);
  `uvm_info(get_type_name(), $sformatf("Item collected: \n%s", item.sprint()), UVM_HIGH)
endfunction : print_item

`endif // SPI_UVC_MASTER_MONITOR_SV
