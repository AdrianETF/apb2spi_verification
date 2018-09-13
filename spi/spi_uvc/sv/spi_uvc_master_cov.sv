//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_cov.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_MASTER_COV_SV
`define SPI_UVC_MASTER_COV_SV

class spi_uvc_master_cov extends uvm_subscriber #(spi_uvc_item);
  
  // registration macro
  `uvm_component_utils(spi_uvc_master_cov)
  
  // configuration reference
  spi_uvc_agent_cfg m_cfg;
  
  // coverage fields 
  spi_uvc_item m_item;
  
  // coverage groups
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(spi_uvc_item t);

endclass : spi_uvc_master_cov

// constructor
function spi_uvc_master_cov::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// analysis implementation port function
function void spi_uvc_master_cov::write(spi_uvc_item t);
  m_item = t;
endfunction : write

`endif // SPI_UVC_MASTER_COV_SV
