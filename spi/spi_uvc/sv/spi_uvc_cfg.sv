//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_cfg.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_CFG_SV
`define SPI_UVC_CFG_SV

class spi_uvc_cfg extends uvm_object;

  bit has_master;
  bit has_slave;
  bit has_score_board;
  bit has_coverage;
  
  // agent configuration
  spi_uvc_agent_cfg m_master_agent_cfg;
  spi_uvc_agent_cfg m_slave_agent_cfg;
  
  // registration macro
  `uvm_object_utils_begin(spi_uvc_cfg)
    `uvm_field_int(has_master, UVM_ALL_ON) 
    `uvm_field_int(has_slave, UVM_ALL_ON) 
    `uvm_field_int(has_score_board, UVM_ALL_ON) 
    `uvm_field_int(has_coverage, UVM_ALL_ON) 
    `uvm_field_object(m_master_agent_cfg, UVM_ALL_ON)
    `uvm_field_object(m_slave_agent_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "spi_uvc_cfg");
    
endclass : spi_uvc_cfg

// constructor
function spi_uvc_cfg::new(string name = "spi_uvc_cfg");
  super.new(name);

  has_master = 1;
  has_slave = 0;
  
  // create agent configuration
  m_master_agent_cfg = spi_uvc_agent_cfg::type_id::create("m_agent_cfg");
endfunction : new

`endif // SPI_UVC_CFG_SV
