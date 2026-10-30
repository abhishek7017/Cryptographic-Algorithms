`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2026 14:23:40
// Design Name: 
// Module Name: Key_expansion_algorithm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Key_expansion_algorithm(
input [127:0]key,
output [127:0]key_out
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

  assign key_out = {word[40],word[41],word[42],word[43]}; 
endmodule
