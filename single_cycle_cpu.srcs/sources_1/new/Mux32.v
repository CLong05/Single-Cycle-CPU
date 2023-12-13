`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 19:04:50
// Design Name: 
// Module Name: Mux32
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


module Mux32(Sel,DataIn1,DataIn2,DataOut);
    input Sel;
    input [31:0] DataIn1;
    input [31:0] DataIn2;
    output [31:0] DataOut;
    assign DataOut = Sel? DataIn2:DataIn1;
endmodule
