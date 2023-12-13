`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 16:05:25
// Design Name: 
// Module Name: PC
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


module PC(clk, PCWre ,Reset, in_pc, out_pc);
    input PCWre, clk, Reset; //停机信号 时钟信号 重置信号
    input [31:0] in_pc;  //输入到PC的指令地址
    output reg [31:0] out_pc;
    initial begin
        out_pc = 0;
    end
    always @(posedge clk or negedge Reset) begin
        if(Reset==0)begin
            out_pc = 0;
        end
        else if(PCWre)begin // PCWre为0时为停机处理
            out_pc = in_pc;
        end
    end
endmodule
