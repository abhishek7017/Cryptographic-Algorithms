`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2026 00:43:16
// Design Name: 
// Module Name: AES_final_round
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


module AES_final_round(
  input [127:0]state_matrix,
  input [127:0]key,
  output [127:0]output_state_matrix
    );


        wire [7:0]dataout_i[15:0];
	wire [7:0] shift_rows_matrix[15:0];
     genvar i;
     generate
	     for( i  = 0 ;  i < 16 ; i = i + 1)  // subBytes
	     begin
		     S_box s1 ( .row(state_matrix[(7+8*i) : (4+8*i)]),.column(state_matrix[3+8*i : 8*i]),.dataout(dataout_i[i]));
	     end
     endgenerate

     genvar r,t;
     wire [7:0]array_matrix[0:3][0:3];
     generate     
	     for ( r = 0 ; r < 4 ; r = r + 1)
	     begin
		   for ( t = 0 ; t < 4 ; t = t + 1)
		   begin
			  assign array_matrix[r][t] = dataout_i[15 - (4*r + t)];
		   end
	      end
      endgenerate
    
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
     assign {shift_rows_matrix[11],shift_rows_matrix[10],shift_rows_matrix[9],shift_rows_matrix[8]} = {transpose_matrix[1][1],transpose_matrix[1][2], transpose_matrix[1][3], transpose_matrix[1][0]};
     assign {shift_rows_matrix[7],shift_rows_matrix[6],shift_rows_matrix[5],shift_rows_matrix[4]} = {transpose_matrix[2][2],transpose_matrix[2][3], transpose_matrix[2][0], transpose_matrix[2][1]};
     assign {shift_rows_matrix[3],shift_rows_matrix[2],shift_rows_matrix[1],shift_rows_matrix[0]} = {transpose_matrix[3][3],transpose_matrix[3][0], transpose_matrix[3][1], transpose_matrix[3][2]};

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

      wire [7:0]output_shift_matrix[15:0];

	  assign {output_shift_matrix[15],output_shift_matrix[14],output_shift_matrix[13],output_shift_matrix[12]} = {transpose_matrix_1[0][0],transpose_matrix_1[0][1], transpose_matrix_1[0][2], transpose_matrix_1[0][3]};
     assign {output_shift_matrix[11],output_shift_matrix[10],output_shift_matrix[9],output_shift_matrix[8]} = {transpose_matrix_1[1][0],transpose_matrix_1[1][1], transpose_matrix_1[1][2], transpose_matrix_1[1][3]};
     assign {output_shift_matrix[7],output_shift_matrix[6],output_shift_matrix[5],output_shift_matrix[4]} = {transpose_matrix_1[2][0],transpose_matrix_1[2][1], transpose_matrix_1[2][2], transpose_matrix_1[2][3]};
     assign {output_shift_matrix[3],output_shift_matrix[2],output_shift_matrix[1],output_shift_matrix[0]} = {transpose_matrix_1[3][0],transpose_matrix_1[3][1], transpose_matrix_1[3][2], transpose_matrix_1[3][3]};
 
     wire [7:0]output_stage_matrix[15:0];
          genvar j;                // add round key
	   generate
		   for ( j = 0 ; j < 16; j = j + 1)
		   begin
                        
                         assign  output_stage_matrix[j] = output_shift_matrix[j] ^ key[7+8*j : 8*j];
		   end
	   endgenerate
     assign output_state_matrix = { output_stage_matrix[15],output_stage_matrix[14],output_stage_matrix[13],output_stage_matrix[12],output_stage_matrix[11],
                               output_stage_matrix[10],output_stage_matrix[9],output_stage_matrix[8],output_stage_matrix[7],output_stage_matrix[6],
	 		       output_stage_matrix[5],output_stage_matrix[4],output_stage_matrix[3],output_stage_matrix[2],output_stage_matrix[1],output_stage_matrix[0] };

		       endmodule
   





       
    

