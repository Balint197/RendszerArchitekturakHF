`timescale 1ns / 1ps
`default_nettype none

module spi_top_test;

	// Inputs
	reg apb_clk;
	reg apb_rst;
	reg [31:0] PWDATA;
	reg PREADY;
	reg spi_miso;

	// Outputs
	wire PADDR;
	wire PWRITE;
	wire [31:0] PRDATA;
	wire PSEL;
	wire PENABLE;
	wire [3:0] STRB;
	wire spi_mosi;
	wire spi_sck;
	wire [3:0] spi_cs;
	wire irq;

	// Instantiate the Unit Under Test (UUT)
	spi_top uut (
		.apb_clk(apb_clk), 
		.apb_rst(apb_rst), 
		.PADDR(PADDR), 
		.PWRITE(PWRITE), 
		.PWDATA(PWDATA), 
		.PRDATA(PRDATA), 
		.PSEL(PSEL), 
		.PENABLE(PENABLE), 
		.PREADY(PREADY), 
		.STRB(STRB), 
		.spi_miso(spi_miso), 
		.spi_mosi(spi_mosi), 
		.spi_sck(spi_sck), 
		.spi_cs(spi_cs), 
		.irq(irq),
		.rw_addr(rw_addr),
		.wr_en(wr_en),
		.rd_en(rd_en)
	);


//AMBA APB 32 bites írási taszk.
task apb_write32(input [15:0] addr, input [31:0] data);
begin
    @(posedge apb_clk);
    PADDR   = addr;
    PWDATA  = data;
    PWRITE  = 1'b1;
    PSEL    = 1'b1;
    STRB    = 4'b1111;
    @(posedge apb_clk);
    PENABLE = 1'b1;
    @(posedge apb_clk);
    PSEL    = 1'b0;
    PENABLE = 1'b0;
    $display("%t: SPI write - address=0x%h, data=0x%h", $time, addr, data);
end
endtask

//AMBA APB 32 bites olvasási taszk.
task apb_read32(input [15:0] addr, output [31:0] data);
begin
    @(posedge apb_clk);
    PADDR   = addr;
    PSEL    = 1'b1;
    PWRITE  = 1'b0;
    STRB    = 4'b0000;
    @(posedge apb_clk);
    PENABLE = 1'b1;
    @(posedge apb_clk);
    PSEL    = 1'b0;
    PENABLE = 1'b0;
    #1 data = PRDATA;
    $display("%t: SPI write - address=0x%h, data=0x%h", $time, addr, data);
end
endtask


	initial begin
		// Initialize Inputs
		assign spi_miso = spi_mosi;
        apb_clk  = 0;
		apb_rst  = 0;
        PADDR    = 0;
        PENABLE  = 0;
        PWRITE   = 0;
		PWDATA   = 0;
		PREADY   = 0;
        PSEL     = 0;
        PSTRB    = 0;
        spi_miso = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10;
		apb_rst = 1'b1;
		#10;

        // Regiszterek beállítása
        apb_write32(16'd4, 32'd1);          // Órajelosztó
        apb_write32(16'd20, 32'd1);         // Interrupt - enable

        // 1. test
        apb_write32(16'd8, 32'b00);         // Üzemmód - CPOL = 0, CPHA = 0
        apb_write32(16'd16, 32'b1001_0001); // Adatregiszter
        apb_write32(16'd24, 32'd1);         // Chip/Slave Select - 2
        apb_write32(16'd0, 32'd1);          // Start
        @(negedge irq);                     // interrupt-ra várakozás
        apb_read32(16'd16, data);          // Visszaolvasás

        // 2. test
        apb_write32(16'd8, 32'b01);         // Üzemmód - CPOL = 0, CPHA = 1
        apb_write32(16'd16, 32'b1010_1001); // Adatregiszter
        apb_write32(16'd0, 32'd1);          // Start
        @(negedge irq);                     // interrupt-ra várakozás
        apb_read32(16'd16, data);          // Visszaolvasás

        // 3. test
        apb_write32(16'd8, 32'b10);         // Üzemmód - CPOL = 1, CPHA = 0
        apb_write32(16'd16, 32'b1110_1011); // Adatregiszter
        apb_write32(16'd0, 32'd1);          // Start
        @(negedge irq);                     // interrupt-ra várakozás
        apb_read32(16'd16, data);          // Visszaolvasás

        // 4. test
        apb_write32(16'd8, 32'b11);         // Üzemmód - CPOL = 1, CPHA = 1
        apb_write32(16'd16, 32'b1010_1111); // Adatregiszter
        apb_write32(16'd0, 32'd1);          // Start
        @(negedge irq);                     // interrupt-ra várakozás
        apb_read32(16'd16, data);           // Visszaolvasás


	end

// Órajel generálása - 10 MHz
always
begin
   #50;
   apb_clk <= ~apb_clk;
end



endmodule

`default_nettype wire