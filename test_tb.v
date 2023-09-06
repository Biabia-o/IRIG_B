`timescale 1ns/1ns
module test_tb();

reg sys_clk;
reg sys_rst_n;
reg IRIG_B;

  wire [6:0]second;
  wire [6:0]minute;
  wire [5:0]hour;
  wire [9:0]day;
  wire [7:0]year;


initial begin

sys_clk = 1'b0;
sys_rst_n = 1'b0;
IRIG_B = 1'b0;
#16
sys_rst_n = 1'b1;


end

always #4 sys_clk = ~sys_clk;



wire [7:0]mem[0:99];

assign mem[0] = 8'h70; //p
//second
assign mem[1] = 8'h70; //p
assign mem[2] = 8'h30; //0
assign mem[3] = 8'h30; //0
assign mem[4] = 8'h30; //0
assign mem[5] = 8'h31; //1
assign mem[6] = 8'h30; //0
assign mem[7] = 8'h31; //1
assign mem[8] = 8'h30; //0
assign mem[9] = 8'h31; //1
assign mem[10] = 8'h70; //p
//minute
assign mem[11] = 8'h30; //0
assign mem[12] = 8'h31; //1
assign mem[13] = 8'h31; //1
assign mem[14] = 8'h30; //0
assign mem[15] = 8'h30; //0
assign mem[16] = 8'h30; //0
assign mem[17] = 8'h30; //0
assign mem[18] = 8'h31; //1
assign mem[19] = 8'h30; //0
assign mem[20] = 8'h70; //p
//hour
assign mem[21] = 8'h30; //0
assign mem[22] = 8'h30; //0
assign mem[23] = 8'h31; //1
assign mem[24] = 8'h30; //0
assign mem[25] = 8'h30; //0
assign mem[26] = 8'h31; //1
assign mem[27] = 8'h30; //0
assign mem[28] = 8'h30; //0
assign mem[29] = 8'h30; //0
assign mem[30] = 8'h70; //p
//day1
assign mem[31] = 8'h31; //1
assign mem[32] = 8'h31; //1
assign mem[33] = 8'h31; //1
assign mem[34] = 8'h30; //0
assign mem[35] = 8'h30; //0
assign mem[36] = 8'h30; //0
assign mem[37] = 8'h30; //0
assign mem[38] = 8'h31; //1
assign mem[39] = 8'h30; //0
assign mem[40] = 8'h70; //p
//day2
assign mem[41] = 8'h30; //0
assign mem[42] = 8'h31; //1
assign mem[43] = 8'h30; //0
assign mem[44] = 8'h30; //0
assign mem[45] = 8'h30; //0
assign mem[46] = 8'h30; //0
assign mem[47] = 8'h30; //0
assign mem[48] = 8'h30; //0
assign mem[49] = 8'h30; //0
assign mem[50] = 8'h70; //p
//year
assign mem[51] = 8'h31; //1
assign mem[52] = 8'h31; //1
assign mem[53] = 8'h30; //0
assign mem[54] = 8'h30; //0
assign mem[55] = 8'h30; //0
assign mem[56] = 8'h30; //0
assign mem[57] = 8'h31; //1
assign mem[58] = 8'h30; //0
assign mem[59] = 8'h30; //0
assign mem[60] = 8'h70; //p
//s0
assign mem[61] = 8'h31; //1
assign mem[62] = 8'h31; //1
assign mem[63] = 8'h30; //0
assign mem[64] = 8'h30; //0
assign mem[65] = 8'h30; //0
assign mem[66] = 8'h30; //0
assign mem[67] = 8'h31; //1
assign mem[68] = 8'h30; //0
assign mem[69] = 8'h30; //0
assign mem[70] = 8'h70; //p
//s1
assign mem[71] = 8'h31; //1
assign mem[72] = 8'h31; //1
assign mem[73] = 8'h30; //0
assign mem[74] = 8'h30; //0
assign mem[75] = 8'h30; //0
assign mem[76] = 8'h30; //0
assign mem[77] = 8'h31; //1
assign mem[78] = 8'h30; //0
assign mem[79] = 8'h30; //0
assign mem[80] = 8'h70; //p
//s2
assign mem[81] = 8'h31; //1
assign mem[82] = 8'h31; //1
assign mem[83] = 8'h30; //0
assign mem[84] = 8'h30; //0
assign mem[85] = 8'h30; //0
assign mem[86] = 8'h30; //0
assign mem[87] = 8'h31; //1
assign mem[88] = 8'h30; //0
assign mem[89] = 8'h30; //0
assign mem[90] = 8'h70; //p
//s3
assign mem[91] = 8'h31; //1
assign mem[92] = 8'h31; //1
assign mem[93] = 8'h30; //0
assign mem[94] = 8'h30; //0
assign mem[95] = 8'h30; //0
assign mem[96] = 8'h30; //0
assign mem[97] = 8'h31; //1
assign mem[98] = 8'h30; //0
assign mem[99] = 8'h70; //p


parameter IDIE = 5'b00001;
parameter s0 = 5'b00010;
parameter s1 = 5'b00100;
parameter s2 = 5'b01000;
parameter s3 = 5'b10000;


parameter max_10ms = 21'd1249999;
parameter max_8ms = 21'd999999;
parameter max_5ms = 21'd624999;
parameter max_2ms = 21'd249999;
parameter max_1s = 7'd99;


reg [4:0]state;
reg [6:0]cnt_1000ms;
reg [20:0]cnt_10ms;


always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_1000ms <= 7'd0;
			else if(cnt_1000ms == max_1s)
				cnt_1000ms <= 7'd0;
			else if(state == s3)
				cnt_1000ms <= cnt_1000ms + 7'd1;
			else
				cnt_1000ms <= cnt_1000ms;

				
				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_10ms <= 21'd0;
			else if(cnt_10ms == max_10ms)
				cnt_10ms <= 21'd0;
			else if(state == s0 || state == s1 || state == s2)
				cnt_10ms <= cnt_10ms + 21'd1;
			else
				cnt_10ms <= 21'd0;
				
	

always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				state <= IDIE;
			else
				case(state)
					IDIE :
						if(mem[cnt_1000ms]==8'h70)
							state <= s0;
						else if(mem[cnt_1000ms]==8'h31)
							state <= s1;
						else if(mem[cnt_1000ms]==8'h30)
							state <= s2;
						else
							state <= state;
					s0 :
						if(cnt_10ms == max_10ms)
							state <= s3;
						else
							state <= state;
					s1 :
						if(cnt_10ms == max_10ms)
							state <= s3;
						else
							state <= state;
					s2 :
						if(cnt_10ms == max_10ms)
							state <= s3;
						else
							state <= state;
					s3 :
							state <= IDIE;
					default : state <= IDIE;
				endcase






always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				IRIG_B <= 1'b0;
			else if(state == s0)
				begin
					if(cnt_10ms <= max_8ms)
						IRIG_B <= 1'b1;
					else
						IRIG_B <= 1'b0;
				end
			else if(state == s1)
				begin
					if(cnt_10ms <= max_5ms)
						IRIG_B <= 1'b1;
					else
						IRIG_B <= 1'b0;
				end
			else if(state == s2)
				begin
					if(cnt_10ms <= max_2ms)
						IRIG_B <= 1'b1;
					else
						IRIG_B <= 1'b0;
				end
			else
				IRIG_B <= IRIG_B;
			

test test
(
. sys_clk(sys_clk),
. sys_rst_n(sys_rst_n),
. IRIG_B(IRIG_B),

. second(second),
. minute(minute),
. hour(hour),
. day(day),
. year(year)
);
endmodule
