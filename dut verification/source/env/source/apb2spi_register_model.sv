//------------------------------------------------------------------------------
// Copyright (c) 2018 Elsys Eastern Europe
// All rights reserved.
//------------------------------------------------------------------------------
// File name  : apb2spi_top_scb.sv
// Developer  : Adrian Milakovic
// Date       : 
// Description: 
// Notes      : 
//
//------------------------------------------------------------------------------

`ifndef APB2SPI_REG_MOD_SV
`define APB2SPI_REG_MOD_SV

class apb2spi_register_model;
  
  struct {
    struct packed {
      bit[12:0] reserved;
      bit[2:0]  SSNUM;
      bit       DPACKA;
      bit       ABUFA;
      bit[5:0]  FDEPTH;
      bit[7:0]  REV;
    } data;
    bit         read_only = 1;
    bit[31:0]   rst_value = 32'h0007cf01;
  } spi_cap;

  function bit[31:0] spi_cap_data_read();
      return spi_cap.data;
  endfunction : spi_cap_data_read
  
  struct {
    struct packed {
      bit[7:0]  WMRK;
      bit[3:0]  reserved0;
      bit       FLUSHR;
      bit       FLUSHT;
      bit       ADPTBUF;
      bit       ENCBUF;
      bit[1:0]  reserved1;
      bit       DPACK;
      bit[4:0]  DSIZ;
      bit       reserved2;
      bit       DORD;
      bit[1:0]  DIR;
      bit       CPHA;
      bit       CPOL;
      bit       MS;
      bit       SPIEN;
    } data;
    bit         read_only = 0;
    bit[31:0]   rst_value = 32'b0;
  } spi_ctrl0;

  function bit[31:0] spi_ctrl0_data_read();
      return spi_ctrl0.data;
  endfunction : spi_ctrl0_data_read

  function void spi_ctrl0_data_write(bit[31:0] data);
      spi_ctrl0.data = {data[31:24], 4'b0, data[19:16], 2'b0, data[13:8], 1'b0, data[6:0]};
  endfunction : spi_ctrl0_data_write

  struct {
    struct packed {
      bit[7:0]  reserved;
      bit[7:0]  SSSV;
      bit[3:0]  SSCG;
      bit[2:0]  SSINSEL;
      bit       SSSM;
      bit[7:0]  SSEN;
    } data;
    bit         read_only = 0;
    bit[31:0]   rst_value = 32'b0;
  } spi_ctrl1;

  function bit[31:0] spi_ctrl1_data_read();
      return spi_ctrl1.data;
  endfunction : spi_ctrl1_data_read

  function void spi_ctrl1_data_write(bit[31:0] data);
      spi_ctrl1.data   =    {8'b0, data[23:0]};
  endfunction : spi_ctrl1_data_write

  struct {
    struct packed {
      bit[7:0]  TXBEC;
      bit[7:0]  RXBEC;
      bit[7:0]  reserved0;
      bit       RFF;
      bit       RNE;
      bit       TNF;
      bit       TFE;
      bit[2:0]  reserved1;
      bit       BSY;
    } data;
    bit         read_only = 1;
    bit[31:0]   rst_value = 32'h30;
  } spi_stat0;

  function bit[31:0] spi_stat0_data_read();
      return spi_stat0.data;
  endfunction : spi_stat0_data_read

  function void spi_stat0_data_write(bit[31:0] data);
      spi_stat0.data    =    {data[31:16], 8'b0, data[7:4], 3'b0, data[0]};
  endfunction : spi_stat0_data_write

  struct {
    bit[31:0]   data;
    bit         read_only = 0;
    bit[31:0]   rst_value = 32'b0;
  } spi_dat;

  function bit[31:0] spi_dat_data_read();
      return spi_dat.data;
  endfunction : spi_dat_data_read

  function void spi_data_write(bit[31:0] data, bit[3:0] strobe, bit[31:0] address);
      case(address)
        SPI_CTRL0_ADDR:
        begin
            if(spi_ctrl0.data.SPIEN == 0)
              spi_ctrl0_data_write({strobe[3] ? data[31:24] : spi_ctrl0.data[31:24], strobe[2] ? {data[23:20], data[19:18], data[17:16]} : spi_ctrl0.data[23:16], strobe[1] ? data[15:8] : spi_ctrl0.data[15:8], strobe[0] ? data[7:0] : spi_ctrl0.data[7:0]});
            else
              spi_ctrl0_data_write({strobe[3] ? data[31:24] : spi_ctrl0.data[31:24], strobe[2] ? {spi_ctrl0.data[23:20], data[19:18], spi_ctrl0.data[17:16]} : spi_ctrl0.data[23:16], spi_ctrl0.data[15:8], strobe[0] ? {spi_ctrl0.data[7:1], data[0]} : spi_ctrl0.data[7:0]});
        end
        SPI_CTRL1_ADDR:		spi_ctrl1_data_write({strobe[3] ? data[31:24] : spi_ctrl1.data[31:24], strobe[2] ? data[23:16] : spi_ctrl1.data[23:16], strobe[1] ? data[15:8] : spi_ctrl1.data[18:8], strobe[0] ? data[7:0] : spi_ctrl1.data[7:0]});
        SPI_CPSR_ADDR:		spi_cpsr_data_write({strobe[3] ? data[31:24] : spi_cpsr.data[31:24], strobe[2] ? data[23:16] : spi_cpsr.data[23:16], strobe[1] ? data[15:8] : spi_cpsr.data[15:8], strobe[0] ? data[7:0] : spi_cpsr.data[7:0]});
      endcase
  endfunction : spi_data_write

  struct {
    struct packed {
      bit[7:0]  reserved2;
      bit[7:0]  SCDIV2;
      bit[7:0]  reserved1;
      bit[7:0]  SCDIV1;
    } data;
    bit         read_only = 0;
    bit[31:0]   rst_value = 32'b0;
  } spi_cpsr;

  function bit[31:0] spi_cpsr_data_read();
      return spi_cpsr.data;
  endfunction : spi_cpsr_data_read

  function void spi_cpsr_data_write(bit[31:0] data);
      spi_cpsr.data = {8'b0, data[23:16], 8'b0, data[7:0]};
  endfunction : spi_cpsr_data_write

  function void reset_registers();
    spi_cap.data = spi_cap.rst_value;
    spi_ctrl0.data = spi_ctrl0.rst_value;
    spi_ctrl1.data = spi_ctrl1.rst_value;
    spi_stat0.data = spi_stat0.rst_value;
    spi_dat.data = spi_dat.rst_value;
    spi_cpsr.data = spi_cpsr.rst_value;
  endfunction: reset_registers

endclass : apb2spi_register_model

`endif // APB2SPI_REG_MOD_SV
