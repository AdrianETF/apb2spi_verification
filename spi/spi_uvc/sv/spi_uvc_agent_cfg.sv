//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_agent_cfg.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_AGENT_CFG_SV
`define SPI_UVC_AGENT_CFG_SV

class spi_uvc_agent_cfg extends uvm_object;
  
  // configuration fields
  uvm_active_passive_enum m_is_active = UVM_ACTIVE;
  bit m_has_coverage;  

  rand bit[5:0] data_size;
  rand bit[3:0] clk_gap;
  rand bit[15:0] clock_multiplier;
  rand bit[2:0] ssinsel;

  constraint data_size_c { data_size > 3; data_size <= 32; }
  constraint clk_gap_c { clk_gap > 0; }
  constraint clock_multiplier_c { clock_multiplier > 0; }
  
  // registration macro
  `uvm_object_utils_begin(spi_uvc_agent_cfg)
    `uvm_field_enum(uvm_active_passive_enum, m_is_active, UVM_ALL_ON)
    `uvm_field_int(m_has_coverage, UVM_ALL_ON)
    `uvm_field_int(data_size, UVM_ALL_ON)
    `uvm_field_int(clk_gap, UVM_ALL_ON)
    `uvm_field_int(ssinsel, UVM_ALL_ON)
    `uvm_field_int(clock_multiplier, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "spi_uvc_agent_cfg");
    
endclass : spi_uvc_agent_cfg

// constructor
function spi_uvc_agent_cfg::new(string name = "spi_uvc_agent_cfg");
  super.new(name);
endfunction : new

`endif // SPI_UVC_AGENT_CFG_SV
