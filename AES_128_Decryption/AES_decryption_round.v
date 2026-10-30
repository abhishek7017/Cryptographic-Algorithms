`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Abhishek Borate
// Create Date: 29.10.2026 11:03:30
// Design Name: AES 128 Encryption and Decryption
// Module Name: AES_decryption_round
// Project Name: AES_128 Decryption
// Tool Versions: Vivado 2023.1 
// Description: Verilog HDL implementation of the AES-128 decryption algorithm with a 128-bit ciphertext input and a 128-bit secret key, producing a 128-bit plaintext output.
//               Includes InvSubBytes, InvShiftRows, InvMixColumns, AddRoundKey, and Key Expansion transformations for FPGA-based hardware implementation. 
//////////////////////////////////////////////////////////////////////////////////

module AES_decryption_round(
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
          
     genvar j,k;
     wire [7:0]array_matrix_2[0:3][0:3];
     generate     
	     for ( j = 0 ; j < 4 ; j = j + 1)
	     begin
		   for ( k = 0 ; k < 4 ; k = k + 1)
		   begin
			  assign array_matrix_2[j][k] = add_round_key_matrix[15 - (4*j + k)];
		   end
	      end
      endgenerate

     reg [7:0] inverse_rcons[0:3][0:3];

     initial
     begin
	     inverse_rcons[0][0] = 8'hE;
	     inverse_rcons[0][1] = 8'hB;
	     inverse_rcons[0][2] = 8'hD;
	     inverse_rcons[0][3] = 8'h9;
	     inverse_rcons[1][0] = 8'h9;
	     inverse_rcons[1][1] = 8'hE;
	     inverse_rcons[1][2] = 8'hB;
	     inverse_rcons[1][3] = 8'hD;
	     inverse_rcons[2][0] = 8'hD;
	     inverse_rcons[2][1] = 8'h9;
	     inverse_rcons[2][2] = 8'hE;
	     inverse_rcons[2][3] = 8'hB;
	     inverse_rcons[3][0] = 8'hB;
	     inverse_rcons[3][1] = 8'hD;
	     inverse_rcons[3][2] = 8'h9;
	     inverse_rcons[3][3] = 8'hE;
      end  
       integer x,y,z;
       reg [7:0]temp_shift_reg_2;
       reg [7:0]temp_shift_reg_4;
       reg [7:0]temp_shift_reg_8;
       reg [7:0]temp_xor_reg_2,temp_xor_reg_4,temp_xor_reg_8;
       reg [7:0]sum;
       reg [7:0]cout[0:3][0:3];
  
      always @(*)      //  inverse_mix_column
      begin

	     for ( z = 0 ; z < 4 ; z = z + 1)
	     begin 
	       for ( x = 0 ; x < 4 ; x = x + 1)
	       begin
		     sum = 0;
		    for ( y = 0 ; y < 4 ; y = y + 1)
		    begin
			  //sum =sum ^ (inverse_rcons[x][y] ^ inverse_subbytes_matrix[z+y];
			temp_shift_reg_2 = 8'h0;
	    		temp_shift_reg_4 =8'h0;
	      		temp_shift_reg_8 =8'h0;
	      		temp_xor_reg_2 =8'h0;
	      		temp_xor_reg_4 =8'h0;
	     	        temp_xor_reg_8 =8'h0;				  
			  if ( inverse_rcons[x][y] == 8'h0E)
				  begin
                                         if( array_matrix_2[z][y] & 8'h80)
					 begin

					  	temp_shift_reg_2 =array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h1B;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;
					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_2 ^ temp_xor_reg_4 ^ temp_xor_reg_8);
				         end
					 else
					 begin
                                                temp_shift_reg_2 = array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h00;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;

					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_2 ^ temp_xor_reg_4 ^ temp_xor_reg_8);
				         end
                                    end
				  else if( inverse_rcons[x][y] == 8'h0B)
				  begin
                                             
                                       if(array_matrix_2[z][y] & 8'h80)
					 begin

					  	temp_shift_reg_2 = array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h1B;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;
					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_8 ^ temp_xor_reg_2 ^array_matrix_2[z][y]);
				         end
					 else
					 begin
                                                temp_shift_reg_2 = array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h00;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;

					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_8 ^ temp_xor_reg_2 ^ array_matrix_2[z][y]);
				         end
				 end
				   else if( inverse_rcons[x][y] == 8'h0D)
				   begin
                                           if( array_matrix_2[z][y] & 8'h80)
					 begin

					  	temp_shift_reg_2 =array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h1B;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;
					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_8 ^ temp_xor_reg_4 ^ array_matrix_2[z][y]);
				         end
					 else
					 begin
                                                temp_shift_reg_2 =array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h00;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;

					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_8 ^ temp_xor_reg_4 ^ array_matrix_2[z][y]);
				         end
                                       end					 
					 else if( inverse_rcons[x][y] == 8'h09)
				      begin
                                          	   if( array_matrix_2[z][y] & 8'h80)
					 begin

					  	temp_shift_reg_2 = array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h1B;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;
					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_8 ^ array_matrix_2[z][y]);
				         end
					 else
					 begin
                                                temp_shift_reg_2 =array_matrix_2[z][y] << 1;
				          	temp_xor_reg_2 = temp_shift_reg_2 ^ 8'h00;
				          	if ( temp_xor_reg_2 & 8'h80)
					 	 begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
					          	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h1B;
					  	end
				          	else
					   	begin
					          	temp_shift_reg_4 = temp_xor_reg_2 << 1;
						  	temp_xor_reg_4 = temp_shift_reg_4 ^ 8'h0;
				           	end
					   	if( temp_xor_reg_4 & 8'h80)
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
						   	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h1B;

					   	end
					   	else
					   	begin
						   	temp_shift_reg_8 = temp_xor_reg_4 << 1;
					           	temp_xor_reg_8 = temp_shift_reg_8 ^ 8'h00;
					   	end
					   	sum = sum ^ ( temp_xor_reg_8 ^  array_matrix_2[z][y]);
				         end
                                      end					 
				      else
					   sum = sum ^ 8'h00;
			 
                             end                   		   
                         cout[z][x] = sum;
	       end
           end    
       end 

assign state_output_matrix = {
    cout[0][0], cout[0][1], cout[0][2], cout[0][3],
    cout[1][0], cout[1][1], cout[1][2], cout[1][3],
    cout[2][0], cout[2][1], cout[2][2], cout[2][3],
    cout[3][0], cout[3][1], cout[3][2], cout[3][3]
};
    endmodule
