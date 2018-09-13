//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : spi_uvc_common.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef SPI_UVC_MASTER_COMMON_SV
`define SPI_UVC_MASTER_COMMON_SV

const bit[7:0] SCDIV1 = 1;
const bit[7:0] SCDIV2 = 2;
const bit[15:0] SCK_PERIOD = SCDIV1 * SCDIV2;

`endif // SPI_UVC_MASTER_COMMON_SV
