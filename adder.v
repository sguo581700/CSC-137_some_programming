//Sen Guo
// adder.v, 137 Verilog Programming Assignment #3

module TestMod;                     	// the "main" thing
   parameter STDIN = 32'h8000_0000; 	// I/O address of keyboard input channel

   reg [7:0] str [1:3]; 				// typing in 2 chars at a time (decimal # and Enter key)
   reg [4:0] X, Y;      				// 5-bit X, Y to sum
   wire [4:0] S;        				// 5-bit Sum to see as result
   wire C5;             				// like to know this as well from result of adder


   FullAdder_5_bits adder5b(X,Y,S,C5);

   initial begin                 //main starts here
   		$display("Enter X: ");
   		str[1] = $fgetc(STDIN);
         str[2] = $fgetc(STDIN);
         str[3] = $fgetc(STDIN);    //empty input for enter
         X = (str[1] - 48)*10 + str[2]-48;

         $display("Enter Y: ");
         str[1] = $fgetc(STDIN);
         str[2] = $fgetc(STDIN);
         str[3] = $fgetc(STDIN);   //empty input for enter
         Y = (str[1] - 6'd48)*6'd10 + str[2]-6'd48;

         #1;

   		$display("X =%d (%b)  Y =%d (%b)", X,X,Y,Y);
         $display("Result = %d (%b) C5 = %d",S,S,C5);
   end
endmodule

module FullAdder_5_bits(X, Y, S, C5);
   input [4:0]X, Y;
   output [4:0] S;
   output C5;

   wire [0:4]c_t;
   assign c_t[0] = 0;
   FullAdder adder_0(c_t[0], X[0], Y[0], c_t[1], S[0]);
   FullAdder adder_1(c_t[1], X[1], Y[1], c_t[2], S[1]);
   FullAdder adder_2(c_t[2], X[2], Y[2], c_t[3], S[2]);
   FullAdder adder_3(c_t[3], X[3], Y[3], c_t[4], S[3]);
   FullAdder adder_4(c_t[4], X[4], Y[4], C5, S[4]);
endmodule

module FullAdder(Ci, X, Y, Co, Sum);
   input Ci, X, Y;
   output Co, Sum;

   Digit_SumMod ds(X,Y,Ci, Sum);
   CarryMod ca(X,Y,Ci, Co);
endmodule

module Digit_SumMod(Ci, X, Y, Sum); //K-map for digit sum
   input Ci, X, Y;
   output Sum;

   wire xorResultXY;
   xor(xorResultXY, X, Y);
   xor(Sum, xorResultXY, Ci);
endmodule

module CarryMod(Ci, X, Y, Co);    //K-map for carry
   input Ci, X, Y;
   output Co;

   wire[0:2] and_o;
   and(and_o[0], X,Y);
   and(and_o[1], X,Ci);
   and(and_o[2], Y,Ci);
   or(Co, and_o[0], and_o[1], and_o[2]);
endmodule
   

