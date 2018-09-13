
`ifndef RST_UVC_IF_SV
`define RST_UVC_IF_SV

interface rst_uvc_if(input clock);
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  
  // signals
  logic  RESET_N;
  
endinterface : rst_uvc_if

`endif // RST_UVC_IF_SV
