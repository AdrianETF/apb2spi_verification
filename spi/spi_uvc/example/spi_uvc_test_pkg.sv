//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_test_pkg.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_TEST_PKG_SV
`define SPI_UVC_TEST_PKG_SV

package spi_uvc_test_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import spi_uvc_pkg::*;

// import env package
import spi_uvc_env_top_pkg::*;

// include tests
`include "test_spi_uvc_base.sv"
`include "test_spi_uvc_example.sv"

endpackage : spi_uvc_test_pkg

`endif // SPI_UVC_TEST_PKG_SV
