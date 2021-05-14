`timescale 1ns / 1ps
`default_nettype none

module SPI_master#(
	parameter SPI_MODE = 0,
   parameter MAX_BYTES_PER_CS = 2,
   parameter CS_INACTIVE_CLKS = 1
)	(
   // �rajel �s reset.
   input  wire                 clk,            //Rendszer�rajel
   input  wire                 rst,            //Akt�v magas szinkron reset

   // Regiszter �r�si interf�sz.
	input  wire [4:0]           comm_addr,      //�r�si olvas�si c�m
   input  wire                 comm_en,   	  //�r�s enged�lyez� jel
   input  wire [31:0]          wr_data,        //�r�si adat
   input  wire [3:0]           strb,           //B�jt enged�lyez� jelek
 
 // Regiszter olvas�si interf�sz.
   output reg  [31:0]          rd_data,        //Olvas�si adat

   // SPI adatvonalak.
   input  wire                 spi_MISO,       // bemenet
   output wire                 spi_MOSI,       // kimenet
   
   // Megszak�t�sk�r� kimenet.
   output reg                  irq				  // interrupt request
);

wire CPOL;     // �rajel polarit�s
wire CPHA;     // �rajel f�zis

assign CPOL  = (SPI_MODE == 2) | (SPI_MODE == 3); // m�d alapj�n polarit�s
assign CPHA  = (SPI_MODE == 1) | (SPI_MODE == 3); // m�d alapj�n f�zis

//******************************************************************************
//* Vez�rl� regiszter.                  B�ZIS+0x00, 32 bites, �rhat�/olvashat� *
//******************************************************************************
wire ctrl_reg_comm = comm_en & (comm_addr[4:2] == 3'd0) & (strb == 4'b1111);
wire ctrl_reg_comm_rd = comm_en & (comm_addr[4:2] == 3'd0);

// Ad�s-v�tel enged�lyez�s (1 bit)

reg comm;

always @(posedge clk)
begin
   if (rst)
      comm <= 1'b0;
   else
      if (ctrl_reg_comm)
         comm <= comm_data[0];
end

wire [31:0] ctrl_reg_dout = {31'd0, comm};

//******************************************************************************
//* �rajel oszt�s regiszter.            B�ZIS+0x04, 32 bites, �rhat�/olvashat� *
//* baud rate = f_sysclk / (16 * (CLKDIV + 1))                                 *
//******************************************************************************
wire clkdiv_reg_comm = comm_en & (comm_addr[4:2] == 3'd1) & (wr_strb == 4'b1111);
wire clkdiv_reg_comm_rd = comm_en & (comm_addr[4:2] == 3'd1);

//�rajel oszt�s (0 - 15. bitek).
reg [15:0] clkdiv;


always @(posedge clk && ~CPOL && ~CPHA) // mode 0
begin
   if (rst)
      clkdiv <= 16'd0;
   else
      if (clkdiv_reg_comm)
         clkdiv <= wr_data[15:0];
end

always @(negedge clk && ~CPOL && CPHA) // mode 1
begin
	if (rst)
      clkdiv <= 16'd0;
   else
      if (clkdiv_reg_comm)
         clkdiv <= wr_data[15:0];
end

always @(negedge clk && CPOL && ~CPHA) // mode 2
begin
   if (rst)
      clkdiv <= 16'd0;
   else
      if (clkdiv_reg_comm)
         clkdiv <= wr_data[15:0];
end

always @(posedge clk && CPOL && CPHA) // mode 3
begin
	if (rst)
      clkdiv <= 16'd0;
   else
      if (clkdiv_reg_comm)
         clkdiv <= wr_data[15:0];
end


//A regiszterb�l visszaolvashat� �rt�k.
wire [31:0] clkdiv_reg_dout = {16'd0, clkdiv};


//******************************************************************************
//* Olvas�si multiplexer.                                                      *
//******************************************************************************
wire [1:0] rd_sel;

assign rd_sel[0] = ctrl_reg_comm_rd;
assign rd_sel[1] = clkdiv_reg_comm_rd;

always @(*)
begin
   case (rd_sel)
      2'b01: rd_data <= ctrl_reg_comm_rd;
      2'b10: rd_data <= clkdiv_reg_comm_rd;
      default  : rd_data <= 32'd0;
   endcase
end

always @(posedge i_Clk or negedge rst)
begin
	if (~rst)
	begin
		spi_MOSI     <= 1'b0;
	end
end


//******************************************************************************
//* SPI AMBA APB transzmitter.                                                 *
//******************************************************************************
spi_transmitter spi_transmitter_i(
   //�rajel �s reset.
   .clk(clk),                          //Rendszer�rajel
   .rst(rst),                          //Akt�v magas szinkron reset
   
   //Ad�s enged�lyez�s.
   .enable(comm),
   
   //�rajel oszt�s.
   .clk_div(clkdiv),

   //Soros adat kimenet
   .spi_MOSI(spi_MOSI)
);


endmodule

`default_nettype wire