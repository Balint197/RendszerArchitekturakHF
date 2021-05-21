`timescale 1ns / 1ps
`default_nettype none

//******************************************************************************
//* SPI perif�ria.                                                             *
//******************************************************************************

module spi_top(   //�rajel �s reset.
   input  wire          apb_clk,                //Rendszer�rajel
   input  wire          apb_rst,                //Akt�v magas szinkron reset

   // c�m �s adat
   output wire          PADDR,  			// c�m TODO
   output wire          PWRITE, 			// �r�s-olvas�s v�laszt�: 1 -> write, 0 -> read
   input  wire  [31:0]  PWDATA, 			// write data
   output wire   [31:0] PRDATA, 			// read data

   output wire          PSEL, 			    // perif�ria (SPI) kiv�laszt�s
   output wire          PENABLE, 		    // transzfer enable
   input  wire          PREADY, 			// transzfer folytat�s
   output wire  [3:0]   STRB,            	//B�jt enged�lyez� jelek

   //SPI adatvonalak.
   input  wire          spi_miso,           //Soros bemenet, rxd
   output wire          spi_mosi,           //Soros kimenet, txd
   output wire          spi_sck,            //SPI �rajel
   output wire [3:0]    spi_cs,             //chip/slave select

   //Megszak�t�sk�r� kimenet.
   output wire        irq
);


//******************************************************************************
//* Bels� �rajel �s reset jelek.                                               *
//******************************************************************************
wire clk =  apb_clk;
wire rst = ~apb_rst; 

//******************************************************************************
//* AMBA APB busz interf�sz.                                                   *
//******************************************************************************
wire [31:0]  wr_data;         // �r�si adat
wire [3:0]   wr_strb;         //B�jt enged�lyez� jelek
wire [31:0]  rd_data; 			// olvas�si adat

amba_apb_if amba_apb_if_i (
   //�rajel �s reset.
   .clk(clk),    //Rendszer�rajel
   .rst(rst),    //Akt�v magas szinkron reset

   // c�m �s adat
   .PADDR(PADDR),  			// c�m
   .PWRITE(PWRITE), 			// �r�s-olvas�s v�laszt�: 1 -> write, 0 -> read
   .PWDATA(PWDATA), 			// write data
   .PRDATA(PRDATA), 			// read data

   .PSEL(PSEL), 			// perif�ria (SPI) kiv�laszt�s
   .PENABLE(PENABLE), 		// transzfer enable
   .PREADY(PREADY), 			// transzfer folytat�s
   .STRB(STRB),        	//B�jt enged�lyez� jelek

   // regiszter �r�si interface
   .wr_data(wr_data),       // �r�si adat
   .wr_strb(wr_strb),       //B�jt enged�lyez� jelek

   // regiszter olvas�si interface
   .rd_data(rd_data) 			// olvas�si adat
);

//******************************************************************************
//* Az SPI funkci� megval�s�t�sa.                                              *
//******************************************************************************
spi spi_i(
   .clk(clk),            //Rendszer�rajel
   .rst(rst),            //Akt�v magas szinkron reset
   
   .rw_addr(rw_addr),       //�r�s-olvas�s c�m

   //Regiszter �r�si interf�sz.
   .wr_en(wr_en),          //�r�s enged�lyez� jel
   .wr_data(wr_data),        //�r�si adat
   .wr_strb(wr_strb),        //B�jt enged�lyez� jelek
    
   //Regiszter olvas�si interf�sz.
   .rd_en(rd_en),          //Olvas�s enged�lyez� jel
   .rd_data(rd_data),        //Olvas�si adat
   
   //SPI adatvonalak.
   .spi_miso(spi_miso),       //Soros bemenet, rxd
   .spi_mosi(spi_mosi),       //Soros kimenet, txd
   .spi_sck(spi_sck),        //SPI �rajel
   .spi_cs(spi_cs),         //chip/slave select

   //Megszak�t�sk�r� kimenet.
   .irq(irq)
);

endmodule

`default_nettype wire