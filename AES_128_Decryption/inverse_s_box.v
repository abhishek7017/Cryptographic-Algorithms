`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Abhishek Borate
// Create Date: 29.10.2026 11:03:30
// Design Name: AES 128 Encryption and Decryption
// Module Name: inverse_s_box
// Project Name: AES_128 Decryption
// Tool Versions: Vivado 2023.1 
// Description: Verilog HDL implementation of the AES-128 decryption algorithm with a 128-bit ciphertext input and a 128-bit secret key, producing a 128-bit plaintext output.
//               Includes InvSubBytes, InvShiftRows, InvMixColumns, AddRoundKey, and Key Expansion transformations for FPGA-based hardware implementation. 
//////////////////////////////////////////////////////////////////////////////////


module inverse_s_box(
input [3:0] row,
input [3:0] column,
output [7:0] dataout
    );
     reg [7:0]dataout_i;
   always @(*) begin
    case ({row, column})
        8'h00: dataout_i = 8'h52;
        8'h01: dataout_i = 8'h09;
        8'h02: dataout_i = 8'h6a;
        8'h03: dataout_i = 8'hd5;
        8'h04: dataout_i = 8'h30;
        8'h05: dataout_i = 8'h36;
        8'h06: dataout_i = 8'ha5;
        8'h07: dataout_i = 8'h38;
        8'h08: dataout_i = 8'hbf;
        8'h09: dataout_i = 8'h40;
        8'h0a: dataout_i = 8'ha3;
        8'h0b: dataout_i = 8'h9e;
        8'h0c: dataout_i = 8'h81;
        8'h0d: dataout_i = 8'hf3;
        8'h0e: dataout_i = 8'hd7;
        8'h0f: dataout_i = 8'hfb;

        8'h10: dataout_i = 8'h7c;
        8'h11: dataout_i = 8'he3;
        8'h12: dataout_i = 8'h39;
        8'h13: dataout_i = 8'h82;
        8'h14: dataout_i = 8'h9b;
        8'h15: dataout_i = 8'h2f;
        8'h16: dataout_i = 8'hff;
        8'h17: dataout_i = 8'h87;
        8'h18: dataout_i = 8'h34;
        8'h19: dataout_i = 8'h8e;
        8'h1a: dataout_i = 8'h43;
        8'h1b: dataout_i = 8'h44;
        8'h1c: dataout_i = 8'hc4;
        8'h1d: dataout_i = 8'hde;
        8'h1e: dataout_i = 8'he9;
        8'h1f: dataout_i = 8'hcb;

        8'h20: dataout_i = 8'h54;
        8'h21: dataout_i = 8'h7b;
        8'h22: dataout_i = 8'h94;
        8'h23: dataout_i = 8'h32;
        8'h24: dataout_i = 8'ha6;
        8'h25: dataout_i = 8'hc2;
        8'h26: dataout_i = 8'h23;
        8'h27: dataout_i = 8'h3d;
        8'h28: dataout_i = 8'hee;
        8'h29: dataout_i = 8'h4c;
        8'h2a: dataout_i = 8'h95;
        8'h2b: dataout_i = 8'h0b;
        8'h2c: dataout_i = 8'h42;
        8'h2d: dataout_i = 8'hfa;
        8'h2e: dataout_i = 8'hc3;
        8'h2f: dataout_i = 8'h4e;

        8'h30: dataout_i = 8'h08;
        8'h31: dataout_i = 8'h2e;
        8'h32: dataout_i = 8'ha1;
        8'h33: dataout_i = 8'h66;
        8'h34: dataout_i = 8'h28;
        8'h35: dataout_i = 8'hd9;
        8'h36: dataout_i = 8'h24;
        8'h37: dataout_i = 8'hb2;
        8'h38: dataout_i = 8'h76;
        8'h39: dataout_i = 8'h5b;
        8'h3a: dataout_i = 8'ha2;
        8'h3b: dataout_i = 8'h49;
        8'h3c: dataout_i = 8'h6d;
        8'h3d: dataout_i = 8'h8b;
        8'h3e: dataout_i = 8'hd1;
        8'h3f: dataout_i = 8'h25;

        8'h40: dataout_i = 8'h72;
        8'h41: dataout_i = 8'hf8;
        8'h42: dataout_i = 8'hf6;
        8'h43: dataout_i = 8'h64;
        8'h44: dataout_i = 8'h86;
        8'h45: dataout_i = 8'h68;
        8'h46: dataout_i = 8'h98;
        8'h47: dataout_i = 8'h16;
        8'h48: dataout_i = 8'hd4;
        8'h49: dataout_i = 8'ha4;
        8'h4a: dataout_i = 8'h5c;
        8'h4b: dataout_i = 8'hcc;
        8'h4c: dataout_i = 8'h5d;
        8'h4d: dataout_i = 8'h65;
        8'h4e: dataout_i = 8'hb6;
        8'h4f: dataout_i = 8'h92;

        8'h50: dataout_i = 8'h6c;
        8'h51: dataout_i = 8'h70;
        8'h52: dataout_i = 8'h48;
        8'h53: dataout_i = 8'h50;
        8'h54: dataout_i = 8'hfd;
        8'h55: dataout_i = 8'hed;
        8'h56: dataout_i = 8'hb9;
        8'h57: dataout_i = 8'hda;
        8'h58: dataout_i = 8'h5e;
        8'h59: dataout_i = 8'h15;
        8'h5a: dataout_i = 8'h46;
        8'h5b: dataout_i = 8'h57;
        8'h5c: dataout_i = 8'ha7;
        8'h5d: dataout_i = 8'h8d;
        8'h5e: dataout_i = 8'h9d;
        8'h5f: dataout_i = 8'h84;

        8'h60: dataout_i = 8'h90;
        8'h61: dataout_i = 8'hd8;
        8'h62: dataout_i = 8'hab;
        8'h63: dataout_i = 8'h00;
        8'h64: dataout_i = 8'h8c;
        8'h65: dataout_i = 8'hbc;
        8'h66: dataout_i = 8'hd3;
        8'h67: dataout_i = 8'h0a;
        8'h68: dataout_i = 8'hf7;
        8'h69: dataout_i = 8'he4;
        8'h6a: dataout_i = 8'h58;
        8'h6b: dataout_i = 8'h05;
        8'h6c: dataout_i = 8'hb8;
        8'h6d: dataout_i = 8'hb3;
        8'h6e: dataout_i = 8'h45;
        8'h6f: dataout_i = 8'h06;

        8'h70: dataout_i = 8'hd0;
        8'h71: dataout_i = 8'h2c;
        8'h72: dataout_i = 8'h1e;
        8'h73: dataout_i = 8'h8f;
        8'h74: dataout_i = 8'hca;
        8'h75: dataout_i = 8'h3f;
        8'h76: dataout_i = 8'h0f;
        8'h77: dataout_i = 8'h02;
        8'h78: dataout_i = 8'hc1;
        8'h79: dataout_i = 8'haf;
        8'h7a: dataout_i = 8'hbd;
        8'h7b: dataout_i = 8'h03;
        8'h7c: dataout_i = 8'h01;
        8'h7d: dataout_i = 8'h13;
        8'h7e: dataout_i = 8'h8a;
        8'h7f: dataout_i = 8'h6b;

        8'h80: dataout_i = 8'h3a;
        8'h81: dataout_i = 8'h91;
        8'h82: dataout_i = 8'h11;
        8'h83: dataout_i = 8'h41;
        8'h84: dataout_i = 8'h4f;
        8'h85: dataout_i = 8'h67;
        8'h86: dataout_i = 8'hdc;
        8'h87: dataout_i = 8'hea;
        8'h88: dataout_i = 8'h97;
        8'h89: dataout_i = 8'hf2;
        8'h8a: dataout_i = 8'hcf;
        8'h8b: dataout_i = 8'hce;
        8'h8c: dataout_i = 8'hf0;
        8'h8d: dataout_i = 8'hb4;
        8'h8e: dataout_i = 8'he6;
        8'h8f: dataout_i = 8'h73;

        8'h90: dataout_i = 8'h96;
        8'h91: dataout_i = 8'hac;
        8'h92: dataout_i = 8'h74;
        8'h93: dataout_i = 8'h22;
        8'h94: dataout_i = 8'he7;
        8'h95: dataout_i = 8'had;
        8'h96: dataout_i = 8'h35;
        8'h97: dataout_i = 8'h85;
        8'h98: dataout_i = 8'he2;
        8'h99: dataout_i = 8'hf9;
        8'h9a: dataout_i = 8'h37;
        8'h9b: dataout_i = 8'he8;
        8'h9c: dataout_i = 8'h1c;
        8'h9d: dataout_i = 8'h75;
        8'h9e: dataout_i = 8'hdf;
        8'h9f: dataout_i = 8'h6e;

        8'ha0: dataout_i = 8'h47;
        8'ha1: dataout_i = 8'hf1;
        8'ha2: dataout_i = 8'h1a;
        8'ha3: dataout_i = 8'h71;
        8'ha4: dataout_i = 8'h1d;
        8'ha5: dataout_i = 8'h29;
        8'ha6: dataout_i = 8'hc5;
        8'ha7: dataout_i = 8'h89;
        8'ha8: dataout_i = 8'h6f;
        8'ha9: dataout_i = 8'hb7;
        8'haa: dataout_i = 8'h62;
        8'hab: dataout_i = 8'h0e;
        8'hac: dataout_i = 8'haa;
        8'had: dataout_i = 8'h18;
        8'hae: dataout_i = 8'hbe;
        8'haf: dataout_i = 8'h1b;

        8'hb0: dataout_i = 8'hfc;
        8'hb1: dataout_i = 8'h56;
        8'hb2: dataout_i = 8'h3e;
        8'hb3: dataout_i = 8'h4b;
        8'hb4: dataout_i = 8'hc6;
        8'hb5: dataout_i = 8'hd2;
        8'hb6: dataout_i = 8'h79;
        8'hb7: dataout_i = 8'h20;
        8'hb8: dataout_i = 8'h9a;
        8'hb9: dataout_i = 8'hdb;
        8'hba: dataout_i = 8'hc0;
        8'hbb: dataout_i = 8'hfe;
        8'hbc: dataout_i = 8'h78;
        8'hbd: dataout_i = 8'hcd;
        8'hbe: dataout_i = 8'h5a;
        8'hbf: dataout_i = 8'hf4;

        8'hc0: dataout_i = 8'h1f;
        8'hc1: dataout_i = 8'hdd;
        8'hc2: dataout_i = 8'ha8;
        8'hc3: dataout_i = 8'h33;
        8'hc4: dataout_i = 8'h88;
        8'hc5: dataout_i = 8'h07;
        8'hc6: dataout_i = 8'hc7;
        8'hc7: dataout_i = 8'h31;
        8'hc8: dataout_i = 8'hb1;
        8'hc9: dataout_i = 8'h12;
        8'hca: dataout_i = 8'h10;
        8'hcb: dataout_i = 8'h59;
        8'hcc: dataout_i = 8'h27;
        8'hcd: dataout_i = 8'h80;
        8'hce: dataout_i = 8'hec;
        8'hcf: dataout_i = 8'h5f;

        8'hd0: dataout_i = 8'h60;
        8'hd1: dataout_i = 8'h51;
        8'hd2: dataout_i = 8'h7f;
        8'hd3: dataout_i = 8'ha9;
        8'hd4: dataout_i = 8'h19;
        8'hd5: dataout_i = 8'hb5;
        8'hd6: dataout_i = 8'h4a;
        8'hd7: dataout_i = 8'h0d;
        8'hd8: dataout_i = 8'h2d;
        8'hd9: dataout_i = 8'he5;
        8'hda: dataout_i = 8'h7a;
        8'hdb: dataout_i = 8'h9f;
        8'hdc: dataout_i = 8'h93;
        8'hdd: dataout_i = 8'hc9;
        8'hde: dataout_i = 8'h9c;
        8'hdf: dataout_i = 8'hef;

        8'he0: dataout_i = 8'ha0;
        8'he1: dataout_i = 8'he0;
        8'he2: dataout_i = 8'h3b;
        8'he3: dataout_i = 8'h4d;
        8'he4: dataout_i = 8'hae;
        8'he5: dataout_i = 8'h2a;
        8'he6: dataout_i = 8'hf5;
        8'he7: dataout_i = 8'hb0;
        8'he8: dataout_i = 8'hc8;
        8'he9: dataout_i = 8'heb;
        8'hea: dataout_i = 8'hbb;
        8'heb: dataout_i = 8'h3c;
        8'hec: dataout_i = 8'h83;
        8'hed: dataout_i = 8'h53;
        8'hee: dataout_i = 8'h99;
        8'hef: dataout_i = 8'h61;

        8'hf0: dataout_i = 8'h17;
        8'hf1: dataout_i = 8'h2b;
        8'hf2: dataout_i = 8'h04;
        8'hf3: dataout_i = 8'h7e;
        8'hf4: dataout_i = 8'hba;
        8'hf5: dataout_i = 8'h77;
        8'hf6: dataout_i = 8'hd6;
        8'hf7: dataout_i = 8'h26;
        8'hf8: dataout_i = 8'he1;
        8'hf9: dataout_i = 8'h69;
        8'hfa: dataout_i = 8'h14;
        8'hfb: dataout_i = 8'h63;
        8'hfc: dataout_i = 8'h55;
        8'hfd: dataout_i = 8'h21;
        8'hfe: dataout_i = 8'h0c;
        8'hff: dataout_i = 8'h7d;

        default: dataout_i = 8'h00;
    endcase
end
assign dataout = dataout_i;
endmodule
