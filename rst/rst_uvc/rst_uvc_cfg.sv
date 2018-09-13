

`ifndef RST_UVC_CFG_SV
`define RST_UVC_CFG_SV

class rst_uvc_cfg extends uvm_object;
  
  // agents configurations
  rst_uvc_agent_cfg m_agent_cfg;
  
  // registration macro
  `uvm_object_utils_begin(rst_uvc_cfg)
    `uvm_field_object(m_agent_cfg, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "rst_uvc_cfg");
    
endclass : rst_uvc_cfg

// constructor
function rst_uvc_cfg::new(string name = "rst_uvc_cfg");
  super.new(name);
  // create agents configurations
  m_agent_cfg = rst_uvc_agent_cfg::type_id::create("m_agent_cfg");
endfunction : new

`endif // RST_UVC_CFG_SV
