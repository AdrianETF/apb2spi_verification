//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_env_top.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_ENV_TOP_SV
`define APB_UVC_ENV_TOP_SV

class apb_uvc_env_top extends uvm_env;
  
  // registration macro
  `uvm_component_utils(apb_uvc_env_top)

  // configuration reference
  apb_uvc_cfg_top m_cfg;
    
  // component instance
  apb_uvc_env m_apb_uvc_env;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : apb_uvc_env_top

// constructor
function apb_uvc_env_top::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb_uvc_env_top::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // get configuration
  if(!uvm_config_db #(apb_uvc_cfg_top)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // set configuration
  uvm_config_db#(apb_uvc_cfg)::set(this, "m_apb_uvc_env", "m_cfg", m_cfg.m_apb_uvc_cfg);

  // create component
  m_apb_uvc_env = apb_uvc_env::type_id::create("m_apb_uvc_env", this);
endfunction : build_phase

`endif // APB_UVC_ENV_TOP_SV
