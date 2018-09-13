//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_env_top_pkg.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_ENV_TOP_PKG_SV
`define SPI_UVC_ENV_TOP_PKG_SV

package spi_uvc_env_top_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVC's packages
import spi_uvc_pkg::*;

// include env files
`include "spi_uvc_cfg_top.sv"
`include "spi_uvc_env_top.sv"

endpackage : spi_uvc_env_top_pkg

`endif // SPI_UVC_ENV_TOP_PKG_SV
