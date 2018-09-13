//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_spi_uvc_example.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TEST_SPI_UVC_EXAMPLE_SV
`define TEST_SPI_UVC_EXAMPLE_SV

// example test
class test_spi_uvc_example extends test_spi_uvc_base;
  
  // registration macro
  `uvm_component_utils(test_spi_uvc_example)
  /////////////////////////////
  // sequences///////
  spi_uvc_master_seq m_master_seq;
  //spi_uvc_seq m_slave_seq;

  // constructor
  extern function new(string name, uvm_component parent);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // set default configuration
  extern function void set_default_configuration();
  
endclass : test_spi_uvc_example

// constructor
function test_spi_uvc_example::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// run phase
task test_spi_uvc_example::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  uvm_test_done.raise_objection(this, get_type_name());    
  `uvm_info(get_type_name(), "TEST STARTED", UVM_LOW)

  //m_seq = spi_uvc_master_seq::type_id::create("m_seq", this);

  

  for(int i = 0; i < 25; i++) begin

    //m_slave_seq = spi_uvc_seq::type_id::create("m_sq", this);
    m_master_seq = spi_uvc_master_seq::type_id::create("m_m_sq", this);
  
    //start slave sequence
    /*if(!m_slave_seq.randomize()) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    fork
      m_slave_seq.start(m_spi_uvc_env_top.m_spi_uvc_env.m_slave_agent.m_sequencer);
    join_none*/

    if(!m_master_seq.randomize()) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
      m_master_seq.start(m_spi_uvc_env_top.m_spi_uvc_env.m_master_agent.m_sequencer);

  end
  
  /*for(int i = 0; i < 15; i++) begin
    if(!m_seq.randomize() with {
      //pready_delay == 3;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
      m_seq.start(m_spi_uvc_env_top.m_spi_uvc_env.m_agent.m_sequencer);
  end*/
  
  /*m_master_seq = spi_uvc_master_seq::type_id::create("m_master_seq", this);
  
  for(int i = 0; i < 16; i++) begin
    if(!m_master_seq.randomize() with {
      m_signal_value == 1;
    }) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_master_seq.start(m_spi_uvc_env_top.m_spi_uvc_env.m_master_agent.m_sequencer);
  end*/

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      
  uvm_test_done.drop_objection(this, get_type_name());    
  `uvm_info(get_type_name(), "TEST FINISHED", UVM_LOW)
endtask : run_phase

// set default configuration
function void test_spi_uvc_example::set_default_configuration();
  super.set_default_configuration();
  
  // redefine configuration
 // m_cfg.m_spi_uvc_cfg.m_agent_cfg.m_cfg_field = 'hC;
endfunction : set_configuration

`endif // TEST_SPI_UVC_EXAMPLE_SV
