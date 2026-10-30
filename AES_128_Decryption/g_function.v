`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Abhishek Borate
// Create Date: 29.10.2026 11:03:30
// Design Name: AES 128 Encryption and Decryption
// Module Name: g_function
// Project Name: AES_128 Decryption
// Tool Versions: Vivado 2023.1 
// Description: Verilog HDL implementation of the AES-128 decryption algorithm with a 128-bit ciphertext input and a 128-bit secret key, producing a 128-bit plaintext output.
//               Includes InvSubBytes, InvShiftRows, InvMixColumns, AddRoundKey, and Key Expansion transformations for FPGA-based hardware implementation. 
//////////////////////////////////////////////////////////////////////////////////


module g_function(
input [31:0] word_1,
input [7:0]round_value,
output [31:0] word_out
    );
   reg [31:0]temp_reg;
   wire [7:0]dataout_i[3:0];
   wire [7:0] row_high,row_low,column_high,column_low,data_index;

   genvar i;
   generate 
	   for ( i = 0 ; i < 4 ; i = i + 1)
	   begin
		   S_box s1 ( .row(temp_reg[(7+8*i) : (4+8*i)]),.column(temp_reg[3+8*i : 8*i]),.dataout(dataout_i[i]));
	   end
   endgenerate


    always @(*)
    begin
        temp_reg = { word_1[23:16],word_1[15:8],word_1[7:0],word_1[31:24] };
    end
assign word_out = {dataout_i[3],dataout_i[2],dataout_i[1],dataout_i[0]} ^ { round_value,8'b00,8'b00,8'b00} ;


endmodule
