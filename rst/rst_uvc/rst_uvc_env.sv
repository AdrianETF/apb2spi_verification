

`ifndef RST_UVC_ENV_SV
`define RST_UVC_ENV_SV

class rst_uvc_env extends uvm_env;
  
  // registration macro
  `uvm_component_utils(rst_uvc_env)
  
  // configuration instance
  rst_uvc_cfg m_cfg;
    
  // virtual interface reference
  virtual interface rst_uvc_if m_vif;

  // agents instances
  rst_uvc_agent m_agent;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // connect phase
  extern virtual function void connect_phase(uvm_phase phase);
  
endclass : rst_uvc_env

// constructor
function rst_uvc_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void rst_uvc_env::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // get interface
  if(!uvm_config_db#(virtual rst_uvc_if)::get(this, "", "m_vif", m_vif)) begin
    `uvm_fatal(get_type_name(), "Failed to get virtual interface from config DB!")
  end

  // get configuration
  if(!uvm_config_db #(rst_uvc_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end
  
  // set agents configurations
  uvm_config_db#(rst_uvc_agent_cfg)::set(this, "m_agent", "m_cfg", m_cfg.m_agent_cfg);

  // create agents
  m_agent = rst_uvc_agent::type_id::create("m_agent", this);
endfunction : build_phase

// connect phase
function void rst_uvc_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);  
endfunction : connect_phase

`endif // RST_UVC_ENV_SV
