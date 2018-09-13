//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_pkg.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_PKG_SV
`define APB_UVC_PKG_SV

`include "apb_uvc_if.sv"

package apb_uvc_pkg;

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "apb_uvc_common.sv"
`include "apb_uvc_agent_cfg.sv"
`include "apb_uvc_cfg.sv"
`include "apb_uvc_item.sv"
`include "apb_uvc_master_driver.sv"
`include "apb_uvc_slave_driver.sv"
`include "apb_uvc_sequencer.sv"
`include "apb_uvc_monitor.sv"
`include "apb_uvc_cov.sv"
`include "apb_uvc_master_agent.sv"
`include "apb_uvc_slave_agent.sv"
`include "apb_uvc_env.sv"
`include "apb_uvc_master_seq_lib.sv"
`include "apb_uvc_slave_seq_lib.sv"

endpackage : apb_uvc_pkg

`endif // APB_UVC_PKG_SV
