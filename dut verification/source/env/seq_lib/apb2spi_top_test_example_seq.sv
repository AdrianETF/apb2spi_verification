//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_example_seq.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_EXAMPLE_SEQ_SV
`define APB2SPI_TOP_TEST_EXAMPLE_SEQ_SV

class apb2spi_top_test_example_seq extends apb2spi_top_base_virtual_seq;
  
  // registration macro
  `uvm_object_utils(apb2spi_top_test_example_seq)
  
  // constructor
  extern function new(string name = "apb2spi_top_test_example_seq");
  // body task
  extern virtual task body();    
  
endclass : apb2spi_top_test_example_seq

// constructor
function apb2spi_top_test_example_seq::new(string name = "apb2spi_top_test_example_seq");
  super.new(name);
  
endfunction : new

// body task
task apb2spi_top_test_example_seq::body();
  
  for(int i = 0; i < 3;  i++) begin
    if(!apb_write_seq.randomize() with {
        paddr == 32'h10;
        pwdata == 32'h2f2f3ff3;
        pstrb  == 15;
      }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
      end
      apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);
  end

  if(!spi_seq.randomize() with {

   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
  spi_seq.start(p_sequencer.m_spi_uvc_sequencer);

  if(!spi_seq.randomize() with {

   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
  spi_seq.start(p_sequencer.m_spi_uvc_sequencer);

  if(!spi_seq.randomize() with {

   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
  spi_seq.start(p_sequencer.m_spi_uvc_sequencer);

endtask : body

`endif // APB2SPI_TOP_TEST_EXAMPLE_SEQ_SV
