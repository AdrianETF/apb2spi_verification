//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_cov.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_COV_SV
`define APB_UVC_COV_SV

class apb_uvc_cov extends uvm_subscriber #(apb_uvc_item);
  
  // registration macro
  `uvm_component_utils(apb_uvc_cov)
  
  // configuration reference
  apb_uvc_agent_cfg m_cfg;
  
  // coverage fields 
  apb_uvc_item m_item;
  
  // coverage groups
  covergroup apb_uvc_cg;
    option.per_instance = 1;

    apb_pwrite_cov: coverpoint m_item.pwrite {
      bins write = {1};
      bins read  = {0};
    }

    apb_pslverr_cov: coverpoint m_item.pslverr {
      bins error_yes = {1};
      bins error_no  = {0};
    }
  
    apb_pstrb_cov: coverpoint m_item.pstrb {
      bins strobe_1 = {4'b0001};
      bins strobe_2 = {4'b0010};
      bins strobe_3 = {4'b0011}; 
      bins strobe_4 = {4'b0100};
      bins strobe_8 = {4'b1000}; 
      bins strobe_12 = {4'b1100};
      bins strobe_15 = {4'b1111};
    }

    apb_paddr_cov: coverpoint m_item.paddr {
      bins addr_cap = {SPI_CAP_ADDR};
      bins addr_ctrl0 = {SPI_CTRL0_ADDR};
      bins addr_ctrl1 = {SPI_CTRL1_ADDR};
      bins addr_stat0 = {SPI_STAT0_ADDR};
      bins addr_dat = {SPI_DAT_ADDR};
      bins addr_cpsr = {SPI_CPSR_ADDR};
    }
 
    apb_address_write_cross: cross apb_pwrite_cov, apb_paddr_cov;
    apb_error_write_cross: cross apb_pwrite_cov, apb_pslverr_cov;

  endgroup : apb_uvc_cg
  
  // constructor
  extern function new(string name, uvm_component parent);
  // analysis implementation port function
  extern virtual function void write(apb_uvc_item t);

endclass : apb_uvc_cov

// constructor
function apb_uvc_cov::new(string name, uvm_component parent);
  super.new(name, parent);
  apb_uvc_cg = new();
endfunction : new

// analysis implementation port function
function void apb_uvc_cov::write(apb_uvc_item t);
  m_item = t;
  apb_uvc_cg.sample();
endfunction : write

`endif // APB_UVC_COV_SV
