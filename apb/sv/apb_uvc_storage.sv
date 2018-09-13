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

`ifndef APB_UVC_STORAGE_SV
`define APB_UVC_STORAGE_SV

class apb_uvc_storage extends uvm_component;
  
  // registration macro
  `uvm_component_utils(apb_uvc_storage)

  int mem[bit[31:0]];

  function void write(bit[31:0] addr, bit[31:0] value);
    mem[addr] = value;
  endfunction

  function bit[31:0] read(bit[31:0] addr);
    return (mem[addr]);
  endfunction
  
  // constructor    
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : apb_uvc_sequencer

// constructor
function apb_uvc_storage::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb_uvc_storage::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

`endif // APB_UVC_STORAGE_SV
