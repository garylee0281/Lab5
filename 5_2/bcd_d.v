`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:28:14 08/26/2015 
// Design Name: 
// Module Name:    bcd_d 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bcd_d(
    display, // 14-segment display output
	bcd // BCD input
	);
	output [14:0] display; // SSD display output
	input [3:0] bcd; // BCD input
	reg [14:0] display; // SSD display output (in always)
	// Combinational logics:
	always @(bcd)
		case (bcd)
			4'd0: display = 15'b0000_0011_1111_111; //0
			4'd1: display = 15'b1111_1111_1011_011; //1
			4'd2: display = 15'b0010_0100_1111_111; //2
			4'd3: display = 15'b0000_1100_1111_111; //3
			4'd4: display = 15'b1001_1000_1111_111; //4
			4'd5: display = 15'b0100_1000_1111_111; //5
			4'd6: display = 15'b0100_0000_1111_111; //6
			4'd7: display = 15'b0001_1111_1111_111; //7
			4'd8: display = 15'b0000_0000_1111_111; //8
			4'd9: display = 15'b0000_1000_1111_111; //9
			default: display = 15'b1111_1111_1111_111; //DEF
		endcase


endmodule
