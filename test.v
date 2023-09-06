module test

(
input wire sys_clk,
input wire sys_rst_n,
input wire IRIG_B,

output wire [6:0]second,
output wire [6:0]minute,
output wire [5:0]hour,
output wire [9:0]day,
output wire [7:0]year
);
reg IRIG_B1;
wire pos;
wire neg;
reg [19:0]cnt_10ms;
reg [1:0]decoder;
reg [3:0]state;
reg [6:0]cnt_1s;
parameter IDIE = 4'b0000;
parameter p = 4'b1111;
parameter sec = 4'b0001;
parameter min = 4'b0010;
parameter hou = 4'b0011;
parameter da = 4'b0100;
parameter da1 = 4'b0101;
parameter yea = 4'b0110;
parameter s0 = 4'b0111;
parameter s1 = 4'b1000;
parameter s2 = 4'b1001;
parameter s3 = 4'b1010;

parameter cnt_10ms_p = 20'd1000000;
parameter cnt_10ms_0 = 20'd250000;
parameter cnt_10ms_1 = 20'd625000;


always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				IRIG_B1 <= 1'b0;
			else
				IRIG_B1 <= IRIG_B;
				

assign pos = IRIG_B & ~IRIG_B1;			
assign neg = ~IRIG_B & IRIG_B1;

