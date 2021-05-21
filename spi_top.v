`timescale 1ns / 1ps
`default_nettype none

//******************************************************************************
//* SPI periféria.                                                             *
//******************************************************************************

module spi_top(   //Órajel és reset.
   input  wire          apb_clk,                //Rendszerórajel
   input  wire          apb_rst,                //Aktív magas szinkron reset

   // cím és adat
   output wire          PADDR,  			// cím TODO
   output wire          PWRITE, 			// írás-olvasás választó: 1 -> write, 0 -> read
   input  wire  [31:0]  PWDATA, 			// write data
   output wire   [31:0] PRDATA, 			// read data

   output wire          PSEL, 			    // periféria (SPI) kiválasztás
   output wire          PENABLE, 		    // transzfer enable
   input  wire          PREADY, 			// transzfer folytatás
   output wire  [3:0]   STRB,            	//Bájt engedélyezõ jelek

   //SPI adatvonalak.
   input  wire          spi_miso,           //Soros bemenet, rxd
   output wire          spi_mosi,           //Soros kimenet, txd
   output wire          spi_sck,            //SPI órajel
   output wire [3:0]    spi_cs,             //chip/slave select

   //Megszakításkérõ kimenet.
   output wire        irq
);


//******************************************************************************
//* Belsõ órajel és reset jelek.                                               *
//******************************************************************************
wire clk =  apb_clk;
wire rst = ~apb_rst; 

//******************************************************************************
//* AMBA APB busz interfész.                                                   *
//******************************************************************************
wire [31:0]  wr_data;         // írási adat
wire [3:0]   wr_strb;         //Bájt engedélyezõ jelek
wire [31:0]  rd_data; 			// olvasási adat

amba_apb_if amba_apb_if_i (
   //Órajel és reset.
   .clk(clk),    //Rendszerórajel
   .rst(rst),    //Aktív magas szinkron reset

   // cím és adat
   .PADDR(PADDR),  			// cím
   .PWRITE(PWRITE), 			// írás-olvasás választó: 1 -> write, 0 -> read
   .PWDATA(PWDATA), 			// write data
   .PRDATA(PRDATA), 			// read data

   .PSEL(PSEL), 			// periféria (SPI) kiválasztás
   .PENABLE(PENABLE), 		// transzfer enable
   .PREADY(PREADY), 			// transzfer folytatás
   .STRB(STRB),        	//Bájt engedélyezõ jelek

   // regiszter írási interface
   .wr_data(wr_data),       // írási adat
   .wr_strb(wr_strb),       //Bájt engedélyezõ jelek

   // regiszter olvasási interface
   .rd_data(rd_data) 			// olvasási adat
);

//******************************************************************************
//* Az SPI funkció megvalósítása.                                              *
//******************************************************************************
spi spi_i(
   .clk(clk),            //Rendszerórajel
   .rst(rst),            //Aktív magas szinkron reset
   
   .rw_addr(rw_addr),       //Írás-olvasás cím

   //Regiszter írási interfész.
   .wr_en(wr_en),          //Írás engedélyezõ jel
   .wr_data(wr_data),        //Írási adat
   .wr_strb(wr_strb),        //Bájt engedélyezõ jelek
    
   //Regiszter olvasási interfész.
   .rd_en(rd_en),          //Olvasás engedélyezõ jel
   .rd_data(rd_data),        //Olvasási adat
   
   //SPI adatvonalak.
   .spi_miso(spi_miso),       //Soros bemenet, rxd
   .spi_mosi(spi_mosi),       //Soros kimenet, txd
   .spi_sck(spi_sck),        //SPI órajel
   .spi_cs(spi_cs),         //chip/slave select

   //Megszakításkérõ kimenet.
   .irq(irq)
);

endmodule

`default_nettype wire