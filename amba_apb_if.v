`timescale 1ns / 1ps
`default_nettype none

module amba_apb_if(

   //�rajel �s reset.
   input  wire          apb_clk,       //Rendszer�rajel
   input  wire          apb_rst,       //Akt�v magas szinkron reset

   // c�m �s adat
   input wire   [15:0]  PADDR,  			// c�m 
   input wire           PWRITE, 			// �r�s-olvas�s v�laszt�: 1 -> write, 0 -> read
   input wire   [31:0]  PWDATA, 			// write data
   output reg   [31:0]  PRDATA, 			// read data

   input  wire          PSEL, 			// perif�ria (SPI) kiv�laszt�s
   input  wire          PENABLE, 		// transzfer enable
   input  wire   [3:0]  STRB,        	//B�jt enged�lyez� jelek
   output wire          PREADY, 			// transzfer folytat�s

   // regiszter �r�si interface
   output reg   [31:0]  wr_data,       // �r�si adat
   output reg   [15:0]  rw_addr,       // �r�s-olvas�s c�m
   output reg   [3:0]   wr_strb,       //B�jt enged�lyez� jelek

   // regiszter olvas�si interface
   input  wire  [31:0]  rd_data,			// olvas�si adat
   output wire          rd_en
);

//******************************************************************************
//* �r�s-olvas�s �llapotg�p.                                                   *
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
         //V�rakoz�s a transfer-re
         IDLE: if (PSEL) // if transfer
                       begin
                          state <= SETUP;
                       end
                       else
                          state <= IDLE;

         //A SETUP �llapot
         SETUP  : begin
							state <= ACCESS;
							rw_addr <= PADDR;
						end
         //Az �r�si muvelet
         ACCESS : if (~PREADY) 					// nem ready
                        state <= ACCESS;
                     else 							// ready
								if (~PSEL) 				// nincs transzfer -> idle
									begin
									state <= IDLE;
									if (~PWRITE) 		// �r�s eset�n PRDATA null�z�sa
										PRDATA <= 32'd0;
									end
								else           		// van transzfer -> k�ld�s/fogad�s
									begin
										state <= SETUP;// visszal�p�s SETUP-hoz
										if (PWRITE)    // olvas�s
											begin
												data  <= PWDATA;
												strb  <= STRB;
											end
										else				// �r�s
											PRDATA <= data;											
									end
				//�rv�nytelen �llapotok.
				default     : state <= IDLE;
      endcase
end

// PREADY jelz�s�nek el��ll�t�sa.
assign PREADY = (state == ACCESS);
assign rd_en  = (!PWRITE);

endmodule

`default_nettype wire