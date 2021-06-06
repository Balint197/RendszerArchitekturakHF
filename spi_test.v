`timescale 1ns / 1ps
`default_nettype none

module spi_test;

	// Inputs
	reg clk;
	reg rst;
	reg [15:0] rw_addr;
	reg wr_en;
	reg [31:0] wr_data;
	reg [3:0] wr_strb;
	reg rd_en;
	reg spi_miso;

	// Outputs
	wire [31:0] rd_data;
	wire spi_mosi;
	wire spi_sck;
	wire [3:0] spi_cs;
	wire irq;

	// Instantiate the Unit Under Test (UUT)
	spi uut (
		.clk(clk), 
		.rst(rst), 
		.rw_addr(rw_addr), 
		.wr_en(wr_en), 
		.wr_data(wr_data), 
		.wr_strb(wr_strb), 
		.rd_en(rd_en), 
		.rd_data(rd_data), 
		.spi_miso(spi_miso), 
		.spi_mosi(spi_mosi), 
		.spi_sck(spi_sck), 
		.spi_cs(spi_cs), 
		.irq(irq)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		rw_addr = 0;
		wr_en = 0;
		wr_data = 0;
		wr_strb = 0;
		rd_en = 0;
		spi_miso = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10;
		rst = 1'b1;
		#10;
		rst = 1'b0; // TODO nem kell teljesbe
		#500;
		wr_en = 1'b1;
		wr_strb = 4'b1111;
		
		#500
		rw_addr = 16'd4;
		wr_data = 32'd1; // Órajelosztó
		# 400;
		
      rw_addr = 16'd20;
		wr_data = 32'd1; // Interrupt - enable
		# 400;
		
		rw_addr = 16'd8;
		wr_data = 32'b00; // üzemmód - CPOL = 0, CPHA = 0
		# 400;
		
		rw_addr = 16'd16;
		wr_data = 32'b1001_0001; // Adatregiszter
		# 400;
		
		rw_addr = 16'd24;
		wr_data = 32'd2; // Chip/Slave select
		# 400; 

		rw_addr = 16'd0;
		wr_data = 32'd1; // Start
		# 400; 
	end
      
// órajel generálása - 5 MHz
always
begin
   #100;
   clk <= ~clk;
end

endmodule

`default_nettype wire