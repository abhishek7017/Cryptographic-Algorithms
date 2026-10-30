`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Abhishek Borate
// Create Date: 26.10.2026 18:03:45
// Design Name: AES_128 Encryption and Decryption
// Module Name: AES_top
// Project Name: AES_128 Encryption
// Tool Versions: Vivado 2023.1
// Description:  Verilog HDL implementation of the AES-128 encryption algorithm with a 128-bit plaintext input and a 128-bit secret key,
                 producing a 128-bit ciphertext output.Includes SubBytes, ShiftRows, MixColumns, AddRoundKey, 
                  and Key Expansion transformations for FPGA-based hardware implementation.
///////////////////////////////////////////////////////////

module AES_top(
input [127:0]data_text,
input [127:0]key,
output [127:0]cipher_text
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
    	    
    assign state_matrix_round[0] = data_text ^ key_out_i[0];  // pre round transformation

     

    
     genvar m;
     generate
	     for ( m = 1 ; m < 10 ; m = m + 1)
	     begin
                   AES_round a1(.state_matrix(state_matrix_round[m-1]),.key(key_out_i[m]),.output_state_matrix(state_matrix_round[m]));
	     end
     endgenerate

     AES_final_round a2(.state_matrix(state_matrix_round[9]),.key(key_out_i[10]),.output_state_matrix(cipher_text));

    
endmodule
