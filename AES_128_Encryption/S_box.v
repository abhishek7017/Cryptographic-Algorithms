`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Abhishek Borate
// Create Date: 26.10.2026 22:37:30
// Design Name: AES_128 Encryption and Decryption
// Module Name: S_box
// Project Name: AES 128 Encryption  
// Tool Versions: Vivado 2023.1 
// Description: Verilog HDL implementation of the AES-128 encryption algorithm with a 128-bit plaintext input and a 128-bit secret key, producing a 128-bit ciphertext output. 
 //               Includes SubBytes, ShiftRows, MixColumns, AddRoundKey, and Key Expansion transformations for FPGA-based hardware implementation.
//////////////////////////////////////////////////////////////////////////////////


module S_box(
input [3:0] row,
input [3:0]column,
output [7:0]dataout
    );
    reg [7:0]dataout_s_box;
   always @(*) begin
    case ({row,column})
        8'h00: dataout_s_box = 8'h63;
        8'h01: dataout_s_box = 8'h7C;
        8'h02: dataout_s_box = 8'h77;
        8'h03: dataout_s_box = 8'h7B;
        8'h04: dataout_s_box = 8'hF2;
        8'h05: dataout_s_box = 8'h6B;
        8'h06: dataout_s_box = 8'h6F;
        8'h07: dataout_s_box = 8'hC5;
        8'h08: dataout_s_box = 8'h30;
        8'h09: dataout_s_box = 8'h01;
        8'h0A: dataout_s_box = 8'h67;
        8'h0B: dataout_s_box = 8'h2B;
        8'h0C: dataout_s_box = 8'hFE;
        8'h0D: dataout_s_box = 8'hD7;
        8'h0E: dataout_s_box = 8'hAB;
        8'h0F: dataout_s_box = 8'h76;

        8'h10: dataout_s_box = 8'hCA;
        8'h11: dataout_s_box = 8'h82;
        8'h12: dataout_s_box = 8'hC9;
        8'h13: dataout_s_box = 8'h7D;
        8'h14: dataout_s_box = 8'hFA;
        8'h15: dataout_s_box = 8'h59;
        8'h16: dataout_s_box = 8'h47;
        8'h17: dataout_s_box = 8'hF0;
        8'h18: dataout_s_box = 8'hAD;
        8'h19: dataout_s_box = 8'hD4;
        8'h1A: dataout_s_box = 8'hA2;
        8'h1B: dataout_s_box = 8'hAF;
        8'h1C: dataout_s_box = 8'h9C;
        8'h1D: dataout_s_box = 8'hA4;
        8'h1E: dataout_s_box = 8'h72;
        8'h1F: dataout_s_box = 8'hC0;

        8'h20: dataout_s_box = 8'hB7;
        8'h21: dataout_s_box = 8'hFD;
        8'h22: dataout_s_box = 8'h93;
        8'h23: dataout_s_box = 8'h26;
        8'h24: dataout_s_box = 8'h36;
        8'h25: dataout_s_box = 8'h3F;
        8'h26: dataout_s_box = 8'hF7;
        8'h27: dataout_s_box = 8'hCC;
        8'h28: dataout_s_box = 8'h34;
        8'h29: dataout_s_box = 8'hA5;
        8'h2A: dataout_s_box = 8'hE5;
        8'h2B: dataout_s_box = 8'hF1;
        8'h2C: dataout_s_box = 8'h71;
        8'h2D: dataout_s_box = 8'hD8;
        8'h2E: dataout_s_box = 8'h31;
        8'h2F: dataout_s_box = 8'h15;

        8'h30: dataout_s_box = 8'h04;
        8'h31: dataout_s_box = 8'hC7;
        8'h32: dataout_s_box = 8'h23;
        8'h33: dataout_s_box = 8'hC3;
        8'h34: dataout_s_box = 8'h18;
        8'h35: dataout_s_box = 8'h96;
        8'h36: dataout_s_box = 8'h05;
        8'h37: dataout_s_box = 8'h9A;
        8'h38: dataout_s_box = 8'h07;
        8'h39: dataout_s_box = 8'h12;
        8'h3A: dataout_s_box = 8'h80;
        8'h3B: dataout_s_box = 8'hE2;
        8'h3C: dataout_s_box = 8'hEB;
        8'h3D: dataout_s_box = 8'h27;
        8'h3E: dataout_s_box = 8'hB2;
        8'h3F: dataout_s_box = 8'h75;

        8'h40: dataout_s_box = 8'h09;
        8'h41: dataout_s_box = 8'h83;
        8'h42: dataout_s_box = 8'h2C;
        8'h43: dataout_s_box = 8'h1A;
        8'h44: dataout_s_box = 8'h1B;
        8'h45: dataout_s_box = 8'h6E;
        8'h46: dataout_s_box = 8'h5A;
        8'h47: dataout_s_box = 8'hA0;
        8'h48: dataout_s_box = 8'h52;
        8'h49: dataout_s_box = 8'h3B;
        8'h4A: dataout_s_box = 8'hD6;
        8'h4B: dataout_s_box = 8'hB3;
        8'h4C: dataout_s_box = 8'h29;
        8'h4D: dataout_s_box = 8'hE3;
        8'h4E: dataout_s_box = 8'h2F;
        8'h4F: dataout_s_box = 8'h84;

        8'h50: dataout_s_box = 8'h53;
        8'h51: dataout_s_box = 8'hD1;
        8'h52: dataout_s_box = 8'h00;
        8'h53: dataout_s_box = 8'hED;
        8'h54: dataout_s_box = 8'h20;
        8'h55: dataout_s_box = 8'hFC;
        8'h56: dataout_s_box = 8'hB1;
        8'h57: dataout_s_box = 8'h5B;
        8'h58: dataout_s_box = 8'h6A;
        8'h59: dataout_s_box = 8'hCB;
        8'h5A: dataout_s_box = 8'hBE;
        8'h5B: dataout_s_box = 8'h39;
        8'h5C: dataout_s_box = 8'h4A;
        8'h5D: dataout_s_box = 8'h4C;
        8'h5E: dataout_s_box = 8'h58;
        8'h5F: dataout_s_box = 8'hCF;

        8'h60: dataout_s_box = 8'hD0;
        8'h61: dataout_s_box = 8'hEF;
        8'h62: dataout_s_box = 8'hAA;
        8'h63: dataout_s_box = 8'hFB;
        8'h64: dataout_s_box = 8'h43;
        8'h65: dataout_s_box = 8'h4D;
        8'h66: dataout_s_box = 8'h33;
        8'h67: dataout_s_box = 8'h85;
        8'h68: dataout_s_box = 8'h45;
        8'h69: dataout_s_box = 8'hF9;
        8'h6A: dataout_s_box = 8'h02;
        8'h6B: dataout_s_box = 8'h7F;
        8'h6C: dataout_s_box = 8'h50;
        8'h6D: dataout_s_box = 8'h3C;
        8'h6E: dataout_s_box = 8'h9F;
        8'h6F: dataout_s_box = 8'hA8;

        8'h70: dataout_s_box = 8'h51;
        8'h71: dataout_s_box = 8'hA3;
        8'h72: dataout_s_box = 8'h40;
        8'h73: dataout_s_box = 8'h8F;
        8'h74: dataout_s_box = 8'h92;
        8'h75: dataout_s_box = 8'h9D;
        8'h76: dataout_s_box = 8'h38;
        8'h77: dataout_s_box = 8'hF5;
        8'h78: dataout_s_box = 8'hBC;
        8'h79: dataout_s_box = 8'hB6;
        8'h7A: dataout_s_box = 8'hDA;
        8'h7B: dataout_s_box = 8'h21;
        8'h7C: dataout_s_box = 8'h10;
        8'h7D: dataout_s_box = 8'hFF;
        8'h7E: dataout_s_box = 8'hF3;
        8'h7F: dataout_s_box = 8'hD2;

        8'h80: dataout_s_box = 8'hCD;
        8'h81: dataout_s_box = 8'h0C;
        8'h82: dataout_s_box = 8'h13;
        8'h83: dataout_s_box = 8'hEC;
        8'h84: dataout_s_box = 8'h5F;
        8'h85: dataout_s_box = 8'h97;
        8'h86: dataout_s_box = 8'h44;
        8'h87: dataout_s_box = 8'h17;
        8'h88: dataout_s_box = 8'hC4;
        8'h89: dataout_s_box = 8'hA7;
        8'h8A: dataout_s_box = 8'h7E;
        8'h8B: dataout_s_box = 8'h3D;
        8'h8C: dataout_s_box = 8'h64;
        8'h8D: dataout_s_box = 8'h5D;
        8'h8E: dataout_s_box = 8'h19;
        8'h8F: dataout_s_box = 8'h73;

        8'h90: dataout_s_box = 8'h60;
        8'h91: dataout_s_box = 8'h81;
        8'h92: dataout_s_box = 8'h4F;
        8'h93: dataout_s_box = 8'hDC;
        8'h94: dataout_s_box = 8'h22;
        8'h95: dataout_s_box = 8'h2A;
        8'h96: dataout_s_box = 8'h90;
        8'h97: dataout_s_box = 8'h88;
        8'h98: dataout_s_box = 8'h46;
        8'h99: dataout_s_box = 8'hEE;
        8'h9A: dataout_s_box = 8'hB8;
        8'h9B: dataout_s_box = 8'h14;
        8'h9C: dataout_s_box = 8'hDE;
        8'h9D: dataout_s_box = 8'h5E;
        8'h9E: dataout_s_box = 8'h0B;
        8'h9F: dataout_s_box = 8'hDB;

        8'hA0: dataout_s_box = 8'hE0;
        8'hA1: dataout_s_box = 8'h32;
        8'hA2: dataout_s_box = 8'h3A;
        8'hA3: dataout_s_box = 8'h0A;
        8'hA4: dataout_s_box = 8'h49;
        8'hA5: dataout_s_box = 8'h06;
        8'hA6: dataout_s_box = 8'h24;
        8'hA7: dataout_s_box = 8'h5C;
        8'hA8: dataout_s_box = 8'hC2;
        8'hA9: dataout_s_box = 8'hD3;
        8'hAA: dataout_s_box = 8'hAC;
        8'hAB: dataout_s_box = 8'h62;
        8'hAC: dataout_s_box = 8'h91;
        8'hAD: dataout_s_box = 8'h95;
        8'hAE: dataout_s_box = 8'hE4;
        8'hAF: dataout_s_box = 8'h79;

        8'hB0: dataout_s_box = 8'hE7;
        8'hB1: dataout_s_box = 8'hC8;
        8'hB2: dataout_s_box = 8'h37;
        8'hB3: dataout_s_box = 8'h6D;
        8'hB4: dataout_s_box = 8'h8D;
        8'hB5: dataout_s_box = 8'hD5;
        8'hB6: dataout_s_box = 8'h4E;
        8'hB7: dataout_s_box = 8'hA9;
        8'hB8: dataout_s_box = 8'h6C;
        8'hB9: dataout_s_box = 8'h56;
        8'hBA: dataout_s_box = 8'hF4;
        8'hBB: dataout_s_box = 8'hEA;
        8'hBC: dataout_s_box = 8'h65;
        8'hBD: dataout_s_box = 8'h7A;
        8'hBE: dataout_s_box = 8'hAE;
        8'hBF: dataout_s_box = 8'h08;

        8'hC0: dataout_s_box = 8'hBA;
        8'hC1: dataout_s_box = 8'h78;
        8'hC2: dataout_s_box = 8'h25;
        8'hC3: dataout_s_box = 8'h2E;
        8'hC4: dataout_s_box = 8'h1C;
        8'hC5: dataout_s_box = 8'hA6;
        8'hC6: dataout_s_box = 8'hB4;
        8'hC7: dataout_s_box = 8'hC6;
        8'hC8: dataout_s_box = 8'hE8;
        8'hC9: dataout_s_box = 8'hDD;
        8'hCA: dataout_s_box = 8'h74;
        8'hCB: dataout_s_box = 8'h1F;
        8'hCC: dataout_s_box = 8'h4B;
        8'hCD: dataout_s_box = 8'hBD;
        8'hCE: dataout_s_box = 8'h8B;
        8'hCF: dataout_s_box = 8'h8A;

        8'hD0: dataout_s_box = 8'h70;
        8'hD1: dataout_s_box = 8'h3E;
        8'hD2: dataout_s_box = 8'hB5;
        8'hD3: dataout_s_box = 8'h66;
        8'hD4: dataout_s_box = 8'h48;
        8'hD5: dataout_s_box = 8'h03;
        8'hD6: dataout_s_box = 8'hF6;
        8'hD7: dataout_s_box = 8'h0E;
        8'hD8: dataout_s_box = 8'h61;
        8'hD9: dataout_s_box = 8'h35;
        8'hDA: dataout_s_box = 8'h57;
        8'hDB: dataout_s_box = 8'hB9;
        8'hDC: dataout_s_box = 8'h86;
        8'hDD: dataout_s_box = 8'hC1;
        8'hDE: dataout_s_box = 8'h1D;
        8'hDF: dataout_s_box = 8'h9E;

        8'hE0: dataout_s_box = 8'hE1;
        8'hE1: dataout_s_box = 8'hF8;
        8'hE2: dataout_s_box = 8'h98;
        8'hE3: dataout_s_box = 8'h11;
        8'hE4: dataout_s_box = 8'h69;
        8'hE5: dataout_s_box = 8'hD9;
        8'hE6: dataout_s_box = 8'h8E;
        8'hE7: dataout_s_box = 8'h94;
        8'hE8: dataout_s_box = 8'h9B;
        8'hE9: dataout_s_box = 8'h1E;
        8'hEA: dataout_s_box = 8'h87;
        8'hEB: dataout_s_box = 8'hE9;
        8'hEC: dataout_s_box = 8'hCE;
        8'hED: dataout_s_box = 8'h55;
        8'hEE: dataout_s_box = 8'h28;
        8'hEF: dataout_s_box = 8'hDF;

        8'hF0: dataout_s_box = 8'h8C;
        8'hF1: dataout_s_box = 8'hA1;
        8'hF2: dataout_s_box = 8'h89;
        8'hF3: dataout_s_box = 8'h0D;
        8'hF4: dataout_s_box = 8'hBF;
        8'hF5: dataout_s_box = 8'hE6;
        8'hF6: dataout_s_box = 8'h42;
        8'hF7: dataout_s_box = 8'h68;
        8'hF8: dataout_s_box = 8'h41;
        8'hF9: dataout_s_box = 8'h99;
        8'hFA: dataout_s_box = 8'h2D;
        8'hFB: dataout_s_box = 8'h0F;
        8'hFC: dataout_s_box = 8'hB0;
        8'hFD: dataout_s_box = 8'h54;
        8'hFE: dataout_s_box = 8'hBB;
        8'hFF: dataout_s_box = 8'h16;

        default: dataout_s_box = 8'h00;
    endcase
end
assign dataout = dataout_s_box;
endmodule
