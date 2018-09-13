//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_seq_lib.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_MASTER_SEQ_LIB_SV
`define SPI_UVC_MASTER_SEQ_LIB_SV

class spi_uvc_master_seq extends uvm_sequence #(spi_uvc_item);
  
  // registration macro
  `uvm_object_utils(spi_uvc_master_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(spi_uvc_sequencer)
  
  // fields
  rand bit[31:0] transmit_data;
  
  // constructor
  extern function new(string name = "spi_uvc_master_seq");
  // body task
  extern virtual task body();

endclass : spi_uvc_master_seq

// constructor
function spi_uvc_master_seq::new(string name = "spi_uvc_master_seq");
  super.new(name);
endfunction : new

// body task
task spi_uvc_master_seq::body();
  req = spi_uvc_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {
    shift_buffer_trans == transmit_data;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);
endtask : body

`endif // SPI_UVC_MASTER_SEQ_LIB_SV
