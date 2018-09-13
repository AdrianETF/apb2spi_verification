//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_common.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_TOP_COMMON_SV
`define APB2SPI_TOP_COMMON_SV

  const bit[31:0] SPI_CAP_ADDR    = 32'h0;
  const bit[31:0] SPI_CTRL0_ADDR  = 32'h4;
  const bit[31:0] SPI_CTRL1_ADDR  = 32'h8;
  const bit[31:0] SPI_STAT0_ADDR  = 32'hC;
  const bit[31:0] SPI_DAT_ADDR    = 32'h10;
  const bit[31:0] SPI_CPSR_ADDR   = 32'h14;
  const bit[31:0] SPI_DMAREQ_ADDR = 32'h18;
  const bit[31:0] SPI_IE_ADDR     = 32'h20;
  const bit[31:0] SPI_IRS_ADDR    = 32'h24;
  const bit[31:0] SPI_IMS_ADDR    = 32'h28;
  const bit[31:0] SPI_ICR_ADDR    = 32'h2C;
  const bit[31:0] SPI_IX_ADDR     = 32'h30;

`endif // APB2SPI_TOP_COMMON_SV
