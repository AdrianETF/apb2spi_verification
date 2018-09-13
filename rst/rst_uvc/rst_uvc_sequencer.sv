
`ifndef RST_UVC_SEQUENCER_SV
`define RST_UVC_SEQUENCER_SV

class rst_uvc_sequencer extends uvm_sequencer #(rst_uvc_item);
  
  // registration macro
  `uvm_component_utils(rst_uvc_sequencer)
    
  // configuration reference
  rst_uvc_agent_cfg m_cfg;
  
  // constructor    
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : rst_uvc_sequencer

// constructor
function rst_uvc_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void rst_uvc_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

`endif // RST_UVC_SEQUENCER_SV
