//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_master_seq_lib.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_MASTER_SEQ_LIB_SV
`define APB_UVC_MASTER_SEQ_LIB_SV

class apb_uvc_master_seq extends uvm_sequence #(apb_uvc_item);
  
  // registration macro
  `uvm_object_utils(apb_uvc_master_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(apb_uvc_sequencer)
  
  // fields
  rand bit[31:0] paddr;
  rand bit[31:0] pwdata;
  rand bit       pwrite;
  rand bit[3:0]  pstrb;
  rand int       ptrans_delay;
  
  // constraints
  constraint trans_delay_c {
    soft ptrans_delay >= 0; ptrans_delay < 30;
  }

  constraint strobe_order {
    solve pwrite before pstrb;
  }
  
  constraint pstrb_c {
    soft (pwrite == 1) -> pstrb inside {[1:4], 8, 12, 15};
    soft (pwrite == 0) -> pstrb == 4'b0;
  }
  
  // constructor
  extern function new(string name = "apb_uvc_master_seq");
  // body task
  extern virtual task body();

endclass : apb_uvc_master_seq

// constructor
function apb_uvc_master_seq::new(string name = "apb_uvc_master_seq");
  super.new(name);
endfunction : new

// body task
task apb_uvc_master_seq::body();
  req = apb_uvc_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {
    paddr == local::paddr;
    pwdata == local::pwdata;
    pwrite == local::pwrite;
    pstrb == local::pstrb;
    ptrans_delay == local::ptrans_delay;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);
endtask : body

class apb_uvc_master_write_seq extends uvm_sequence #(apb_uvc_item);
  
  // registration macro
  `uvm_object_utils(apb_uvc_master_write_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(apb_uvc_sequencer)
  
  // fields

  rand bit[31:0] paddr;
  rand bit[31:0] pwdata;
  rand bit[3:0]  pstrb;
  rand int       ptrans_delay;
  
  // constraints
  
  constraint trans_delay_c {
    soft ptrans_delay >= 0; ptrans_delay < 30;
  }

  constraint pstrb_c {
    soft pstrb inside {[1:4], 8, 12, 15};
  }

  // constructor
  extern function new(string name = "apb_uvc_master_write_seq");
  // body task
  extern virtual task body();

endclass : apb_uvc_master_write_seq

// constructor
function apb_uvc_master_write_seq::new(string name = "apb_uvc_master_write_seq");
  super.new(name);
endfunction : new

// body task
task apb_uvc_master_write_seq::body();
  req = apb_uvc_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {
    paddr == local::paddr;
    pwdata == local::pwdata;
    pwrite == 1;
    pstrb == local::pstrb;
    ptrans_delay == local::ptrans_delay;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);
endtask : body

class apb_uvc_master_read_seq extends uvm_sequence #(apb_uvc_item);
  
  // registration macro
  `uvm_object_utils(apb_uvc_master_read_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(apb_uvc_sequencer)
  
  // fields
  rand bit[31:0] paddr;
  rand bit[31:0] pwdata;
  rand int       ptrans_delay;
  
  // constraints
  constraint trans_delay_c {
    soft ptrans_delay >= 0; ptrans_delay < 30;
  }

  // constructor
  extern function new(string name = "apb_uvc_master_read_seq");
  // body task
  extern virtual task body();

endclass : apb_uvc_master_read_seq

// constructor
function apb_uvc_master_read_seq::new(string name = "apb_uvc_master_read_seq");
  super.new(name);
endfunction : new

// body task
task apb_uvc_master_read_seq::body();
  req = apb_uvc_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {
    paddr == local::paddr;
    pwdata == local::pwdata;
    pwrite == 0;
    pstrb == 4'b0;
    ptrans_delay == local::ptrans_delay;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);
endtask : body

`endif // APB_UVC_MASTER_SEQ_LIB_SV
