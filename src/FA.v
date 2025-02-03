`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: kushal
// 
// Create Date: 02/03/2025 09:10:38 PM
// Design Name: 
// Module Name: FA
// Project Name: 
// Target Devices: pynq z2
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


module FA ( output c0, s0 ,input a, b, cin);
  assign s0 = a ^ b ^ cin;
  assign c0 = (a & b) | (b & cin) | (a & cin);
endmodule