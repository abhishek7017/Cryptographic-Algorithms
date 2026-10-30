`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2026 22:37:30
// Design Name: 
// Module Name: AES_round
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


module AES_round(
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
            
       reg [7:0] round_const[0:3][0:3];
      initial
      begin
	     round_const[0][0] = 8'd2;   //
             round_const[0][1] = 8'd3;   //
             round_const[0][2] = 8'd1;
	     round_const[0][3] = 8'd1;
	     round_const[1][0] = 8'd1;
	     round_const[1][1] = 8'd2; //
	     round_const[1][2] = 8'd3; //
	     round_const[1][3] = 8'd1;
	     round_const[2][0] = 8'd1;
	     round_const[2][1] = 8'd1;
	     round_const[2][2] = 8'd2; //
	     round_const[2][3] = 8'd3; //
	     round_const[3][0] = 8'd3; //
	     round_const[3][1] = 8'd1;
	     round_const[3][2] = 8'd1;
	     round_const[3][3] = 8'd2; //
        end
	     
	integer x,y,z;
	reg [15:0] sum;
	reg [7:0] cout [0:3][0:3];
    /*   always @(*)    // Mix column
       begin
           
           for ( z = 0 ; z < 16 ; z = z + 4 )
           begin
                 for ( x = 0; x < 4 ; x = x + 1)
		       begin
			      sum =0;
			       for ( y = 0 ; y < 4 ; y = y + 1)
			      begin
			         sum = sum ^ (round_const[x][y] * shift_rows_matrix[y+z]);
			      end
                  cout[z+x] = sum;
		       end
		   end     	
	end
			 
     */         
      reg [7:0] temp_shift_reg,temp_xor_reg;
	always @(*)    // Mix column
       begin
           
           for ( z = 0 ; z < 4 ; z = z + 1 )
           begin
                 for ( x = 0; x < 4 ; x = x + 1)
		       begin
			      sum =0;
			      
			       for ( y = 0 ; y < 4 ; y = y + 1)
			      begin
				     temp_shift_reg = 0;
				     temp_xor_reg = 0;

				   if ( round_const[x][y] == 2) 
				   begin
					 if(transpose_matrix_1[z][y] & 8'h80) 
					 begin
					     temp_shift_reg = transpose_matrix_1[z][y] << 1;	 
			                     sum = sum ^ (temp_shift_reg ^ 8'h1B);
				          end
					  else
					  begin
					     sum = sum ^ (transpose_matrix_1[z][y] << 1);
					  end
			           end
				   else if( round_const[x][y] == 3)
				   begin
					   if( transpose_matrix_1[z][y] & 8'h80)
					   begin
						  temp_shift_reg = transpose_matrix_1[z][y] << 1;
						  temp_xor_reg = temp_shift_reg ^ 8'h1B;
                                                  sum = sum ^ ( temp_xor_reg ^ transpose_matrix_1[z][y]);
                                           end
					   else
					   begin
                                                   temp_shift_reg = transpose_matrix_1[z][y] << 1;
                                                   sum = sum ^ ( temp_shift_reg ^ transpose_matrix_1[z][y]);
					   end
				   end
				   else
				   begin
                                                  sum = sum ^ (round_const[x][y] * transpose_matrix_1[z][y]);
                                   end
			      end 
                        cout[z][x] = sum;
		       end
		   end     	
	end
         wire [7:0]output_mix_column[15:0];

	  assign {output_mix_column[15],output_mix_column[14],output_mix_column[13],output_mix_column[12]} = {cout[0][0],cout[0][1], cout[0][2], cout[0][3]};
     assign {output_mix_column[11],output_mix_column[10],output_mix_column[9],output_mix_column[8]} = {cout[1][0],cout[1][1], cout[1][2], cout[1][3]};
     assign {output_mix_column[7],output_mix_column[6],output_mix_column[5],output_mix_column[4]} = {cout[2][0],cout[2][1], cout[2][2], cout[2][3]};
     assign {output_mix_column[3],output_mix_column[2],output_mix_column[1],output_mix_column[0]} = {cout[3][0],cout[3][1], cout[3][2], cout[3][3]};    

     wire [7:0]output_stage_matrix[15:0];
          genvar j;                // add round key
	   generate
		   for ( j = 0 ; j < 16; j = j + 1)
		   begin
                        
                         assign  output_stage_matrix[j] = output_mix_column[j] ^ key[7+8*j : 8*j];
		   end
	   endgenerate
     assign output_state_matrix = { output_stage_matrix[15],output_stage_matrix[14],output_stage_matrix[13],output_stage_matrix[12],output_stage_matrix[11],
                               output_stage_matrix[10],output_stage_matrix[9],output_stage_matrix[8],output_stage_matrix[7],output_stage_matrix[6],
	 		       output_stage_matrix[5],output_stage_matrix[4],output_stage_matrix[3],output_stage_matrix[2],output_stage_matrix[1],output_stage_matrix[0] };

		       endmodule
