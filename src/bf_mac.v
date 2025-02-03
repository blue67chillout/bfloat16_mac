`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: kushal 
// 
// Create Date: 02/03/2025 07:01:03 PM
// Design Name: 
// Module Name: bf_mac
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

module bf_mac #(
    
) (
    input clk,
    input rst,

    input [15:0] in_1,
    input [15:0] in_2,
    input mac_en,
    output reg [15:0] acc_result

);

wire sign;
wire [7:0]exp_sum;
wire [15:0]mant_mul;
wire [6:0]mant_result;

assign sign = in_1[15]^in_2[15];

initial begin 
    acc_result <= 16'b0;
end

w_mul w_mul_0 (
    {1'b1,in_1[6:0]},
    {1'b1,in_2[6:0]},
    mant_mul
);
//assign mant_mul = a * b ;

assign exp_sum = mant_mul[15] ? in_1[14:7] + in_2[14:7] - 126 : in_1[14:7] + in_2[14:7] - 127; 

assign mant_result = mant_mul[15] ? mant_mul[14:6] : mant_mul[13:5];

assign out = {sign, exp_sum, mant_result};

always @(posedge clk) begin
    if (rst) begin
        acc_result <= 16'b0;
    end else if (mac_en) begin
        acc_result <= acc_result + out;
    end
end

endmodule
