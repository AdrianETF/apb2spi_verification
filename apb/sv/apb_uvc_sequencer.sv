//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_sequencer.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_SEQUENCER_SV
`define APB_UVC_SEQUENCER_SV

class apb_uvc_sequencer extends uvm_sequencer #(apb_uvc_item);
  
  // registration macro
  `uvm_component_utils(apb_uvc_sequencer)
    
  // configuration reference
  apb_uvc_agent_cfg m_cfg;
  
  // constructor    
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : apb_uvc_sequencer

// constructor
function apb_uvc_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb_uvc_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

`endif // APB_UVC_SEQUENCER_SV
