`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Abhishek Borate
// Create Date: 29.10.2026 11:03:30
// Design Name: AES 128 Encryption and Decryption
// Module Name: AES_decryption_top
// Project Name: AES_128 Decryption
// Target Devices: 
// Tool Versions: Vivado 2023.1 
// Description: Verilog HDL implementation of the AES-128 decryption algorithm with a 128-bit ciphertext input and a 128-bit secret key, producing a 128-bit plaintext output.
//               Includes InvSubBytes, InvShiftRows, InvMixColumns, AddRoundKey, and Key Expansion transformations for FPGA-based hardware implementation. 
//////////////////////////////////////////////////////////////////////////////////


module AES_decryption_top(
input [127:0]cipher_text,
input [127:0]key,
output [127:0]data_text
    );

       wire [31:0]word[0:43];
       wire [31:0]new_word[1:10];
       wire [127:0] key_out_i[0:10];
       wire [7:0]Rcon[1:10];
     
      genvar i;
      generate
	      for (i  = 0; i <= 10 ; i =  i + 1) 
	      begin 
	             if( i == 0)
		     begin
                          assign word[4*i] = key[127:96];
			  assign word[4*i+1] = key[95:64];
			  assign word[4*i+2] = key[63:32];
			  assign word[4*i+3] = key[31:0];
	             end
                     else
	                begin
			  if( i == 1) 
				  assign Rcon[i] = 8'b1;
			  else if ( i == 9)
				  assign Rcon[i] = 8'h1B;
			  else
				  assign Rcon[i] = Rcon[i-1] * 2;
	             	  g_function g1(
        			 .word_1(word[4*i-1]),
         		 	 .round_value(Rcon[i]),
         		 	 .word_out(new_word[i]));

       			  assign word[4*i] = word[4*i-4] ^ new_word[i];
       			  assign word[4*i+1] = word[4*i] ^ word[4*i-3];
       		 	  assign word[4*i+2] = word[4*i +1] ^ word[4*i-2];
       			  assign word[4*i+3] = word[4*i + 2] ^ word[4*i-1];
		        end
		  assign key_out_i[i] = { word[4*i],word[4*i+1],word[4*i+2],word[4*i+3] };
	     end
     endgenerate
  
     wire [127:0] state_matrix_round[0:10]; 
     assign state_matrix_round[0] = cipher_text ^ key_out_i[10];  // pre round transformation
    
       genvar n;
     generate
	     for ( n = 1 ; n < 10 ; n = n + 1)
	     begin
		   AES_decryption_round a2(.state_matrix(state_matrix_round[n-1]),.key(key_out_i[10-n]),.state_output_matrix(state_matrix_round[n]));
	     end
     endgenerate


    AES_decryption_final_round a4(.state_matrix(state_matrix_round[9]),.key(key_out_i[0]),.state_output_matrix(data_text)); 
    



endmodule
