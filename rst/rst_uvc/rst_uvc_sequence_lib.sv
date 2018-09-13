
`ifndef RST_UVC_MASTER_SEQ_LIB_SV
`define RST_UVC_MASTER_SEQ_LIB_SV

class rst_uvc_master_seq extends uvm_sequence #(rst_uvc_item);
  
  // registration macro
  `uvm_object_utils(rst_uvc_master_seq)
  
  // sequencer pointer macro
  `uvm_declare_p_sequencer(rst_uvc_sequencer)

  rand int rst_delay;

  constraint delay_c {
    soft rst_delay >= 0; 
    soft rst_delay < 50;
  }

  // constructor
  extern function new(string name = "rst_uvc_master_seq");
  // body task
  extern virtual task body();

endclass : rst_uvc_master_seq

// constructor
function rst_uvc_master_seq::new(string name = "rst_uvc_master_seq");
  super.new(name);
endfunction : new

// body task
task rst_uvc_master_seq::body();
  req = rst_uvc_item::type_id::create("req");
  
  start_item(req);
  
  if(!req.randomize() with {
     rst_delay == local::rst_delay;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end  
  
  finish_item(req);
endtask : body

`endif // RST_UVC_MASTER_SEQ_LIB_SV
