`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 19:23:40
// Design Name: 
// Module Name: RegFile
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


module RegFile(WE,clk,ReadReg1,ReadReg2,WriteReg,WriteData,ReadData1,ReadData2);
    input WE,clk;//写使能信号 时钟信号
    input [4:0] ReadReg1,ReadReg2,WriteReg;
    input [31:0] WriteData;
    output [31:0] ReadData1,ReadData2;
    reg [31:0] registers [0:31];
    integer i;
    initial begin
        for(i = 0;i < 32;i = i+1)
            registers[i] <= 0;
    end
    assign ReadData1 = ReadReg1? registers[ReadReg1]:0;//0号寄存器的值始终为0
    assign ReadData2 = ReadReg2? registers[ReadReg2]:0;
    always @(negedge clk) begin
        if(WriteReg && WE) begin
            registers[WriteReg] = WriteData;
        end
    end
endmodule
