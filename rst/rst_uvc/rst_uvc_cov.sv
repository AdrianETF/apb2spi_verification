
`ifndef RST_UVC_COV_SV
`define RST_UVC_COV_SV

class rst_uvc_cov extends uvm_subscriber #(rst_uvc_item);
  
  // registration macro
  `uvm_component_utils(rst_uvc_cov)
  
  // configuration reference
  rst_uvc_agent_cfg m_cfg;
  
  // coverage fields 
  rst_uvc_item m_item;
  
  // coverage groups
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(rst_uvc_item t);

endclass : rst_uvc_cov

// constructor
function rst_uvc_cov::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// analysis implementation port function
function void rst_uvc_cov::write(rst_uvc_item t);
  m_item = t;
endfunction : write

`endif // RST_UVC_COV_SV
