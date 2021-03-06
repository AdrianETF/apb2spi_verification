//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_slave_seq_lib.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_SLAVE_SEQ_LIB_SV
`define APB_UVC_SLAVE_SEQ_LIB_SV

class apb_uvc_slave_seq extends uvm_sequence #(apb_uvc_item);
  
  apb_uvc_item m_item;

  // registration macro
  `uvm_object_utils(apb_uvc_slave_seq)

  // sequencer pointer macro JEL OVO TREBA???
  `uvm_declare_p_sequencer(apb_uvc_sequencer)

  //fields
  //rand bit[31:0] paddr;
  //rand bit[31:0] pwdata;
  rand bit[31:0] prdata;
  //rand bit       pready;
  //rand bit       pwrite;
  rand int       pready_delay;
  //rand bit       psel;
  //rand bit       penable;
  //rand bit[3:0]  pstrb;
  //rand bit       pslverr;

  constraint pready_delay_c {
     soft pready_delay >= 0; pready_delay < 10;
  }
 
  // constructor
  extern function new(string name = "apb_uvc_slave_seq");
  // body task
  extern virtual task body();

endclass : apb_uvc_slave_seq

// constructor
function apb_uvc_slave_seq::new(string name = "apb_uvc_slave_seq");
  super.new(name);
endfunction : new

// body task
task apb_uvc_slave_seq::body();
  //`uvm_info(get_type_name(), "Sequence apb_uvc_slave_seq", UVM_HIGH)  
  forever begin
    req = apb_uvc_item::type_id::create("req");

    start_item(req);

    if(!req.randomize() with {
      //prdata == local::prdata;
      //pready_delay == local::pready_delay;
      //pslverr == local::pslverr;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end

    finish_item(req);
  end
endtask : body

`endif // APB_UVC_SLAVE_SEQ_LIB_SV
