`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: kushal 
// 
// Create Date: 02/03/2025 09:11:31 PM
// Design Name: 
// Module Name: HA
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


module HA(output c0, s0,input a, b ); 
assign s0 = a ^ b;
assign c0 = a & b;endmodule
