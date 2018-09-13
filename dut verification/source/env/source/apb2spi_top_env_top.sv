//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_env_top.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_ENV_TOP_SV
`define APB2SPI_TOP_ENV_TOP_SV

class apb2spi_top_env_top extends uvm_env;
  
  // registration macro
  `uvm_component_utils(apb2spi_top_env_top)
  
  // configuration reference
  apb2spi_top_cfg_top m_cfg;
  
  // UVCs
  apb_uvc_env m_apb_uvc;
  spi_uvc_env m_spi_uvc;
  rst_uvc_env m_rst_uvc;

  // monitor
  // ...

  // scoreboard
  apb2spi_top_scb m_scb;

  // virtual sequencer
  apb2spi_top_virtual_sequencer m_virtual_sequencer;

  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // connect phase
  extern virtual function void connect_phase(uvm_phase phase);

endclass : apb2spi_top_env_top

// constructor
function apb2spi_top_env_top::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void apb2spi_top_env_top::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // get configuration
  if (!uvm_config_db #(apb2spi_top_cfg_top)::get(this, "", "m_cfg", m_cfg)) begin
    `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
  end
  
  // set UVCs' configurations
  if (m_cfg.m_has_apb_uvc == 1) begin
    uvm_config_db #(apb_uvc_cfg)::set(this, "m_apb_uvc", "m_cfg", m_cfg.m_apb_uvc_cfg);
  end
  if (m_cfg.m_has_spi_uvc == 1) begin
    uvm_config_db #(spi_uvc_cfg)::set(this, "m_spi_uvc", "m_cfg", m_cfg.m_spi_uvc_cfg);
  end
  if (m_cfg.m_has_rst_uvc == 1) begin
    uvm_config_db #(rst_uvc_cfg)::set(this, "m_rst_uvc", "m_cfg", m_cfg.m_rst_uvc_cfg);
  end
  
  // create UVCs
  if (m_cfg.m_has_apb_uvc == 1) begin
    m_apb_uvc = apb_uvc_env::type_id::create("m_apb_uvc", this);
  end
  if (m_cfg.m_has_spi_uvc == 1) begin
    m_spi_uvc = spi_uvc_env::type_id::create("m_spi_uvc", this);
  end
  if (m_cfg.m_has_rst_uvc == 1) begin
    m_rst_uvc = rst_uvc_env::type_id::create("m_rst_uvc", this);
  end

  // create register model components
  // ...

  // create monitor
  // ...
  
  // create scoreboard
  if (m_cfg.m_has_scb == 1) begin
    m_scb = apb2spi_top_scb::type_id::create("m_scb", this);
  end

  // create virtual sequencer
  m_virtual_sequencer = apb2spi_top_virtual_sequencer::type_id::create("m_virtual_sequencer", this);  
endfunction : build_phase

// connect phase
function void apb2spi_top_env_top::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  // connect monitor and UVCs
  // ...

  // connect scoreboard and UVCs
  if (m_cfg.m_has_scb == 1 && m_cfg.m_has_apb_uvc == 1) begin
    //m_apb_uvc.m_master_agent.m_monitor.m_aport.connect(m_scb.m_apb_uvc_aexport);
    m_apb_uvc.m_monitor.m_aport.connect(m_scb.m_apb_uvc_aexport);
  end
  if (m_cfg.m_has_scb == 1 && m_cfg.m_has_spi_uvc == 1) begin
    m_spi_uvc.m_master_agent.m_monitor.m_aport.connect(m_scb.m_spi_uvc_aexport);
  end
  if (m_cfg.m_has_scb == 1 && m_cfg.m_has_rst_uvc == 1) begin
    m_rst_uvc.m_agent.m_monitor.m_aport.connect(m_scb.m_rst_uvc_aexport);
  end

  // connect sequencers in virtual sequencer
  if (m_cfg.m_has_apb_uvc == 1) begin
    m_virtual_sequencer.m_apb_uvc_sequencer = m_apb_uvc.m_master_agent.m_sequencer;
  end
  if (m_cfg.m_has_spi_uvc == 1) begin
    m_virtual_sequencer.m_spi_uvc_sequencer = m_spi_uvc.m_master_agent.m_sequencer;
  end
  if (m_cfg.m_has_rst_uvc == 1) begin
    m_virtual_sequencer.m_rst_uvc_sequencer = m_rst_uvc.m_agent.m_sequencer;
  end

  // connect monitor references
  // ...

  // connect scoreboard references
  if (m_cfg.m_has_scb == 1) begin
    m_scb.m_cfg = m_cfg;
  end

  // connect virtual sequencer references
  m_virtual_sequencer.m_cfg = m_cfg;
endfunction : connect_phase

`endif // APB2SPI_TOP_ENV_TOP_SV
