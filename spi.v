`timescale 1ns / 1ps
`default_nettype none

//******************************************************************************
//* Az SPI funkci�t megval�s�t� modul.                                         *
//******************************************************************************

module spi(
   //�rajel �s reset.
   input  wire                 clk,            //Rendszer�rajel
   input  wire                 rst,            //Akt�v magas szinkron reset
   
   //Regiszter �r�si interf�sz.
   input  wire [4:0]           wr_addr,        //�r�si c�m
   input  wire                 wr_en,          //�r�s enged�lyez� jel
   input  wire [31:0]          wr_data,        //�r�si adat
   input  wire [3:0]           wr_strb,        //B�jt enged�lyez� jelek
    
   //Regiszter olvas�si interf�sz.
   input  wire [4:0]           rd_addr,        //Olvas�si c�m
   input  wire                 rd_en,          //Olvas�s enged�lyez� jel
   output reg  [31:0]          rd_data,        //Olvas�si adat
   
   //UART adatvonalak.
   input  wire                 spi_miso,       //Soros bemenet, rxd
   output wire                 spi_mosi,       //Soros kimenet, txd
   
   //Megszak�t�sk�r� kimenet.
   output reg                  irq
);


endmodule

`default_nettype wire