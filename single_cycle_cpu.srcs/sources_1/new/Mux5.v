`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 19:08:00
// Design Name: 
// Module Name: Mux5
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


module Mux5(Sel,DataIn1,DataIn2,DataOut);
    input Sel;
    input [4:0] DataIn1;
    input [4:0] DataIn2;
    output [4:0] DataOut;
    assign DataOut = Sel? DataIn2:DataIn1;
endmodule
