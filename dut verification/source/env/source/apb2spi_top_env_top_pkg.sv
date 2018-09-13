//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_env_top_pkg.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_ENV_TOP_PKG_SV
`define APB2SPI_TOP_ENV_TOP_PKG_SV

package env_top_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

// import UVCs' packages
import apb_uvc_pkg::*;
import spi_uvc_pkg::*;
import rst_uvc_pkg::*;

// include env files
`include "apb2spi_top_common.sv"
`include "apb2spi_register_model.sv"
`include "apb2spi_top_cfg_top.sv"
`include "apb2spi_top_scb.sv"
`include "apb2spi_top_virtual_sequencer.sv"
`include "apb2spi_top_env_top.sv"
`include "apb2spi_top_virtual_seq_lib.sv"

endpackage : env_top_pkg

`endif // APB2SPI_TOP_ENV_TOP_PKG_SV
