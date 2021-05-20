`timescale 1ns / 1ps
`default_nettype none

//******************************************************************************
//* SPI periféria.                                                             *
//******************************************************************************

module spi_top(
	input wire s_apb_aclk,
	input wire s_apb_aresetn,
	// TODO
    );


//******************************************************************************
//* Belsõ órajel és reset jelek.                                               *
//******************************************************************************
wire clk =  s_apb_aclk;
wire rst = ~s_apb_aresetn; // TODO nem megfordítva?

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
// TODO
);

endmodule

`default_nettype wire