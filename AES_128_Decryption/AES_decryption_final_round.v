`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 11:16:38
// Design Name: 
// Module Name: AES_decryption_final_round
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


module AES_decryption_final_round(
input [127:0] state_matrix,
input [127:0] key,
output [127:0] state_output_matrix
    );
 wire [7:0]dataout_i[15:0];
	wire [7:0] shift_rows_matrix[15:0];
   /*  genvar i;
     generate
	     for( i  = 0 ;  i < 16 ; i = i + 1)  // subBytes
	     begin
		     S_box s1 ( .row(state_matrix[(7+8*i) : (4+8*i)]),.column(state_matrix[3+8*i : 8*i]),.dataout(dataout_i[i]));
	     end
     endgenerate

     genvar r,t;
    
     generate     
	     for ( r = 0 ; r < 4 ; r = r + 1)
	     begin
		   for ( t = 0 ; t < 4 ; t = t + 1)
		   begin
			  assign array_matrix[r][t] = dataout_i[15 - (4*r + t)];
		   end
	      end
      endgenerate  */
      wire [7:0]array_matrix[0:3][0:3];
     assign array_matrix[0][0] = state_matrix[127:120];
assign array_matrix[0][1] = state_matrix[119:112];
assign array_matrix[0][2] = state_matrix[111:104];
assign array_matrix[0][3] = state_matrix[103:96];
assign array_matrix[1][0] = state_matrix[95:88];
assign array_matrix[1][1] = state_matrix[87:80];
assign array_matrix[1][2] = state_matrix[79:72];
assign array_matrix[1][3] = state_matrix[71:64];
assign array_matrix[2][0] = state_matrix[63:56];
assign array_matrix[2][1] = state_matrix[55:48];
assign array_matrix[2][2] = state_matrix[47:40];
assign array_matrix[2][3] = state_matrix[39:32];
assign array_matrix[3][0] = state_matrix[31:24];
assign array_matrix[3][1] = state_matrix[23:16];
assign array_matrix[3][2] = state_matrix[15:8];
assign array_matrix[3][3] = state_matrix[7:0];
    
     genvar g,h;
     wire [7:0] transpose_matrix[0:3][0:3];
      generate    
	     for ( g = 0 ; g < 4 ; g = g + 1)
	     begin
		   for ( h = 0 ; h < 4 ; h = h + 1)
		   begin
			  assign transpose_matrix[g][h] = array_matrix[h][g];
		   end
	      end
      endgenerate	     

            // shift rows
     assign {shift_rows_matrix[15],shift_rows_matrix[14],shift_rows_matrix[13],shift_rows_matrix[12]} = {transpose_matrix[0][0],transpose_matrix[0][1], transpose_matrix[0][2], transpose_matrix[0][3]};
     assign {shift_rows_matrix[11],shift_rows_matrix[10],shift_rows_matrix[9],shift_rows_matrix[8]} = {transpose_matrix[1][3],transpose_matrix[1][0], transpose_matrix[1][1], transpose_matrix[1][2]};
     assign {shift_rows_matrix[7],shift_rows_matrix[6],shift_rows_matrix[5],shift_rows_matrix[4]} = {transpose_matrix[2][2],transpose_matrix[2][3], transpose_matrix[2][0], transpose_matrix[2][1]};
     assign {shift_rows_matrix[3],shift_rows_matrix[2],shift_rows_matrix[1],shift_rows_matrix[0]} = {transpose_matrix[3][1],transpose_matrix[3][2], transpose_matrix[3][3], transpose_matrix[3][0]};

      genvar s,d;
     wire [7:0]array_matrix_1[0:3][0:3];
     generate     
	     for ( s = 0 ; s < 4 ; s = s + 1)
	     begin
		   for ( d = 0 ; d < 4 ; d = d + 1)
		   begin
			  assign array_matrix_1[s][d] = shift_rows_matrix[15 - (4*s + d)];
		   end
	      end
      endgenerate
    
     genvar u,v;
     wire [7:0] transpose_matrix_1[0:3][0:3];
      generate    
	     for ( u = 0 ; u < 4 ; u = u + 1)
	     begin
		   for ( v = 0 ; v < 4 ; v = v + 1)
		   begin
			  assign transpose_matrix_1[u][v] = array_matrix_1[v][u];
		   end
	      end
      endgenerate
 
     wire [127:0] input_to_inverse_subbytes;
assign input_to_inverse_subbytes = {
    transpose_matrix_1[0][0],
    transpose_matrix_1[0][1],
    transpose_matrix_1[0][2],
    transpose_matrix_1[0][3],
    transpose_matrix_1[1][0],
    transpose_matrix_1[1][1],
    transpose_matrix_1[1][2],
    transpose_matrix_1[1][3],
    transpose_matrix_1[2][0],
    transpose_matrix_1[2][1],
    transpose_matrix_1[2][2],
    transpose_matrix_1[2][3],
    transpose_matrix_1[3][0],
    transpose_matrix_1[3][1],
    transpose_matrix_1[3][2],
    transpose_matrix_1[3][3]
};    wire [7:0] inverse_subbytes_matrix[15:0];
    genvar i;    // Inverse Subbytes
   generate
	  for ( i = 0 ; i < 16 ; i = i + 1)
	  begin
                  inverse_s_box s1( .row(input_to_inverse_subbytes[7+8*i :4+8*i]),.column(input_to_inverse_subbytes[3+8*i:8*i]),.dataout(inverse_subbytes_matrix[i]));
          end
  endgenerate
      
  wire [7:0]add_round_key_matrix[15:0];
          genvar w;                // add round key
	   generate
		   for ( w = 0 ; w < 16; w = w + 1)
		   begin
                        
                         assign  add_round_key_matrix[w] = inverse_subbytes_matrix[w] ^ key[7+8*w : 8*w];
		   end
	   endgenerate

	 assign state_output_matrix = { add_round_key_matrix[15],add_round_key_matrix[14],add_round_key_matrix[13],add_round_key_matrix[12],add_round_key_matrix[11],
                                     add_round_key_matrix[10],add_round_key_matrix[9],add_round_key_matrix[8],add_round_key_matrix[7],add_round_key_matrix[6],
		                     add_round_key_matrix[5],add_round_key_matrix[4],add_round_key_matrix[3],add_round_key_matrix[2],add_round_key_matrix[1],
				     add_round_key_matrix[0]};   
          
    endmodule
	
