`timescale 1ns / 1ps
`default_nettype none

//******************************************************************************
//* Az SPI funkciót megvalósító modul.                                         *
//******************************************************************************

module spi(
   //Órajel és reset.
   input  wire                 clk,            //Rendszerórajel
   input  wire                 rst,            //Aktív magas szinkron reset
   
   //Regiszter írási interfész.
   input  wire [4:0]           wr_addr,        //Írási cím
   input  wire                 wr_en,          //Írás engedélyezõ jel
   input  wire [31:0]          wr_data,        //Írási adat
   input  wire [3:0]           wr_strb,        //Bájt engedélyezõ jelek
    
   //Regiszter olvasási interfész.
   input  wire [4:0]           rd_addr,        //Olvasási cím
   input  wire                 rd_en,          //Olvasás engedélyezõ jel
   output reg  [31:0]          rd_data,        //Olvasási adat
   
   //UART adatvonalak.
   input  wire                 spi_miso,       //Soros bemenet, rxd
   output wire                 spi_mosi,       //Soros kimenet, txd
   
   //Megszakításkérõ kimenet.
   output reg                  irq
);


endmodule

`default_nettype wire