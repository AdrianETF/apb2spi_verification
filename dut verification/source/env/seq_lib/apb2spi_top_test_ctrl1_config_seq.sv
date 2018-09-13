//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_ctrl1_config_seq.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_CTRL1_CONGIG_SEQ_SV
`define APB2SPI_TOP_TEST_CTRL1_CONGIG_SEQ_SV

class apb2spi_top_test_ctrl1_config_seq extends apb2spi_top_base_virtual_seq;
  
  // registration macro
  `uvm_object_utils(apb2spi_top_test_ctrl1_config_seq)

  rand bit[7:0]  ctrl1_SSSV;
  rand bit[3:0]  ctrl1_SSCG;
  rand bit[2:0]  ctrl1_SSINSEL;
  rand bit       ctrl1_SSSM;
  rand bit[7:0]  ctrl1_SSEN;

  constraint ctrl1_c {
     soft ctrl1_SSSV == 8'b0;
     soft ctrl1_SSSM == 1'b0;
     //soft ctrl1_SSEN == 8'b11111111;
  }

  constraint sscg_c {
     soft ctrl1_SSCG > 0;
  }
  
  // constructor
  extern function new(string name = "apb2spi_top_test_ctrl1_config_seq");
  // body task
  extern virtual task body();    
  
endclass : apb2spi_top_test_ctrl1_config_seq

// constructor
function apb2spi_top_test_ctrl1_config_seq::new(string name = "apb2spi_top_test_ctrl1_config_seq");
  super.new(name);
  
endfunction : new

// body task
task apb2spi_top_test_ctrl1_config_seq::body();

  if(!apb_write_seq.randomize() with {
      paddr  == SPI_CTRL1_ADDR;
      pwdata == {8'b0, ctrl1_SSSV, ctrl1_SSCG, ctrl1_SSINSEL, ctrl1_SSSM, ctrl1_SSEN};
      pstrb  == 8'hf;
   }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    apb_write_seq.start(p_sequencer.m_apb_uvc_sequencer);

endtask : body

`endif // APB2SPI_TOP_TEST_DEFAULT_CONGIG_SEQ_SV
