//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_cfg_top.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_CFG_TOP_SV
`define APB2SPI_TOP_CFG_TOP_SV

class apb2spi_top_cfg_top extends uvm_object;

  // standard fields
  bit m_is_active;
  bit m_has_apb_uvc;
  bit m_has_spi_uvc;
  bit m_has_rst_uvc;
  bit m_has_scb;
  bit m_has_checkers;
  bit m_has_coverage;

  // UVCs' configurations
  apb_uvc_cfg m_apb_uvc_cfg;
  spi_uvc_cfg m_spi_uvc_cfg;
  rst_uvc_cfg m_rst_uvc_cfg;
  
  // registration macro  
  `uvm_object_utils_begin(apb2spi_top_cfg_top)
    `uvm_field_int(m_is_active, UVM_ALL_ON)
    `uvm_field_int(m_has_apb_uvc, UVM_ALL_ON)
    `uvm_field_int(m_has_spi_uvc, UVM_ALL_ON)
    `uvm_field_int(m_has_rst_uvc, UVM_ALL_ON)
    `uvm_field_int(m_has_scb, UVM_ALL_ON)
    `uvm_field_int(m_has_checkers, UVM_ALL_ON)
    `uvm_field_int(m_has_coverage, UVM_ALL_ON)
    `uvm_field_object(m_apb_uvc_cfg, UVM_ALL_ON)
    `uvm_field_object(m_spi_uvc_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor
  extern function new(string name = "apb2spi_top_cfg_top");

endclass : apb2spi_top_cfg_top

// constructor
function apb2spi_top_cfg_top::new(string name = "apb2spi_top_cfg_top");
  super.new(name);
  
  // set default values for standard fields
  m_is_active = 1;
  m_has_apb_uvc = 1;
  m_has_spi_uvc = 1;
  m_has_rst_uvc = 1;
  m_has_scb = 1;
  m_has_checkers = 1;
  m_has_coverage = 1;

  // create UVCs' configurations
  m_apb_uvc_cfg = apb_uvc_cfg::type_id::create("m_apb_uvc_cfg");
  m_spi_uvc_cfg = spi_uvc_cfg::type_id::create("m_spi_uvc_cfg");
  m_rst_uvc_cfg = rst_uvc_cfg::type_id::create("m_rst_uvc_cfg");
endfunction : new

`endif // APB2SPI_TOP_CFG_TOP_SV
