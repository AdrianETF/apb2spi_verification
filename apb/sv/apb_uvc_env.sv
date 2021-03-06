//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_env.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_ENV_SV
`define APB_UVC_ENV_SV

class apb_uvc_env extends uvm_env;
  
  // registration macro
  `uvm_component_utils(apb_uvc_env)
  
  // configuration instance
  apb_uvc_cfg m_cfg;

  // analysis port
  uvm_analysis_port #(apb_uvc_item) m_aport;
    
  // virtual interface reference
  virtual interface apb_uvc_if m_vif;

  // agents instances
  apb_uvc_master_agent m_master_agent;
  apb_uvc_slave_agent m_slave_agent;

  // components instances
  apb_uvc_monitor m_monitor;
  apb_uvc_cov m_cov;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // connect phase
  extern virtual function void connect_phase(uvm_phase phase);
  
endclass : apb_uvc_env

// constructor
function apb_uvc_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb_uvc_env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  m_aport = new("m_aport", this);

  // get interface
  if(!uvm_config_db#(virtual apb_uvc_if)::get(this, "", "m_vif", m_vif)) begin
    `uvm_fatal(get_type_name(), "Failed to get virtual interface from config DB!")
  end

  // get configuration
  if(!uvm_config_db #(apb_uvc_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  if (m_cfg.m_has_monitor == 1) begin
    m_monitor = apb_uvc_monitor::type_id::create("m_monitor", this);
  end
  if (m_cfg.m_has_coverage == 1) begin
    m_cov = apb_uvc_cov::type_id::create("m_cov", this);
  end  
  
  // set agents configurations
  uvm_config_db#(apb_uvc_agent_cfg)::set(this, "m_master_agent", "m_cfg", m_cfg.m_master_agent_cfg);
  uvm_config_db#(apb_uvc_agent_cfg)::set(this, "m_slave_agent", "m_cfg", m_cfg.m_slave_agent_cfg);  

  // create agents
  m_master_agent = apb_uvc_master_agent::type_id::create("m_master_agent", this);
  if (m_cfg.m_has_two_agents == 1) begin
    m_slave_agent = apb_uvc_slave_agent::type_id::create("m_slave_agent", this);
  end
endfunction : build_phase

// connect phase
function void apb_uvc_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  // connect ports
  if (m_cfg.m_has_monitor == 1) begin
    m_monitor.m_aport.connect(m_aport);
  end
  if (m_cfg.m_has_coverage == 1) begin
    m_monitor.m_aport.connect(m_cov.analysis_export);
  end
  
  // assign interface
  if (m_cfg.m_has_monitor == 1) begin 
    m_monitor.m_vif = m_vif;
  end
  
endfunction : connect_phase

`endif // APB_UVC_ENV_SV
