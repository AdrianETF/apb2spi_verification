//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : test_apb2spi_top_transmit_test.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef TEST_APB2SPI_TOP_TRANSMIT_TEST_SV
`define TEST_APB2SPI_TOP_TRANSMIT_TEST_SV

class test_apb2spi_top_transmit_test extends test_apb2spi_top_base;

  // registration macro
  `uvm_component_utils(test_apb2spi_top_transmit_test)
  
  // test sequence
  apb2spi_top_test_default_config_seq    m_def_conf_seq;
  apb2spi_top_test_ctrl0_config_seq      m_ctrl0_conf_seq;
  apb2spi_top_test_ctrl1_config_seq      m_ctrl1_conf_seq;
  apb2spi_top_test_cpsr_config_seq       m_cpsr_conf_seq;
  apb2spi_top_test_transmit_seq          m_transmit_seq;
  apb2spi_top_test_register_read_seq     m_read_reg_seq;
  spi_uvc_master_seq                     spi_seq;
  rst_uvc_master_seq                     rst_seq;
  
  rand int flag;
  rand int loop_cnt;

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
  
endclass : test_apb2spi_top_transmit_test

// constructor
function test_apb2spi_top_transmit_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void test_apb2spi_top_transmit_test::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create test seq
  m_def_conf_seq = apb2spi_top_test_default_config_seq::type_id::create("m_def_conf_seq", this);
  m_ctrl0_conf_seq = apb2spi_top_test_ctrl0_config_seq::type_id::create("m_ctrl0_conf_seq", this);
  m_ctrl1_conf_seq = apb2spi_top_test_ctrl1_config_seq::type_id::create("m_ctrl1_conf_seq", this);
  m_cpsr_conf_seq = apb2spi_top_test_cpsr_config_seq::type_id::create("m_cpsr_conf_seq", this);
  m_transmit_seq = apb2spi_top_test_transmit_seq::type_id::create("m_transmit_seq", this);
  m_read_reg_seq = apb2spi_top_test_register_read_seq::type_id::create("m_read_reg_seq", this);
  spi_seq = spi_uvc_master_seq::type_id::create("spi_seq", this);
  rst_seq = rst_uvc_master_seq::type_id::create("rst_seq", this);

endfunction: build_phase

// end of elaboration phase
function void test_apb2spi_top_transmit_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  // apply specific testcase settings
  // ..
endfunction: end_of_elaboration_phase

// run phase
task test_apb2spi_top_transmit_test::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  phase.raise_objection(this);

  loop_cnt = $urandom_range(64, 16);

  if(!rst_seq.randomize()) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  rst_seq.start(m_env.m_virtual_sequencer.m_rst_uvc_sequencer);

  // CONFIGURE DUT
  if(!m_ctrl1_conf_seq.randomize()) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_ctrl1_conf_seq.start(m_env.m_virtual_sequencer);

  if(!m_cpsr_conf_seq.randomize()) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_cpsr_conf_seq.start(m_env.m_virtual_sequencer);

  // START DUT
  if(!m_ctrl0_conf_seq.randomize() with {
     ctrl0_DIR == 2'b10;
     ctrl0_SPIEN == 1;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_ctrl0_conf_seq.start(m_env.m_virtual_sequencer);

for(int i = 0; i < loop_cnt; i++) begin
  flag = $urandom_range(1,0);
  if(flag == 1) begin
    if(!m_transmit_seq.randomize()) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    m_transmit_seq.start(m_env.m_virtual_sequencer);
  end
  flag = $urandom_range(2,0);
  if(flag == 2) begin
    if(!spi_seq.randomize()) begin
      `uvm_fatal(get_type_name(), "Failed to randomize.")
    end
    spi_seq.start(m_env.m_virtual_sequencer.m_spi_uvc_sequencer);
  end
  if(!m_read_reg_seq.randomize() with {
     paddr == SPI_STAT0_ADDR;
  }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  m_read_reg_seq.start(m_env.m_virtual_sequencer);
end

  phase.drop_objection(this);
endtask : run_phase

// set default configuration
function void test_apb2spi_top_transmit_test::set_default_configuration();
  super.set_default_configuration();
endfunction : set_default_configuration

`endif // TEST_APB2SPI_TOP_TRANSMIT_TEST_SV
