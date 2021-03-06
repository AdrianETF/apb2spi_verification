//------------------------------------------------------------------------------
// Copyright (c) 2017 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb_uvc_if.sv
// Developer  : Milan Bjelobrk
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB_UVC_IF_SV
`define APB_UVC_IF_SV

interface apb_uvc_if(input clock, input reset_n);
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  // signals
  logic [31:0] PADDR;
  logic [31:0] PWDATA;
  logic [31:0] PRDATA;
  logic        PREADY;
  logic        PWRITE;
  logic        PSEL;
  logic        PENABLE;
  logic [3:0]  PSTRB;
  logic        PSLVERR;
  
  // assertions

  property apb_penable_deassert_chk;
    @(posedge clock)
    disable iff (!reset_n)
    $rose(PREADY) |=> $fell(PENABLE);
  endproperty: apb_penable_deassert_chk

  property apb_prop_pstrb_low_chk;
    @(posedge clock)
    disable iff (!reset_n)
    ($rose(PREADY) && !PWRITE) |-> ##0 PSTRB == 4'b0000;
  endproperty: apb_prop_pstrb_low_chk

  property apb_prop_notunknown_address;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PADDR);
  endproperty: apb_prop_notunknown_address

  property apb_prop_notunknown_wdata;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PWDATA);
  endproperty: apb_prop_notunknown_wdata

  property apb_prop_notunknown_rdata;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PRDATA);
  endproperty: apb_prop_notunknown_rdata

  property apb_prop_notunknown_pwrite;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PWRITE);
  endproperty: apb_prop_notunknown_pwrite

  property apb_prop_notunknown_psel;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PSEL);
  endproperty: apb_prop_notunknown_psel

  property apb_prop_notunknown_penable;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PENABLE);
  endproperty: apb_prop_notunknown_penable

  property apb_prop_notunknown_pstrb;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PSTRB);
  endproperty: apb_prop_notunknown_pstrb

  property apb_prop_notunknown_pslverr;
    @(posedge clock) 
    disable iff (!reset_n)
    !$isunknown(PSLVERR);
  endproperty: apb_prop_notunknown_pslverr

  property apb_prop_stable_address;
    @(posedge clock) 
    disable iff (!reset_n)
    (PSEL && PENABLE && !PREADY) |=> $stable(PADDR)[*1:$] ##0 PREADY;
  endproperty: apb_prop_stable_address

  property apb_prop_stable_pwdata;
    @(posedge clock) 
    disable iff (!reset_n)
    (PSEL && PENABLE && !PREADY && PWRITE) |=> $stable(PWDATA)[*1:$] ##0 PREADY;
  endproperty: apb_prop_stable_pwdata

  property apb_prop_stable_pwrite;
    @(posedge clock) 
    disable iff (!reset_n)
    (PSEL && PENABLE && !PREADY) |=> $stable(PWRITE)[*1:$] ##0 PREADY;
  endproperty: apb_prop_stable_pwrite

  property apb_prop_stable_pstrb;
    @(posedge clock) 
    disable iff (!reset_n)
    (PSEL && PENABLE && !PREADY) |=> $stable(PSTRB)[*1:$] ##0 PREADY;
  endproperty: apb_prop_stable_pstrb
  
  
  apb_penable_assert_chk: assert property (apb_penable_deassert_chk);

  apb_pstrb_low_chk: assert property (apb_prop_pstrb_low_chk);

  apb_paddr_not_unknown_chk: assert property (apb_prop_notunknown_address);
  apb_pwdata_not_unknown_chk: assert property (apb_prop_notunknown_wdata);
  apb_prdata_not_unknown_chk: assert property (apb_prop_notunknown_rdata);
  apb_psel_not_unknown_chk: assert property (apb_prop_notunknown_psel);
  apb_penable_not_unknown_chk: assert property (apb_prop_notunknown_penable);
  apb_pslverr_not_unknown_chk: assert property (apb_prop_notunknown_pslverr);
  apb_pstrb_not_unknown_chk: assert property (apb_prop_notunknown_pstrb);
  apb_pwrite_not_unknown_chk: assert property (apb_prop_notunknown_pwrite);

  apb_paddr_stable_chk: assert property (apb_prop_stable_address);
  apb_pwdata_stable_chk: assert property (apb_prop_stable_pwdata);
  apb_pwrite_stable_chk: assert property (apb_prop_stable_pwrite);
  apb_pstrb_stable_chk: assert property (apb_prop_stable_pstrb);
  
endinterface : apb_uvc_if

`endif // APB_UVC_IF_SV
