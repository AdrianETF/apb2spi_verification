
`ifndef RST_UVC_AGENT_CFG_SV
`define RST_UVC_AGENT_CFG_SV

class rst_uvc_agent_cfg extends uvm_object;
  
  // configuration fields
  uvm_active_passive_enum m_is_active = UVM_ACTIVE;
  bit m_has_monitor = 1;
  bit m_has_coverage = 1;
  
  // registration macro
  `uvm_object_utils_begin(rst_uvc_agent_cfg)
    `uvm_field_enum(uvm_active_passive_enum, m_is_active, UVM_ALL_ON)
    `uvm_field_int(m_has_monitor, UVM_ALL_ON)
    `uvm_field_int(m_has_coverage, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor   
  extern function new(string name = "rst_uvc_agent_cfg");
    
endclass : rst_uvc_agent_cfg

// constructor
function rst_uvc_agent_cfg::new(string name = "rst_uvc_agent_cfg");
  super.new(name);
endfunction : new

`endif // RST_UVC_AGENT_CFG_SV
