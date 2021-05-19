`timescale 1ns / 1ps
`default_nettype none

module amba_apb_if(

   //�rajel �s reset.
   input  wire                 clk,            //Rendszer�rajel
   input  wire                 rst,            //Akt�v magas szinkron reset

   // c�m �s adat
   output reg  PADDR,  // c�m
   output wire PWRITE, // �r�s-olvas�s v�laszt�: 1 -> write, 0 -> read
   output reg  PWDATA, // write data
   input  reg  PRDATA, // read data

   output wire PSEL, // perif�ria (SPI) kiv�laszt�s
   output wire PENABLE, // transzfer enable
   input  wire PREADY, // transzfer folytat�s
   output reg  [3:0]    STRB,        //B�jt enged�lyez� jelek

   // regiszter �r�si interface
   input wire [31:0]  wr_data,          // �r�si adat
   output reg  [3:0]  wr_strb,         //B�jt enged�lyez� jelek

   // regiszter olvas�si interface
   input wire [31:0]  rd_data // olvas�si adat
);

//******************************************************************************
//* �r�si �llapotg�p.                                                          *
//******************************************************************************
localparam WR_IDLE   = 2'd0;
localparam WR_SETUP  = 2'd1;
localparam WR_ACCESS = 2'd2;

reg [1:0] wr_state;

always @(posedge clk)
begin
   if (rst)
      wr_state <= WR_IDLE;
   else
      case (wr_state)
         //V�rakoz�s a transfer-re
         WR_IDLE: if (PSEL) // if transfer
                       begin
                          wr_state <= WR_SETUP;
                       end
                       else
                          wr_state <= WR_IDLE;

         //A SETUP �llapot
         WR_SETUP  : wr_state <= WR_ACCESS;

         //Az �r�si muvelet
         WR_ACCESS : if (~PREADY) // nem ready
                        wr_state <= WR_ACCESS;
                     else 
								if (PSEL) // ready �s van transzfer -> k�ld�s
									begin
										wr_state <= WR_SETUP;
										wr_data  <= PWDATA;
										wr_strb  <= STRB;
									end
								else           // ready �s nincs transzfer -> idle
									wr_state <= WR_IDLE;
         
         //�rv�nytelen �llapotok.
         default     : wr_state <= WR_IDLE;
      endcase
end



//******************************************************************************
//* Olvas�si �llapotg�p.                                                       *
//******************************************************************************
localparam RD_IDLE   = 2'd0;
localparam RD_SETUP  = 2'd1;
localparam RD_ACCESS = 2'd2;

reg [1:0] rd_state;

always @(posedge clk)
begin
   if (rst)
      rd_state <= RD_IDLE;
   else
      case (rd_state)
         //V�rakoz�s a transfer-re
         RD_IDLE: if (PSEL) // if transfer
                       begin
                          rd_state <= RD_SETUP;
                       end
                       else
                          rd_state <= RD_IDLE;

         //A SETUP �llapot
         RD_SETUP  : rd_state <= RD_ACCESS;

         //Az �r�si muvelet
         RD_ACCESS : if (~PREADY) // nem ready
                        rd_state <= RD_ACCESS;
                     else if (PSEL) // ready �s van transzfer -> k�ld�s
                        begin
									rd_state <= RD_SETUP;
									rd_data  <= PRDATA;
								end
                     else           // ready �s nincs transzfer -> idle
                        begin
									rd_state <= RD_IDLE;
									rd_data <= 32'd0;
								end
         
         //�rv�nytelen �llapotok.
         default     : rd_state <= RD_IDLE;
      endcase
end

// PREADY jelz�s�nek el��ll�t�sa.
assign PREADY = (wr_state == ACCESS || rd_state == ACCESS);

endmodule

`default_nettype wire