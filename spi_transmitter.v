`timescale 1ns / 1ps
`default_nettype none


//******************************************************************************
//* SPI adó modul.                                                             *
//******************************************************************************
module spi_transmitter(
   //Órajel és reset.
   input  wire        clk,             //Rendszerórajel
   input  wire        rst,             //Aktív magas szinkron reset
   
   //Adás engedélyezés.
   input  wire        enable,
	input  wire        ready,
	
	//Periféria kiválasztó
	input  wire        PSELx,
   
   //Órajel osztás.
   input  wire [15:0] clk_div,
   
   //Vonali kódolás.
   input  wire [1:0]  data_bits,       //Adatbitek száma
   input  wire        par_enable,      //Paritás engedélyezés
   input  wire [1:0]  par_type,        //Paritás típusa
   input  wire        stop_bits,       //Stop bitek száma

   //Soros adat kimenet
   output wire        spi_MOSI
);

//******************************************************************************
//* Baud rate generátor.                                                       *
//******************************************************************************
reg  [19:0] clkdiv_cnt;
wire        clkdiv_en;
wire        clkdiv_cnt_tc = (clkdiv_cnt == 20'd0);

always @(posedge clk)
begin
   if ((clkdiv_en == 0) || clkdiv_cnt_tc)
      clkdiv_cnt <= {clk_div, 4'b1111};
   else
      clkdiv_cnt <= clkdiv_cnt - 20'd1;
end

//******************************************************************************
//* Paritás generátor.                                                         *
//******************************************************************************
//Az adatméret alapján a nem használt bitek maszkolása.
reg [7:0] parity_mask;

always @(*)
begin
   case (data_bits)
      2'b00  : parity_mask <= 8'b0001_1111;     //5 bit
      2'b10  : parity_mask <= 8'b0011_1111;     //6 bit
      2'b01  : parity_mask <= 8'b0111_1111;     //7 bit
      default: parity_mask <= 8'b1111_1111;     //8 bit
   endcase
end

//A maszkolt adatbitek XOR kapcsolata. Párosra egészíti ki az 1 bitek számát.
wire parity = ^(parity_mask);

//A paritásbit elõállítása a vonali kódolási beállítások alapján.
reg parity_out;

always @(*)
begin
   case ({par_enable, par_type})
      3'b100 : parity_out <=  parity;           //Páros paritás
      3'b101 : parity_out <= ~parity;           //Páratlan paritás
      3'b110 : parity_out <=  1'b0;             //Konstans 0
      3'b111 : parity_out <=  1'b1;             //Konstans 1
      default: parity_out <=  1'b1;             //Nincs engedélyezve
   endcase
end


//******************************************************************************
//* Adási shiftregiszter.                                                      *
//******************************************************************************
//Adási shiftregiszter.
reg  [9:0] MOSI_shr;
wire       MOSI_shr_ld;
wire       MOSI_shr_en;

always @(posedge clk)
begin
   if (rst)
      MOSI_shr <= 10'b11_1111_1111;
   else
      if (MOSI_shr_ld)
         MOSI_shr <= MOSI_shr_din;
      else
         if (MOSI_shr_en)
            MOSI_shr <= {1'b1, MOSI_shr[9:1]};
end

assign spi_MOSId = MOSI_shr[0];

//Bitszámláló.
reg  [3:0] bitcnt;
wire       bitcnt_tc = (bitcnt == 4'd0);

always @(posedge clk)
begin
   if (MOSI_shr_ld)
      case ({stop_bits, par_enable, data_bits})
         4'b0_0_00: bitcnt <= 4'd6;    //1 START + 5 adat + 0 paritás + 1 STOP =  7 bit
         4'b0_0_01: bitcnt <= 4'd7;    //1 START + 6 adat + 0 paritás + 1 STOP =  8 bit
         4'b0_0_10: bitcnt <= 4'd8;    //1 START + 7 adat + 0 paritás + 1 STOP =  9 bit
         4'b0_0_11: bitcnt <= 4'd9;    //1 START + 8 adat + 0 paritás + 1 STOP = 10 bit
         4'b0_1_00: bitcnt <= 4'd7;    //1 START + 5 adat + 1 paritás + 1 STOP =  8 bit
         4'b0_1_01: bitcnt <= 4'd8;    //1 START + 6 adat + 1 paritás + 1 STOP =  9 bit
         4'b0_1_10: bitcnt <= 4'd9;    //1 START + 7 adat + 1 paritás + 1 STOP = 10 bit
         4'b0_1_11: bitcnt <= 4'd10;   //1 START + 8 adat + 1 paritás + 1 STOP = 11 bit
         4'b1_0_00: bitcnt <= 4'd7;    //1 START + 5 adat + 0 paritás + 2 STOP =  8 bit
         4'b1_0_01: bitcnt <= 4'd8;    //1 START + 6 adat + 0 paritás + 2 STOP =  9 bit
         4'b1_0_10: bitcnt <= 4'd9;    //1 START + 7 adat + 0 paritás + 2 STOP = 10 bit
         4'b1_0_11: bitcnt <= 4'd10;   //1 START + 8 adat + 0 paritás + 2 STOP = 11 bit
         4'b1_1_00: bitcnt <= 4'd8;    //1 START + 5 adat + 1 paritás + 2 STOP =  9 bit
         4'b1_1_01: bitcnt <= 4'd9;    //1 START + 6 adat + 1 paritás + 2 STOP = 10 bit
         4'b1_1_10: bitcnt <= 4'd10;   //1 START + 7 adat + 1 paritás + 2 STOP = 11 bit
         default  : bitcnt <= 4'd11;   //1 START + 8 adat + 1 paritás + 2 STOP = 12 bit
      endcase
   else
      if (MOSI_shr_en)
         bitcnt <= bitcnt - 4'd1;
end

//******************************************************************************
//* Vezérlõ állapotgép.                                                        *
//******************************************************************************
localparam IDLE   = 2'd0;
localparam SETUP  = 2'd1;
localparam ACCESS = 2'd2;

reg [1:0] MOSI_state;

always @(posedge clk)
begin
   if (rst)
      MOSI_state <= IDLE;
   else
      case (MOSI_state)
         //Várakozás az engedélyezettségre, a transferra és a PSELx-re.
         IDLE: if (enable && PSELx && MOSI_shr_en)
                     MOSI_state <= SETUP;
                  else
                     MOSI_state <= IDLE;

         //Setup állapot.
         SETUP: MOSI_state <= ACCESS;
         
         //Az adás végrehajtása.
			// PREADY = 1, van transfer
         ACCESS: if (clkdiv_cnt_tc && bitcnt_tc && ready && MOSI_shr_en)
                     MOSI_state <= SETUP;
                  else // PREADY = 0
							if (~ready)
								MOSI_state <= ACCESS;
							else // PREADY = 1, nincs transfer
								if (clkdiv_cnt_tc && bitcnt_tc && ready && ~MOSI_shr_en)
									MOSI_state <= IDLE;
         //Érvénytelen állapotok.
         default: MOSI_state <= IDLE;
      endcase
end

//A baud rate generátor engedélyezõ jele.
assign clkdiv_en  = (MOSI_state == ACCESS);
//Az adási shiftregiszter és a bitszámláló betöltõ jele.
assign MOSI_shr_ld  = (MOSI_state == SETUP);
//Az adási shiftregiszter és a bitszámláló engedélyezõ jele.
assign MOSI_shr_en  = (MOSI_state == ACCESS) & clkdiv_cnt_tc;

endmodule

`default_nettype wire
