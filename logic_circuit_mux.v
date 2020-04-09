
// Sen Guo
//Logic Circuit and Mux

module TestMod;

	input [7:0]A;
	input [7:0]B;
	output [7:0]y;
	reg [2:0] s;
	assign A = 8'b11001010;
	assign B = 8'b01101001;
	integer i;

		mux_8bit mx(A,B,s,y);

	initial begin

		#1;
		$monitor("%b  %b", s, y);
		for (i=0; i<8;i++) begin
			s<=i; #1;
		end
	end
endmodule


module mux_1bit(A, B, s, y);
	input [2:0] s;
	input A, B;
	wire w_0, w_1, w_2, w_3, w_4, w_5, w_6, w_7;
	output y;
	wire [2:0] inv_s;
	wire [0:7] o;
	not(inv_s[2], s[2]);
	not(inv_s[1], s[1]);
	not(inv_s[0], s[0]);

	and and_AB(w_0, A,B);
	or or_AB(w_1,A,B);
	xor xor_AB(w_2, A,B);
	not not_A(w_3, A);
	nor nor_AB(w_4, A,B);
	xnor xnor_AB(w_5, A,B);
	not not_B (w_6, B);
	nand nand_AB(w_7, A, B);

	and(o[0], inv_s[2], inv_s[1], inv_s[0], w_0);
	and(o[1], inv_s[2], inv_s[1], s[0], w_1);
	and(o[2], inv_s[2], s[1], inv_s[0], w_2);
	and(o[3], inv_s[2], s[1], s[0], w_3);
	and(o[4], s[2], inv_s[1], inv_s[0], w_4);
	and(o[5], s[2], inv_s[1], s[0], w_5);
	and(o[6], s[2], s[1], inv_s[0], w_6);
	and(o[7], s[2], s[1], s[0], w_7);

	or(y, o[0], o[1],o[2],o[3],o[4],o[5],o[6],o[7]);
endmodule

module mux_8bit(A,B,s,y);
	input [7:0]A;
	input [7:0]B;
	output [7:0]y;
	input [2:0]s;
genvar i;
generate
for (i=7; i>=0;i=i-1) begin : gen_loop	
	mux_1bit mux(A[i], B[i], s, y[i]); 
end
endgenerate
endmodule
