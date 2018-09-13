//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_env.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_ENV_SV
`define SPI_UVC_ENV_SV

class spi_uvc_env extends uvm_env;
  
  // registration macro
  `uvm_component_utils(spi_uvc_env)  
  
  // configuration instance
  spi_uvc_cfg m_cfg;  

  // agent instance
  spi_uvc_master_agent m_master_agent;
  //spi_uvc_slave_agent m_slave_agent;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  
endclass : spi_uvc_env

// constructor
function spi_uvc_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void spi_uvc_env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // get configuration
  if(!uvm_config_db #(spi_uvc_cfg)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end

  // create agent
  if(m_cfg.has_master == 1) begin
    m_master_agent = spi_uvc_master_agent::type_id::create("m_master_agent", this);

    // set agent configuration
    uvm_config_db#(spi_uvc_agent_cfg)::set(this, "m_master_agent", "m_cfg", m_cfg.m_master_agent_cfg);
  end

  if(m_cfg.has_slave == 1) begin
    //m_slave_agent = spi_uvc_slave_agent::type_id::create("m_slave_agent", this);

    // set agent configuration
    uvm_config_db#(spi_uvc_agent_cfg)::set(this, "m_slave_agent", "m_cfg", m_cfg.m_slave_agent_cfg);
  end

endfunction : build_phase

`endif // SPI_UVC_ENV_SV
