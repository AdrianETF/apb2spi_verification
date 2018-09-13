//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_ctrl0_config_seq.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_CTRL0_CONGIG_SEQ_SV
`define APB2SPI_TOP_TEST_CTRL0_CONGIG_SEQ_SV

class apb2spi_top_test_ctrl0_config_seq extends apb2spi_top_base_virtual_seq;
  
  // registration macro
  `uvm_object_utils(apb2spi_top_test_ctrl0_config_seq)

  rand bit[7:0]  ctrl0_WMRK;
  rand bit       ctrl0_FLUSHR;
  rand bit       ctrl0_FLUSHT;
  rand bit       ctrl0_ADPTBUF;
  rand bit       ctrl0_ENCBUF;
  rand bit       ctrl0_DPACK;
  rand bit[4:0]  ctrl0_DSIZ;
  rand bit       ctrl0_DORD;
  rand bit[1:0]  ctrl0_DIR;
  rand bit       ctrl0_CPHA;
  rand bit       ctrl0_CPOL;
  rand bit       ctrl0_MS;
  rand bit       ctrl0_SPIEN;

  constraint ctrl0_c {
     soft ctrl0_WMRK == 8'b0;
     soft ctrl0_FLUSHR == 1'b0;
     soft ctrl0_FLUSHT == 1'b0;
     soft ctrl0_ADPTBUF == 1'b0;
     soft ctrl0_ENCBUF == 1'b1;
     soft ctrl0_DPACK == 1'b0;
     soft ctrl0_DSIZ > 2;
     soft ctrl0_DIR inside {[1:2]};
     soft ctrl0_CPHA == 1'b0;
     soft ctrl0_CPOL == 1'b0;
     soft ctrl0_MS == 1'b1;
  }
  
  // constructor
  extern function new(string name = "apb2spi_top_test_ctrl0_config_seq");
  // body task
  extern virtual task body();    
  
endclass : apb2spi_top_test_ctrl0_config_seq

// constructor
function apb2spi_top_test_ctrl0_config_seq::new(string name = "apb2spi_top_test_ctrl0_config_seq");
  super.new(name);
  
endfunction : new

// body task
task apb2spi_top_test_ctrl0_config_seq::body();

  if(!apb_write_seq.randomize() with {
      paddr  == SPI_CTRL0_ADDR;
      pwdata == {ctrl0_WMRK, 4'b0, ctrl0_FLUSHR, ctrl0_FLUSHT, ctrl0_ADPTBUF, ctrl0_ENCBUF, 2'b0, ctrl0_DPACK, ctrl0_DSIZ, 1'b0, ctrl0_DORD, ctrl0_DIR, ctrl0_CPHA, ctrl0_CPOL, ctrl0_MS, ctrl0_SPIEN};
      pstrb  == 4'hf;
   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

endtask : body

`endif // APB2SPI_TOP_TEST_DEFAULT_CONGIG_SEQ_SV
