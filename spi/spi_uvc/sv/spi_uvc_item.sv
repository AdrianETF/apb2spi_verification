//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_item.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_ITEM_SV
`define SPI_UVC_ITEM_SV

class spi_uvc_item extends uvm_sequence_item;
  
  // item fields
  
  rand bit[31:0] shift_buffer_rec;
  rand bit[31:0] shift_buffer_trans;
  
  // registration macro    
  `uvm_object_utils_begin(spi_uvc_item)
    `uvm_field_int(shift_buffer_rec,   UVM_ALL_ON)
    `uvm_field_int(shift_buffer_trans,   UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constraints
  
  // constructor  
  extern function new(string name = "spi_uvc_item");
  
endclass : spi_uvc_item

// constructor
function spi_uvc_item::new(string name = "spi_uvc_item");
  super.new(name);
endfunction : new

`endif // SPI_UVC_ITEM_SV