always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_10ms <= 20'd0;
			else if(neg == 1'b1)
				cnt_10ms <= 20'd0;
			else if(IRIG_B == 1'b1)
				cnt_10ms <= cnt_10ms + 20'd1;
			else 
				cnt_10ms <= cnt_10ms;
				
				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				decoder <= 2'b00;
			else if(cnt_10ms == cnt_10ms_p && neg == 1'b1)
				decoder <= 2'b11;
			else if(cnt_10ms == cnt_10ms_0 && neg == 1'b1)
				decoder <= 2'b00;
			else if(cnt_10ms == cnt_10ms_1 && neg == 1'b1)
				decoder <= 2'b01;
			else
				decoder <= decoder;
				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				state <= IDIE;
			else
				case (state)
					IDIE :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= p;
						else
							state <= IDIE;
					p :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= sec;
						else
							state <= p;
					sec :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= min;
						else
							state <= sec;
					min :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= hou;
						else
							state <= min;
					hou :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= da;
						else
							state <= hou;
					da :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= da1;
						else
							state <= da;
					da1 :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= yea;
						else
							state <= da1;
					yea :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= s0;
						else
							state <= yea;
					s0 :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= s1;
						else
							state <= s0;
					s1 :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= s2;
						else
							state <= s1;
					s2 :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= s3;
						else
							state <= s2;
					s3 :
						if(decoder == 2'b11 && pos == 1'b1)
							state <= p;
						else
							state <= s3;
					default : state <= IDIE;
				endcase
							
			
			
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				cnt_1s <= 7'd0;
			else if(cnt_1s == 7'd99 && pos == 1'b1)
				cnt_1s <= 7'd0;
			else if(state == IDIE && pos == 1'b1)
				cnt_1s <= 7'd0;
			else if(pos == 1'b1)
				cnt_1s <= cnt_1s + 7'd1;
			else
				cnt_1s <= cnt_1s;

				
				
				
				
				
				
				
				
				
				
				
				
//output wire second,
//output wire minute,
//output wire hour,
//output wire day,
//output wire year				
				
				

reg [6:0]second_data;
reg [6:0]minute_data;
reg [5:0]hour_data;
reg [9:0]day_data;
reg [7:0]year_data;

always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				second_data <= 7'd0;
			else if(cnt_1s == 7'd1)
				second_data[0] <= decoder[0];
			else if(cnt_1s == 7'd2)
				second_data[1] <= decoder[0];
			else if(cnt_1s == 7'd3)
				second_data[2] <= decoder[0];
			else if(cnt_1s == 7'd4)
				second_data[3] <= decoder[0];
			else if(cnt_1s == 7'd6)
				second_data[4] <= decoder[0];
			else if(cnt_1s == 7'd7)
				second_data[5] <= decoder[0];
			else if(cnt_1s == 7'd8)
				second_data[6] <= decoder[0];
			else 
				second_data <= second_data;
				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				minute_data <= 7'd0;
			else if(cnt_1s == 7'd10)
				minute_data[0] <= decoder[0];
			else if(cnt_1s == 7'd11)
				minute_data[1] <= decoder[0];
			else if(cnt_1s == 7'd12)
				minute_data[2] <= decoder[0];
			else if(cnt_1s == 7'd13)
				minute_data[3] <= decoder[0];
			else if(cnt_1s == 7'd15)
				minute_data[4] <= decoder[0];
			else if(cnt_1s == 7'd16)
				minute_data[5] <= decoder[0];
			else if(cnt_1s == 7'd17)
				minute_data[6] <= decoder[0];
			else
				minute_data <= minute_data;


always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				hour_data <= 6'd0;
			else if(cnt_1s == 7'd20)
				hour_data[0] <= decoder[0];
			else if(cnt_1s == 7'd21)
				hour_data[1] <= decoder[0];
			else if(cnt_1s == 7'd22)
				hour_data[2] <= decoder[0];
			else if(cnt_1s == 7'd23)
				hour_data[3] <= decoder[0];
			else if(cnt_1s == 7'd25)
				hour_data[4] <= decoder[0];
			else if(cnt_1s == 7'd26)
				hour_data[5] <= decoder[0];
			else
				hour_data <= hour_data;


always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				day_data <= 10'd0;
			else if(cnt_1s == 7'd30)
				day_data[0] <= decoder[0];
			else if(cnt_1s == 7'd31)
				day_data[1] <= decoder[0];
			else if(cnt_1s == 7'd32)
				day_data[2] <= decoder[0];
			else if(cnt_1s == 7'd33)
				day_data[3] <= decoder[0];
			else if(cnt_1s == 7'd35)
				day_data[4] <= decoder[0];
			else if(cnt_1s == 7'd36)
				day_data[5] <= decoder[0];
			else if(cnt_1s == 7'd37)
				day_data[6] <= decoder[0];
			else if(cnt_1s == 7'd38)
				day_data[7] <= decoder[0];
			else if(cnt_1s == 7'd40)
				day_data[8] <= decoder[0];
			else if(cnt_1s == 7'd41)
				day_data[9] <= decoder[0];
			else
				day_data <= day_data;


				
always @(posedge sys_clk or negedge sys_rst_n)
			if(sys_rst_n == 1'b0)
				year_data <= 8'd0;
			else if(cnt_1s == 7'd50)
				year_data[0] <= decoder[0];
			else if(cnt_1s == 7'd51)
				year_data[1] <= decoder[0];
			else if(cnt_1s == 7'd52)
				year_data[2] <= decoder[0];
			else if(cnt_1s == 7'd53)
				year_data[3] <= decoder[0];
			else if(cnt_1s == 7'd55)
				year_data[4] <= decoder[0];
			else if(cnt_1s == 7'd56)
				year_data[5] <= decoder[0];
			else if(cnt_1s == 7'd57)
				year_data[6] <= decoder[0];
			else if(cnt_1s == 7'd58)
				year_data[7] <= decoder[0];
			else
				year_data <= year_data;				

assign second[6:0]= second_data[6:4]*4'd10 + second_data[3:0];
assign minute[6:0]= minute_data[6:4]*4'd10 + minute_data[3:0];
assign hour  [5:0]= hour_data[5:4]*4'd10 + hour_data[3:0];
assign day   [9:0]= day_data[9:8]*7'd100 + day_data[7:4]*4'd10 + day_data[3:0];
assign year  [7:0]= year_data[7:4]*4'd10 + year_data[3:0];












	


endmodule
