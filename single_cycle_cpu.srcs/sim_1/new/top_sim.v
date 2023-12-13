`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:29:37
// Design Name: 
// Module Name: top_sim
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


module top_sim();
     reg clk;	//时钟信号
     reg Reset;    //置零信号
     
     
     CPU cpu(clk,Reset);
     initial begin
        clk = 0;
        Reset = 0;    //刚开始设置pc为0

        #50;    //等待Reset完成
        clk = !clk;    //下降沿，使PC先清零
        #50;
        Reset = 1;    //清除保持信号
        forever #50 begin    //产生时钟信号，周期为50s
        clk = !clk;
        end
   end
endmodule
