`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 21:39:48
// Design Name: 
// Module Name: SignExtend
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


module SignExtend(immediate,ExtSel,extendImmediate);
    input [15:0] immediate;
    input ExtSel;
    output [31:0] extendImmediate;
    assign extendImmediate = {ExtSel&&immediate[15]?16'hffff:16'h0000,immediate};//Î»À©Õ¹
endmodule
