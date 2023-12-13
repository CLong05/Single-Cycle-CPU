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
     reg clk;	//ʱ���ź�
     reg Reset;    //�����ź�
     
     
     CPU cpu(clk,Reset);
     initial begin
        clk = 0;
        Reset = 0;    //�տ�ʼ����pcΪ0

        #50;    //�ȴ�Reset���
        clk = !clk;    //�½��أ�ʹPC������
        #50;
        Reset = 1;    //��������ź�
        forever #50 begin    //����ʱ���źţ�����Ϊ50s
        clk = !clk;
        end
   end
endmodule
