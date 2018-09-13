//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_driver.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_MASTER_DRIVER_SV
`define SPI_UVC_MASTER_DRIVER_SV

class spi_uvc_master_driver extends uvm_driver #(spi_uvc_item);
  
  // registration macro
  `uvm_component_utils(spi_uvc_master_driver)
  
  // virtual interface reference
  virtual interface spi_uvc_if m_vif;
  
  // configuration reference
  spi_uvc_agent_cfg m_cfg;
  
  // request item
  REQ m_req;
   
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // process item
  extern virtual task process_item(spi_uvc_item item);
  // clock generator
  extern virtual task drive_clock(spi_uvc_item item);

endclass : spi_uvc_master_driver

// constructor
function spi_uvc_master_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void spi_uvc_master_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task spi_uvc_master_driver::drive_clock(spi_uvc_item item);
  wait (m_vif.reset_n == 1);
  for(int i = 0; i < m_cfg.clk_gap; i++) begin
    @(posedge m_vif.clock);
  end
  m_vif.SCK <= 1'b0;
  forever begin
    for(int i = 1; i < m_cfg.clock_multiplier; i++) begin
      @(posedge m_vif.clock);
    end
    m_vif.SCK <= !m_vif.SCK;
  end
endtask : drive_clock

// run phase
task spi_uvc_master_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);

  // init signals
  m_vif.MOSI    <= 1'bZ;
  m_vif.SCK     <= 1'bZ;
  m_vif.SS_N    <= 8'bZZZZZZZZ;
  
  forever begin
    seq_item_port.get_next_item(m_req);
    fork
      begin
        drive_clock(m_req);
      end
      begin
        process_item(m_req);
      end
    join_any
    disable fork;
    /*for(int i = 0; i < SCK_PERIOD; i++) begin
      @(posedge m_vif.clock);
    end*/
    m_vif.SS_N <= 8'b11111111;
    seq_item_port.item_done();
  end
endtask : run_phase

// process item
task spi_uvc_master_driver::process_item(spi_uvc_item item);
  // print item
  `uvm_info(get_type_name(), $sformatf("Item to be driven: \n%s", item.sprint()), UVM_HIGH)
  
  // wait until reset is de-asserted
  wait (m_vif.reset_n == 1);
`uvm_info(get_type_name(), $sformatf("CLK GAP %h", m_cfg.clk_gap), UVM_LOW)
  // delay transaction
  for(int i = 0; i < m_cfg.clk_gap; i++) begin
    @(posedge m_vif.clock);
  end

  // drive signals
  m_vif.SS_N <= ~(8'b1 << (m_cfg.ssinsel));
  m_vif.MOSI <= item.shift_buffer_trans[0];
  //@(negedge m_vif.SCK);
  for(int i = 1; i < m_cfg.data_size; i++) begin
    @(negedge m_vif.SCK);
    m_vif.MOSI <= item.shift_buffer_trans[i];
  end
  @(negedge m_vif.SCK);
  m_vif.SS_N <= 8'b11111111;
endtask : process_item

`endif // SPI_UVC_MASTER_DRIVER_SV
