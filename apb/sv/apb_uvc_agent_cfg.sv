//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File apb  : apb_uvc_agent_cfg.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_AGENT_CFG_SV
`define APB_UVC_AGENT_CFG_SV

class apb_uvc_agent_cfg extends uvm_object;
  
  // configuration fields
  uvm_active_passive_enum m_is_active = UVM_ACTIVE;
  
  // registration macro
  `uvm_object_utils_begin(apb_uvc_agent_cfg)
    `uvm_field_enum(uvm_active_passive_enum, m_is_active, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "apb_uvc_agent_cfg");
    
endclass : apb_uvc_agent_cfg

// constructor
function apb_uvc_agent_cfg::new(string name = "apb_uvc_agent_cfg");
  super.new(name);
endfunction : new

`endif // APB_UVC_AGENT_CFG_SV
