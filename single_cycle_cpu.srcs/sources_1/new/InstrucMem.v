`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 18:55:14
// Design Name: 
// Module Name: InstrucMem
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


module InstrucMem(Iaddr,RW,InDataOut);
    input [31:0] Iaddr;
    input RW;
    output reg [31:0] InDataOut;
    reg [7:0] Instmemory [255:0];
    initial begin
        $readmemb("D:/Vivado project/single_cycle_cpu/tests.txt",Instmemory);
    end
    always @(Iaddr or RW)begin
        if(RW)begin
        InDataOut = {Instmemory[Iaddr],Instmemory[Iaddr+1],Instmemory[Iaddr+2],Instmemory[Iaddr+3]};
        end
    end
endmodule
