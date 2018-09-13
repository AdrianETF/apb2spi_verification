//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_virtual_sequencer.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_VIRTUAL_SEQUENCER_SV
`define APB2SPI_TOP_VIRTUAL_SEQUENCER_SV

class apb2spi_top_virtual_sequencer extends uvm_sequencer;

  // registration macro
  `uvm_component_utils(apb2spi_top_virtual_sequencer)
  
  // configuration reference
  apb2spi_top_cfg_top m_cfg;
  
  // register model reference
  // ...

  // UVCs sequencers' references
  apb_uvc_sequencer m_apb_uvc_sequencer;
  spi_uvc_sequencer m_spi_uvc_sequencer;
  rst_uvc_sequencer m_rst_uvc_sequencer;
 
  // constructor
  extern function new(string name, uvm_component parent);

endclass : apb2spi_top_virtual_sequencer

// constructor
function apb2spi_top_virtual_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

`endif // APB2SPI_TOP_VIRTUAL_SEQUENCER_SV
