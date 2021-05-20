`timescale 1ns / 1ps
`default_nettype none

module amba_apb_if(

   //Órajel és reset.
   input  wire                 clk,    //Rendszerórajel
   input  wire                 rst,    //Aktív magas szinkron reset

   // cím és adat
   output reg           PADDR,  			// cím
   output wire          PWRITE, 			// írás-olvasás választó: 1 -> write, 0 -> read
   input wire   [31:0]  PWDATA, 			// write data
   output reg   [31:0]  PRDATA, 			// read data

   output wire          PSEL, 			// periféria (SPI) kiválasztás
   output wire          PENABLE, 		// transzfer enable
   input  wire          PREADY, 			// transzfer folytatás
   output reg   [3:0]   STRB,        	//Bájt engedélyezõ jelek

   // regiszter írási interface
   output reg   [31:0]  wr_data,       // írási adat
   output reg   [3:0]   wr_strb,       //Bájt engedélyezõ jelek

   // regiszter olvasási interface
   input wire   [31:0]  rd_data 			// olvasási adat
);

//******************************************************************************
//* Írás-olvasás állapotgép.                                                   *
//******************************************************************************
localparam IDLE   = 2'd0;
localparam SETUP  = 2'd1;
localparam ACCESS = 2'd2;

reg [1:0] state;

always @(posedge clk)
begin
   if (rst)
      state <= IDLE;
   else
      case (state)
         //Várakozás a transfer-re
         IDLE: if (PSEL) // if transfer
                       begin
                          state <= SETUP;
                       end
                       else
                          state <= IDLE;

         //A SETUP állapot
         SETUP  : state <= ACCESS;

         //Az írási muvelet
         ACCESS : if (~PREADY) 					// nem ready
                        state <= ACCESS;
                     else 							// ready
								if (~PSEL) 				// nincs transzfer -> idle
									begin
									state <= IDLE;
									if (~PWRITE) 		// írás esetén PRDATA nullázása
										PRDATA <= 32'd0;
									end
								else           		// van transzfer -> küldés/fogadás
									begin
										state <= SETUP;// visszalépés SETUP-hoz
										if (PWRITE)    // olvasás
											begin
												data  <= PWDATA;
												strb  <= STRB;
											end
										else				// írás
											PRDATA <= data;											
									end
				//Érvénytelen állapotok.
				default     : state <= IDLE;
      endcase
end

// PREADY jelzésének elõállítása.
assign PREADY = (state == ACCESS);

endmodule

`default_nettype wire