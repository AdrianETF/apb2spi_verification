//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_test_pkg.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_TEST_PKG_SV
`define APB2SPI_TOP_TEST_PKG_SV

package test_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVCs' packages
import apb_uvc_pkg::*;
import spi_uvc_pkg::*;
import rst_uvc_pkg::*;

// import env package
import env_top_pkg::*;

// include tests
`include "test_apb2spi_top_base.sv"
`include "test_apb2spi_top_example.sv"
`include "test_apb2spi_top_receive_test.sv"
`include "test_apb2spi_top_receive_flush_test.sv"
`include "test_apb2spi_top_transmit_flush_test.sv"
`include "test_apb2spi_top_transmit_test.sv"
`include "test_apb2spi_top_registers_test.sv"
`include "test_apb2spi_top_registers_reset.sv"
`include "test_apb2spi_top_SPIEN_test.sv"
endpackage : test_pkg

`endif // APB2SPI_TOP_TEST_PKG_SV
