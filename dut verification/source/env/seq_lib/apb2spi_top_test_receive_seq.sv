//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_receive_seq.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_RECEIVE_SEQ_SV
`define APB2SPI_TOP_TEST_RECEIVE_SEQ_SV

class apb2spi_top_test_receive_seq extends apb2spi_top_base_virtual_seq;
  
  // registration macro
  `uvm_object_utils(apb2spi_top_test_receive_seq)
  
  // constructor
  extern function new(string name = "apb2spi_top_test_receive_seq");
  // body task
  extern virtual task body();    
  
endclass : apb2spi_top_test_receive_seq

// constructor
function apb2spi_top_test_receive_seq::new(string name = "apb2spi_top_test_receive_seq");
  super.new(name);
  
endfunction : new

// body task
task apb2spi_top_test_receive_seq::body();

  if(!apb_read_seq.randomize() with {
      paddr == SPI_DAT_ADDR;
    }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
     end
  apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);
  
endtask : body

`endif // apb2spi_top_test_receive_seq_SV
