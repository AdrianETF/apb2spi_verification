//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_pkg.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_PKG_SV
`define SPI_UVC_PKG_SV

`include "spi_uvc_if.sv"

package spi_uvc_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;



`include "spi_uvc_master_common.sv"
`include "spi_uvc_agent_cfg.sv"
`include "spi_uvc_cfg.sv"
`include "spi_uvc_item.sv"
`include "spi_uvc_master_driver.sv"
`include "spi_uvc_sequencer.sv"
`include "spi_uvc_master_monitor.sv"
`include "spi_uvc_master_cov.sv"
`include "spi_uvc_master_agent.sv"

//`include "spi_uvc_slave_driver.sv"
//`include "spi_uvc_slave_monitor.sv"
//`include "spi_uvc_slave_cov.sv"
//`include "spi_uvc_slave_agent.sv"
//`include "spi_uvc_seq_lib.sv"

`include "spi_uvc_env.sv"
`include "spi_uvc_master_seq_lib.sv"
//`include "spi_uvc_seq_lib.sv"

endpackage : spi_uvc_pkg

`endif // SPI_UVC_PKG_SV
