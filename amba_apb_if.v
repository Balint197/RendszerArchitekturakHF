`timescale 1ns / 1ps
`default_nettype none

module amba_apb_if(

   //�rajel �s reset.
   input  wire                 clk,    //Rendszer�rajel
   input  wire                 rst,    //Akt�v magas szinkron reset

   // c�m �s adat
   output reg           PADDR,  			// c�m
   output wire          PWRITE, 			// �r�s-olvas�s v�laszt�: 1 -> write, 0 -> read
   input wire   [31:0]  PWDATA, 			// write data
   output reg   [31:0]  PRDATA, 			// read data

   output wire          PSEL, 			// perif�ria (SPI) kiv�laszt�s
   output wire          PENABLE, 		// transzfer enable
   input  wire          PREADY, 			// transzfer folytat�s
   output reg   [3:0]   STRB,        	//B�jt enged�lyez� jelek

   // regiszter �r�si interface
   output reg   [31:0]  wr_data,       // �r�si adat
   output reg   [3:0]   wr_strb,       //B�jt enged�lyez� jelek

   // regiszter olvas�si interface
   input wire   [31:0]  rd_data 			// olvas�si adat
);

//******************************************************************************
//* �r�s-olvas�s �llapotg�p.                                                   *
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
         //V�rakoz�s a transfer-re
         IDLE: if (PSEL) // if transfer
                       begin
                          state <= SETUP;
                       end
                       else
                          state <= IDLE;

         //A SETUP �llapot
         SETUP  : state <= ACCESS;

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

endmodule

`default_nettype wire