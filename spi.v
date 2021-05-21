`timescale 1ns / 1ps
`default_nettype none

//******************************************************************************
//* Az SPI funkciót megvalósító modul.                                         *
//******************************************************************************

module spi(
   //Órajel és reset.
   input  wire                 clk,            //Rendszerórajel
   input  wire                 rst,            //Aktív magas szinkron reset
   
   input  wire [15:0]          rw_addr,       //Írás-olvasás cím

   //Regiszter írási interfész.
   input  wire                 wr_en,          //Írás engedélyezõ jel
   input  wire [31:0]          wr_data,        //Írási adat
   input  wire [3:0]           wr_strb,        //Bájt engedélyezõ jelek
    
   //Regiszter olvasási interfész.
   input  wire                 rd_en,          //Olvasás engedélyezõ jel
   output reg  [31:0]          rd_data,        //Olvasási adat
   
   //SPI adatvonalak.
   input  wire                 spi_miso,       //Soros bemenet, rxd
   output reg                  spi_mosi,       //Soros kimenet, txd
   output wire                 spi_sck,        //SPI órajel
   output reg  [3:0]           spi_cs,         //chip/slave select

   //Megszakításkérõ kimenet.
   output reg                  irq

);

//******************************************************************************
//* Vezérlõ regiszter.                  BÁZIS+0x00, 32 bites, írható/olvasható *
//******************************************************************************
wire ctrl_reg_wr = wr_en & (rw_addr == 16'd0) & (wr_strb == 4'b1111);
wire ctrl_reg_rd = rd_en & (rw_addr == 16'd0);

// SPI engedélyezés
reg spi_en;
always  @(posedge clk)
begin
    if (rst)
        spi_en <= 1'b0;
    else if (ctrl_reg_wr)
        spi_en <= wr_data[0];
end

wire [31:0]ctrl_reg_dout = {31'd0, spi_en};

//******************************************************************************
//* Órajel osztás regiszter.            BÁZIS+0x04, 32 bites, írható/olvasható *
//* baud rate = f_sysclk / (16 * (CLKDIV + 1))                                 *
//******************************************************************************
wire clkdiv_reg_wr = wr_en & (rw_addr == 16'd4) & (wr_strb == 4'b1111);
wire clkdiv_reg_rd = wr_en & (rw_addr == 16'd4);

//Órajel osztás (0 - 15. bitek).
reg [15:0] clkdiv;

always @(posedge clk)
begin
   if (rst)
      clkdiv <= 16'd0;
   else
      if (clkdiv_reg_wr)
         clkdiv <= wr_data[15:0];
end

//A regiszterbõl visszaolvasható érték.
wire [31:0] clkdiv_reg_dout = {16'd0, clkdiv};

//******************************************************************************
//* SPI üzemmód regiszter.              BÁZIS+0x08, 32 bites, írható/olvasható *
//******************************************************************************
wire mode_reg_wr = wr_en & (rw_addr == 16'd8);
wire mode_reg_rd = rd_en & (rw_addr == 16'd8);

reg CPHA;
reg CPOL;

always @(posedge clk)
begin
    if (rst)
	 begin
        CPHA <= 1'b0;
        CPOL <= 1'b0;
	 end
	 else if (mode_reg_wr)
	 begin
		  CPHA <= wr_data[0];
		  CPOL <= wr_data[1];
	 end
end

wire [31:0] mode_reg_dout = {30'd0, CPOL, CPHA};

//******************************************************************************
//* SPI státusz regiszter.              BÁZIS+0x0C, 32 bites, olvasható        *
//******************************************************************************
wire status_reg_rd = rd_en & (rw_addr == 16'd12);

reg tx_exists;

wire [31:0] status_reg_dout = {31'd0, tx_exists};

//******************************************************************************
//* Adatregiszter.                      BÁZIS+0x10, 32 bites, írható/olvasható *
//******************************************************************************
wire data_reg_wr = wr_en & (rw_addr == 16'd16) & (wr_strb == 4'b1111);
wire data_reg_rd = rd_en & (rw_addr == 16'd16);

reg [7:0] data;

always @(posedge clk)
begin
    if (rst)
        data <= 1'd0;
    else if (data_reg_wr)
        data <= wr_data[7:0];
end

//A regiszterbõl visszaolvasható érték.
wire [31:0] data_reg_dout = {24'd0, data};


//******************************************************************************
//* Megszakítás eng. reg.               BÁZIS+0x14, 32 bites, írható/olvasható *
//******************************************************************************
wire ie_reg_wr = wr_en & (rw_addr == 16'd20) & (wr_strb == 4'b1111);
wire ie_reg_rd = rd_en & (rw_addr == 16'd20);

//FIFO státusz megszakítások engedélyezése (0 - 3. bitek).
reg ie_reg;

always @(posedge clk)
begin
   if (rst)
      ie_reg <= 1'd0;
   else
      if (ie_reg_wr)
         ie_reg <= wr_data[0];
end

//A regiszterbõl visszaolvasható érték.
wire [31:0] ie_reg_dout = {31'd0, ie_reg};

//Az aktív magas szintérzékeny megszakításkérõ kimenet meghajtása.
always @(posedge clk)
begin
   irq <= |(status_reg_dout & ie_reg);
end

//******************************************************************************
//* Chip select regiszter               BÁZIS+0x18, 32 bites, írható/olvasható *
//******************************************************************************
wire cs_reg_wr = wr_en & (rw_addr == 16'd24) & (wr_strb == 4'b1111);
wire cs_reg_rd = rd_en & (rw_addr == 16'd24);

reg cs_reg [3:0];

// csak külön-külön lehet értéket adni:
/*
always @(posedge clk) 
begin
    if (rst)
        cs_reg[0] <= 1'd0;
    else
        if (cs_reg_wr)
            cs_reg[0] <= wr_data[0];
end
*/
genvar i;
generate
   for (i = 0; i < 3; i = i + 1)
   begin: reg_loop
		always @(posedge clk) 
		begin
			if (rst)
				cs_reg[i] <= 1'd0;
			else
			if (cs_reg_wr)
            cs_reg[i] <= wr_data[i];
		end
	end
endgenerate

wire [31:0] cs_reg_dout = {28'd0, cs_reg[3], cs_reg[2], cs_reg[1], cs_reg[0]};

//******************************************************************************
//* Olvasási multiplexer.                                                      *
//******************************************************************************
wire [6:0] rd_sel;

assign rd_sel[0] = ctrl_reg_rd;
assign rd_sel[1] = clkdiv_reg_rd;
assign rd_sel[2] = mode_reg_rd;
assign rd_sel[3] = status_reg_rd;
assign rd_sel[4] = data_reg_rd;
assign rd_sel[5] = ie_reg_rd;
assign rd_sel[6] = cs_reg_rd;


always @(*)
begin
   case (rd_sel)
      7'b0000001: rd_data <= ctrl_reg_dout;
      7'b0000010: rd_data <= clkdiv_reg_dout;
      7'b0000100: rd_data <= mode_reg_dout;
      7'b0001000: rd_data <= status_reg_dout;
      7'b0010000: rd_data <= data_reg_dout;
      7'b0100000: rd_data <= ie_reg_dout;
      7'b1000000: rd_data <= cs_reg_dout;
      default  :  rd_data <= 32'd0;
   endcase
end

//******************************************************************************
//* Chip select állapotgép.                                                    *
//******************************************************************************

reg [2:0] state;
localparam RESET    = 3'd0;
localparam IDLE     = 3'd1;
localparam LOAD     = 3'd2;
localparam TRANSACT = 3'd3;
localparam UNLOAD   = 3'd4;

reg [7:0]  txbuf;
reg [7:0]  rxbuf;
reg        txc;

reg [3:0]  sck_counter;
reg        spi_sck_r;
reg        spi_mosi_r;
reg        spi_miso_r;
reg [15:0] clk_counter;

assign spi_sck = spi_sck_r;

always @(posedge clk) 
begin
    if (rst)
    begin
        spi_cs <= 4'b1111;
        spi_mosi <= 1'b0;
        state <= RESET;
        rxbuf <= 8'd0;
        txbuf <= 8'd0;
        sck_counter <= 4'd0;
        txc <= 1'b0;            // TODO kell?
    end
    else
    case (state)
        RESET: 
        begin
            state <= IDLE;
            sck_counter <= 4'd0;
        end
        IDLE: 
        begin
            spi_sck_r <= CPOL;
            spi_mosi_r <= 1'b0;
            rxbuf <= rxbuf;
            txbuf <= txbuf;
            sck_counter <= 4'd0;
            txc <= 1'b0;
            if (spi_en)
                state <= LOAD;
            else    
                state <= IDLE;
        end
        LOAD: 
        begin
            spi_en <= 1'b0;
            spi_cs <= ~{cs_reg[3], cs_reg[2], cs_reg[1], cs_reg[0]};
            spi_sck_r <= CPOL;
            if (CPOL == 1 && CPHA == 1)
            begin
                sck_counter <= 4'd9;
            end
            else
            begin
                sck_counter <= 4'd8;
            end

            rxbuf <= rxbuf;
            txbuf <= data;
            state <= TRANSACT;
            txc <= 1'b0;
            clk_counter <= 16'b0;
            if (!CPHA)
            begin
                spi_mosi = txbuf[7];
                txbuf = {txbuf[6:0], 1'b0};
            end
            else
                spi_mosi <= 1'b0;
        end
        TRANSACT: 
        begin
            spi_cs <= ~{cs_reg[3], cs_reg[2], cs_reg[1], cs_reg[0]};
            spi_en <= 1'b0;
            spi_mosi <= spi_mosi_r;

            txc <= 1'b0;
            if (sck_counter == 4'd0)
                state <= UNLOAD;
            else
                state <= TRANSACT;
        end
        UNLOAD: 
        begin
            data <= rxbuf;
            txc <= 1'b1;
            spi_cs <= 4'b1111;
            spi_mosi <= 1'b0;
            txbuf <= txbuf;
            if (spi_en)
                state <= LOAD;
            else
                state <= IDLE;
        end
        default: 
        begin
            state <= IDLE;
            txc <= 1'b0;
        end
    endcase
end

// SPI órajel
always @(posedge clk) 
begin
    if (state == TRANSACT)    
    begin
        if (clk_counter >= clkdiv)
        begin
           clk_counter <= 16'b0;
           spi_sck_r <= ~spi_sck_r;
        end
        else
            clk_counter <= clk_counter + 1;
    end
end

always @(posedge spi_sck) 
begin
    if (~CPHA)
        sck_counter <= sck_counter - 1;    
end

always @(negedge spi_sck) 
begin
    if (CPHA)
        sck_counter <= sck_counter - 1;
end

//MOSI shiftregiszter

always @(posedge spi_sck) 
begin
    if (CPOL == CPHA)
    begin
        spi_mosi_r = txbuf[7];
        txbuf <= {txbuf[6:0], 1'b0};
    end
end

always @(negedge spi_sck) 
begin
    if (CPOL != CPHA)
    begin
        spi_mosi_r = txbuf[7];
        txbuf <= {txbuf[6:0], 1'b0};
    end
end

always @(negedge spi_cs[0] or negedge spi_cs[1] or negedge spi_cs[2] or negedge spi_cs[3]) // CS aktív
begin
    if (CPHA)
    begin
        spi_mosi_r = txbuf[7];
        txbuf <= {txbuf[6:0], 1'b0};
    end
end

//MISO shiftregiszter

always @(posedge spi_sck) 
begin
    if (CPOL == CPHA)
    begin
        rxbuf <= {rxbuf[6:0], spi_miso};
    end
end

always @(negedge spi_sck) 
begin
    if (CPOL != CPHA)
    begin
        rxbuf = {rxbuf[6:0], spi_miso};
    end
end

// IRQ
always @(posedge clk) 
begin
    irq <= |(txc && ie_reg);
end

endmodule

`default_nettype wire