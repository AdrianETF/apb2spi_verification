//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_register_write_seq.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_REGISTER_WRITE_SEQ_SV
`define APB2SPI_TOP_TEST_REGISTER_WRITE_SEQ_SV

class apb2spi_top_test_register_write_seq extends apb2spi_top_base_virtual_seq;
  
  // registration macro
  `uvm_object_utils(apb2spi_top_test_register_write_seq)

  rand bit[31:0] paddr;
  rand bit[31:0] pwdata;
  rand bit[3:0]  pstrb;

  constraint paddr_c {
    soft paddr inside {SPI_CAP_ADDR, SPI_CTRL0_ADDR, SPI_CTRL1_ADDR, SPI_STAT0_ADDR, SPI_DAT_ADDR, SPI_CPSR_ADDR};
  }

  constraint pstrb_c {
    soft pstrb inside {[1:4], 8, 12, 15};
  }
  
  // constructor
  extern function new(string name = "apb2spi_top_test_register_write_seq");
  // body task
  extern virtual task body();    
  
endclass : apb2spi_top_test_register_write_seq

// constructor
function apb2spi_top_test_register_write_seq::new(string name = "apb2spi_top_test_register_write_seq");
  super.new(name);
  
endfunction : new

// body task
task apb2spi_top_test_register_write_seq::body();

  if(!apb_write_seq.randomize() with {
      paddr == local::paddr;
      pwdata == local::pwdata;
      pstrb == local::pstrb;
    }) begin
        `uvm_fatal(get_type_name(), "Failed to randomize.")
     end
  apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);
  
endtask : body

`endif // APB2SPI_TOP_TEST_REGISTER_WRITE_SEQ_SV
