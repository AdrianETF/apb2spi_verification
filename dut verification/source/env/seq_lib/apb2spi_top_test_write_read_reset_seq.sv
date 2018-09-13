//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_write_read_reset_seq.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_WRITE_READ_RESET_SEQ_SV
`define APB2SPI_TOP_TEST_WRITE_READ_RESET_SEQ_SV

class apb2spi_top_test_write_read_reset_seq extends apb2spi_top_base_virtual_seq;
  
  // registration macro
  `uvm_object_utils(apb2spi_top_test_write_read_reset_seq)
  
  // constructor
  extern function new(string name = "apb2spi_top_test_write_read_reset_seq");
  // body task
  extern virtual task body();    
  
endclass : apb2spi_top_test_write_read_reset_seq

// constructor
function apb2spi_top_test_write_read_reset_seq::new(string name = "apb2spi_top_test_write_read_reset_seq");
  super.new(name);
  
endfunction : new

// body task
task apb2spi_top_test_write_read_reset_seq::body();

  if(!apb_read_seq.randomize() with {
      paddr == 32'h0;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h04;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h08;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h0C;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h10;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);
  
  if(!apb_read_seq.randomize() with {
      paddr == 32'h14;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_write_seq.randomize() with {
      paddr == 32'h14;
      pstrb  == 8'hf;
      pwdata == 32'h00020001;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_write_seq.randomize() with {
      paddr  == 8;
      pwdata == 32'h000030ff;
      pstrb  == 8'hf;
   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_write_seq.randomize() with {
      paddr  == 4;
      pwdata == 32'h00010c53;
      pstrb  == 8'hf;
   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_write_seq.randomize() with {
      paddr == 32'h0;
      pstrb  == 8'hf;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_write_seq.randomize() with {
      paddr  == 32'hC;
      pstrb  == 8'hf;
   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_write_seq.randomize() with {
      paddr  == 32'h10;
      pstrb  == 8'hf;
   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h0;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h04;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h08;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h0C;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

  if(!apb_read_seq.randomize() with {
      paddr == 32'h10;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);
  
  if(!apb_read_seq.randomize() with {
      paddr == 32'h14;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_read_seq.start(p_sequencer.m_apb_uvc_sequencer);

endtask : body

`endif // APB2SPI_TOP_TEST_WRITE_READ_RESET_SEQ_SV
