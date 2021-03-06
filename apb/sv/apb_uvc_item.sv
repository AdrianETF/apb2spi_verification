//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_item.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_ITEM_SV
`define APB_UVC_ITEM_SV

class apb_uvc_item extends uvm_sequence_item;
  
  // item fields
  rand bit[31:0] paddr;
  rand bit[31:0] pwdata;
  rand bit[31:0] prdata;
  rand bit       pwrite;
  rand int       pready_delay;
  rand int       ptrans_delay;
  rand bit[3:0]  pstrb;
  rand bit       pslverr;
  
  // registration macro    
  `uvm_object_utils_begin(apb_uvc_item)
    `uvm_field_int(paddr, UVM_ALL_ON)
    `uvm_field_int(pwdata, UVM_ALL_ON)
    `uvm_field_int(prdata, UVM_ALL_ON)
    `uvm_field_int(pwrite, UVM_ALL_ON)
    `uvm_field_int(pready_delay, UVM_ALL_ON)
    `uvm_field_int(ptrans_delay, UVM_ALL_ON)
    `uvm_field_int(pstrb, UVM_ALL_ON)
    `uvm_field_int(pslverr, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constraints
  constraint pready_delay_c {
    soft pready_delay >= 0; pready_delay <= 30;
  }
  
  // constructor  
  extern function new(string name = "apb_uvc_item");
  
endclass : apb_uvc_item

// constructor
function apb_uvc_item::new(string name = "apb_uvc_item");
  super.new(name);
endfunction : new

`endif // APB_UVC_ITEM_SV
