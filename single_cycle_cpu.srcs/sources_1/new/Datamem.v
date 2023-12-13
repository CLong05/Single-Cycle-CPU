`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 18:16:33
// Design Name: 
// Module Name: Datamem
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


module Datamem(Daddr,clk,mRD,mWR,DataIn,DataOut);
    input [31:0] Daddr;
    input clk;
    input mRD;
    input mWR;
    input [31:0] DataIn;
    output reg [31:0] DataOut;
    reg [7:0] Datamemory [255:0];
    always @(mRD or Daddr) begin
        if(mRD)begin
            DataOut[7:0] <= Datamemory[Daddr+3];
            DataOut[15:8] <= Datamemory[Daddr+2];
            DataOut[23:16] <= Datamemory[Daddr+1];
            DataOut[31:24] <= Datamemory[Daddr]; 
        end
    end
    always @(negedge clk) begin
        if(mWR)begin
            Datamemory[Daddr+3] <= DataIn[7:0];
            Datamemory[Daddr+2] <= DataIn[15:8];
            Datamemory[Daddr+1] <= DataIn[23:16];
            Datamemory[Daddr] <= DataIn[31:24];
        end
    end 
endmodule
