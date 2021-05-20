`timescale 1ns / 1ps
`default_nettype none

//******************************************************************************
//* SPI perif�ria.                                                             *
//******************************************************************************

module spi_top(
	input wire s_apb_aclk,
	input wire s_apb_aresetn,
	// TODO
    );


//******************************************************************************
//* Bels� �rajel �s reset jelek.                                               *
//******************************************************************************
wire clk =  s_apb_aclk;
wire rst = ~s_apb_aresetn; // TODO nem megford�tva?

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
// TODO
);

endmodule

`default_nettype wire