//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_apb2spi_top_base.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TEST_APB2SPI_TOP_BASE_SV
`define TEST_APB2SPI_TOP_BASE_SV

class test_apb2spi_top_base extends uvm_test;
  
  // registration macro
  `uvm_component_utils(test_apb2spi_top_base)
  
  // component instance
  apb2spi_top_env_top m_env;
  
  // configuration instance
  apb2spi_top_cfg_top m_cfg;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // end of elaboration phase
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  // set default configuration
  extern virtual function void set_default_configuration();
     
endclass : test_apb2spi_top_base

// constructor
function test_apb2spi_top_base::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
  
// build_phase
function void test_apb2spi_top_base::build_phase(uvm_phase phase);    
  super.build_phase(phase);    
  
  // create component
  m_env = apb2spi_top_env_top::type_id::create("m_env", this);
    
  // create and set configuration
  m_cfg = apb2spi_top_cfg_top::type_id::create("m_cfg", this);
  set_default_configuration();
  
  // set configuration in DB
  uvm_config_db #(apb2spi_top_cfg_top)::set(this, "m_env", "m_cfg", m_cfg);
endfunction : build_phase 

// end of elaboration phase
function void test_apb2spi_top_base::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase);

   // allow additional time before stopping
   uvm_test_done.set_drain_time(this, 10us);
endfunction : end_of_elaboration_phase

// set default configuration
function void test_apb2spi_top_base::set_default_configuration();
  // define default configuration
  m_cfg.m_is_active = 1;
  m_cfg.m_has_apb_uvc = 1;
  m_cfg.m_has_spi_uvc = 1;
  m_cfg.m_has_rst_uvc = 1;
  m_cfg.m_has_scb = 1;
  m_cfg.m_has_checkers = 1;
  m_cfg.m_has_coverage = 1;
endfunction : set_default_configuration

`endif // TEST_APB2SPI_TOP_BASE_SV
