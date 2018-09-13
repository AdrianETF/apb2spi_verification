//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_apb2spi_top_example.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TEST_APB2SPI_TOP_EXAMPLE_SV
`define TEST_APB2SPI_TOP_EXAMPLE_SV

class test_apb2spi_top_example extends test_apb2spi_top_base;

  // registration macro
  `uvm_component_utils(test_apb2spi_top_example)
  
  // test sequence
  apb2spi_top_test_default_config_seq    m_def_conf_seq;
  apb2spi_top_test_ctrl0_config_seq      m_ctrl0_conf_seq;
  apb2spi_top_test_ctrl1_config_seq      m_ctrl1_conf_seq;
  apb2spi_top_test_cpsr_config_seq       m_cpsr_conf_seq;
  apb2spi_top_test_transmit_seq          m_transmit_seq;
  spi_uvc_master_seq                     spi_seq;
  apb2spi_top_test_register_read_seq     m_reg_read_seq;
  apb2spi_top_test_register_write_seq    m_reg_write_seq;
  rst_uvc_master_seq                     rst_seq;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // end of elaboration phase
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // set default configuration
  extern function void set_default_configuration();
  
endclass : test_apb2spi_top_example

// constructor
function test_apb2spi_top_example::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void test_apb2spi_top_example::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // apply specific testcase configuration
  // ...

  // create test seq
  m_def_conf_seq = apb2spi_top_test_default_config_seq::type_id::create("m_def_conf_seq", this);
  m_ctrl0_conf_seq = apb2spi_top_test_ctrl0_config_seq::type_id::create("m_ctrl0_conf_seq", this);
  m_ctrl1_conf_seq = apb2spi_top_test_ctrl1_config_seq::type_id::create("m_ctrl1_conf_seq", this);
  m_cpsr_conf_seq = apb2spi_top_test_cpsr_config_seq::type_id::create("m_cpsr_conf_seq", this);
  m_transmit_seq = apb2spi_top_test_transmit_seq::type_id::create("m_transmit_seq", this);
  spi_seq = spi_uvc_master_seq::type_id::create("spi_seq", this);
  m_reg_read_seq = apb2spi_top_test_register_read_seq::type_id::create("m_reg_read_seq", this);
  m_reg_write_seq = apb2spi_top_test_register_write_seq::type_id::create("m_reg_write_seq", this);
  rst_seq = rst_uvc_master_seq::type_id::create("rst_seq", this);

endfunction: build_phase

// end of elaboration phase
function void test_apb2spi_top_example::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  // apply specific testcase settings
  // ..
endfunction: end_of_elaboration_phase

// run phase
task test_apb2spi_top_example::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  phase.raise_objection(this);

  if(!rst_seq.randomize()) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  rst_seq.start(m_env.m_virtual_sequencer.m_rst_uvc_sequencer);
 
  if(!m_reg_write_seq.randomize() with {
     paddr == SPI_CPSR_ADDR;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_reg_write_seq.start(m_env.m_virtual_sequencer);

  if(!m_reg_read_seq.randomize() with {
    paddr == SPI_CPSR_ADDR;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_reg_read_seq.start(m_env.m_virtual_sequencer);

  if(!m_reg_write_seq.randomize() with {
     paddr == SPI_CPSR_ADDR;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_reg_write_seq.start(m_env.m_virtual_sequencer);

  if(!m_reg_read_seq.randomize() with {
    paddr == SPI_CPSR_ADDR;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_reg_read_seq.start(m_env.m_virtual_sequencer);

  
  phase.drop_objection(this);
endtask : run_phase

// set default configuration
function void test_apb2spi_top_example::set_default_configuration();
  super.set_default_configuration();
  
  // redefine configuration
  // m_cfg.m_has_checkers = 1;
  // ...
endfunction : set_default_configuration

`endif // TEST_APB2SPI_TOP_EXAMPLE_SV
