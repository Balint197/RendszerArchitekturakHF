`timescale 1ns / 1ps
`default_nettype none

module amba_apb_if(

   //Órajel és reset.
   input  wire                 clk,            //Rendszerórajel
   input  wire                 rst,            //Aktív magas szinkron reset

   // cím és adat
   output reg  PADDR,  // cím
   output wire PWRITE, // írás-olvasás választó: 1 -> write, 0 -> read
   output reg  PWDATA, // write data
   input  reg  PRDATA, // read data

   output wire PSEL, // periféria (SPI) kiválasztás
   output wire PENABLE, // transzfer enable
   input  wire PREADY, // transzfer folytatás
   output reg  [3:0]    STRB,        //Bájt engedélyezõ jelek

   // regiszter írási interface
   input wire [31:0]  wr_data,          // írási adat
   output reg  [3:0]  wr_strb,         //Bájt engedélyezõ jelek

   // regiszter olvasási interface
   input wire [31:0]  rd_data // olvasási adat
);

//******************************************************************************
//* Írási állapotgép.                                                          *
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
         //Várakozás a transfer-re
         WR_IDLE: if (PSEL) // if transfer
                       begin
                          wr_state <= WR_SETUP;
                       end
                       else
                          wr_state <= WR_IDLE;

         //A SETUP állapot
         WR_SETUP  : wr_state <= WR_ACCESS;

         //Az írási muvelet
         WR_ACCESS : if (~PREADY) // nem ready
                        wr_state <= WR_ACCESS;
                     else 
								if (PSEL) // ready és van transzfer -> küldés
									begin
										wr_state <= WR_SETUP;
										wr_data  <= PWDATA;
										wr_strb  <= STRB;
									end
								else           // ready és nincs transzfer -> idle
									wr_state <= WR_IDLE;
         
         //Érvénytelen állapotok.
         default     : wr_state <= WR_IDLE;
      endcase
end



//******************************************************************************
//* Olvasási állapotgép.                                                       *
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
         //Várakozás a transfer-re
         RD_IDLE: if (PSEL) // if transfer
                       begin
                          rd_state <= RD_SETUP;
                       end
                       else
                          rd_state <= RD_IDLE;

         //A SETUP állapot
         RD_SETUP  : rd_state <= RD_ACCESS;

         //Az írási muvelet
         RD_ACCESS : if (~PREADY) // nem ready
                        rd_state <= RD_ACCESS;
                     else if (PSEL) // ready és van transzfer -> küldés
                        begin
									rd_state <= RD_SETUP;
									rd_data  <= PRDATA;
								end
                     else           // ready és nincs transzfer -> idle
                        begin
									rd_state <= RD_IDLE;
									rd_data <= 32'd0;
								end
         
         //Érvénytelen állapotok.
         default     : rd_state <= RD_IDLE;
      endcase
end

// PREADY jelzésének elõállítása.
assign PREADY = (wr_state == ACCESS || rd_state == ACCESS);

endmodule

`default_nettype wire