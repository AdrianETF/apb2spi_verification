//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_tb_top.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_TB_TOP_SV
`define SPI_UVC_TB_TOP_SV

// define timescale
`timescale 1ns/1ns

module spi_uvc_tb_top;
  
  `include "uvm_macros.svh"  
  import uvm_pkg::*;
  
  // import test package
  import spi_uvc_test_pkg::*;
      
  // signals
  reg reset_n;
  reg clock;
  
  // UVC interface instance
  spi_uvc_if spi_uvc_if_inst(clock, reset_n);
  
  // DUT instance
  //dut_dummy dut (
    //.reset_n(reset_n),
    //.clock(clock)
  //);
  
  // configure UVC's virtual interface in DB
  initial begin : config_if_block
    uvm_config_db#(virtual spi_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_spi_uvc_env_top.m_spi_uvc_env.m_master_agent", "m_vif", spi_uvc_if_inst);
   uvm_config_db#(virtual spi_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_spi_uvc_env_top.m_spi_uvc_env.m_slave_agent", "m_vif", spi_uvc_if_inst);
    uvm_config_db#(virtual spi_uvc_if)::set(uvm_root::get(), "uvm_test_top.m_spi_uvc_env_top.m_spi_uvc_env", "m_vif", spi_uvc_if_inst);
  end
    
  // define initial clock value and generate reset
  initial begin : clock_and_rst_init_block
    reset_n <= 1'b0;
    clock <= 1'b1;
    #501 reset_n <= 1'b1;
  end
  
  // generate clock
  always begin : clock_gen_block
    #50 clock <= ~clock;
  end
  
  // run test
  initial begin : run_test_block
    run_test();
  end
  
endmodule : spi_uvc_tb_top

`endif // SPI_UVC_TB_TOP_SV
