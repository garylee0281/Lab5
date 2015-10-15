`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:00 08/26/2015 
// Design Name: 
// Module Name:    Lab5_3 
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
module Lab5_3(
   input clk,
	//input rst_n,
	input sel,
	input in,
	//input [1:0]sel,
	output [3:0] ftsd_ctl,
	output [14:0] display,
	output [14:0] LED,
	//output sel_out
	output mode
    );
	wire [3:0] bcd;
	wire [1:0] clk_ctl;
	reg [3:0] in0, in1, in2, in3;
	//wire [3:0] in0, in1, in2, in3;
	wire clk_out;//counter and fsm
	wire sel_out;//for counter stop or start
	wire [3:0] out0, out1, out2, out3;
	wire clk_debounce;
	wire pb_debounced;
	wire fsm_in;
	wire rst_n;
	wire a;
	wire mode;
	wire trigger_mode;
	wire fsm_in_mode;
	assign a=1'b1;
	/*always@(*)begin
	if(sel==2'b00)
	begin
	 in0=4'd0;
	 in1=4'd0;
	 in2=4'd1;
	 in3=4'd5;
	end
	else if(sel==2'b01)
	begin 
	 in0=4'd0;
	 in1=4'd0;
	 in2=4'd3;
	 in3=4'd0;
	end 
	else if(sel==2'b10) begin
	 in0=4'd0;
	 in1=4'd1;
	 in2=4'd0;
	 in3=4'd0;
	 end
	else
	begin
	 in0=4'd0;
	 in1=4'd5;
	 in2=4'd0;
	 in3=4'd0;
	end
	end*/
	always@(*)
	begin
		if(mode==1'b0)
		begin
		in0=4'd0;
		in1=4'd0;
		in2=4'd3;
		in3=4'd0;
		end
		else
		begin
		in0=4'd0;
		in1=4'd1;
		in2=4'd0;
		in3=4'd0;
		end
	end
freq_divider f1(
	.clk_out(clk_out),//for counter
	.clk_ctl(clk_ctl), // divided clock output
	.clk_150(clk_debounce),//for 150HZ
	.clk(clk), // global clock input
	.rst_n(a) // active low reset
	);
Fsm fl(
	.clk(clk),
	.rst(rst_n),
	.sel_out(sel_out),
	.in(fsm_in)
);
bcd_d b1( 
	.display(display), // 14-segment display output
	.bcd(bcd) // BCD input
	);
	
count c1(
	.clk(clk_out),
	.sel_in(sel_out),
	.in0(in0),
	.in1(in1),
	.in2(in2),
	.in3(in3),
	.out0(out0),
	.out1(out1),
	.out2(out2),
	.out3(out3),
	.rst(rst_n),
	.LED(LED)
);
scanf s1(
	.ftsd_ctl(ftsd_ctl), // ftsd display control signal 
	.ftsd_in(bcd), // output to ftsd display
	.in0(out0), // 1st input
	.in1(out1), // 2nd input
	.in2(out2), // 3rd input
	.in3(out3), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
	);
debounce dl(
.clk(clk_debounce), // clock control
.rst_n(a), // reset
.pb_in(in), //push button input
.pb_debounced(pb_debounced) // debounced push button output
);
Pause_one one(
.clk(clk), // clock input
.rst_n(rst_n), //active low reset
.in_trig(pb_debounced), // input trigger
.out_pulse(fsm_in) // output one pulse
);
reset( 
 .clk(clk_out),
 .in_trigger(~in),
 .reset_out(rst_n)
    );
	 
debounce_mode dm1(
.clk(clk_debounce), // clock control
.rst_n(a), // reset
.pb_in(sel), //push button input
.pb_debounced(trigger_mode) // debounced push button output
);
one_pause_mode opm1(
.clk(clk), // clock input
.rst_n(rst_n), //active low reset
.in_trig(trigger_mode), // input trigger
.out_pulse(fsm_in_mode) // output one pulse
);
fsm_mode fm1(
   .rst(rst_n),
	.clk(clk),
	.sel_out(mode),
	.in(fsm_in_mode)
    );
endmodule
