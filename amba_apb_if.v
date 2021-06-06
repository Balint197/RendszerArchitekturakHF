`timescale 1ns / 1ps
`default_nettype none

module amba_apb_if(

   //Órajel és reset.
   input  wire          apb_clk,       //Rendszerórajel
   input  wire          apb_rst,       //Aktív magas szinkron reset

   // cím és adat
   input wire   [15:0]  PADDR,  			// cím 
   input wire           PWRITE, 			// írás-olvasás választó: 1 -> write, 0 -> read
   input wire   [31:0]  PWDATA, 			// write data
   output reg   [31:0]  PRDATA, 			// read data

   input  wire          PSEL, 			// periféria (SPI) kiválasztás
   input  wire          PENABLE, 		// transzfer enable
   input  wire   [3:0]  STRB,        	//Bájt engedélyezõ jelek
   output wire          PREADY, 			// transzfer folytatás

   // regiszter írási interface
   output reg   [31:0]  wr_data,       // írási adat
   output reg   [15:0]  rw_addr,       // írás-olvasás cím
   output reg   [3:0]   wr_strb,       //Bájt engedélyezõ jelek

   // regiszter olvasási interface
   input  wire  [31:0]  rd_data,			// olvasási adat
   output wire          rd_en
);

//******************************************************************************
//* Írás-olvasás állapotgép.                                                   *
//******************************************************************************
localparam IDLE   = 2'd0;
localparam SETUP  = 2'd1;
localparam ACCESS = 2'd2;

reg [1:0] state;
reg data;
reg strb;

always @(posedge apb_clk)
begin
   if (apb_rst)
	begin
      state <= IDLE;
		data  <= 0;
		strb  <= 0;
		PRDATA <= 0;
	end
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
         SETUP  : begin
							state <= ACCESS;
							rw_addr <= PADDR;
						end
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
assign rd_en  = (!PWRITE);

endmodule

`default_nettype wire