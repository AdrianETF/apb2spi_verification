//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_cfg_top.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_CFG_TOP_SV
`define SPI_UVC_CFG_TOP_SV

class spi_uvc_cfg_top extends uvm_object;
    
  // UVC configuration
  spi_uvc_cfg m_spi_uvc_cfg;
  
  // registration macro
  `uvm_object_utils_begin(spi_uvc_cfg_top)
    `uvm_field_object(m_spi_uvc_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
    
  // constructor
  extern function new(string name = "spi_uvc_cfg_top");
  
endclass : spi_uvc_cfg_top

// constructor
function spi_uvc_cfg_top::new(string name = "spi_uvc_cfg_top");
  super.new(name);
  
  // create UVC configuration
  m_spi_uvc_cfg = spi_uvc_cfg::type_id::create("m_spi_uvc_cfg");
endfunction : new

`endif // SPI_UVC_CFG_TOP_SV
