//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_virtual_seq_lib.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_VIRTUAL_SEQ_LIB_SV
`define APB2SPI_TOP_VIRTUAL_SEQ_LIB_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// include all sequences
`include "apb2spi_top_base_virtual_seq.sv"
`include "apb2spi_top_test_example_seq.sv"
`include "apb2spi_top_test_default_config_seq.sv"
`include "apb2spi_top_test_write_read_reset_seq.sv"
`include "apb2spi_top_test_ctrl0_config_seq.sv"
`include "apb2spi_top_test_ctrl1_config_seq.sv"
`include "apb2spi_top_test_cpsr_config_seq.sv"
`include "apb2spi_top_test_transmit_seq.sv"
`include "apb2spi_top_test_receive_seq.sv"
`include "apb2spi_top_test_register_read_seq.sv"
`include "apb2spi_top_test_register_write_seq.sv"

`endif // APB2SPI_TOP_VIRTUAL_SEQ_LIB_SV
