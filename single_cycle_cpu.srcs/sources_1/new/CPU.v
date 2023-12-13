`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 21:45:25
// Design Name: 
// Module Name: CPU
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


module CPU(clk,Reset,CurPC,newAddress,instcode,Reg1Value,Reg2Value,ALU_res,WriteData);
    input clk,Reset;//时钟信号 重置信号
    output [31:0]CurPC;//当前指令地址；
    output [31:0] newAddress;//下一条指令地址
    output [31:0] instcode; //指令
    output [31:0] Reg1Value;//寄存器rs的值
    output [31:0] Reg2Value;//寄存器rt的值
    output [31:0] ALU_res;//ALU的运算结果
    output [31:0] WriteData;//DB总线值
    
    wire ExtSel;//位扩展信号，1为符号扩展，0为0扩展
    wire PCWre;//PC工作信号，0不更改，1更改
    wire InsMemRW;//指令存储器信号，0为写，1为读
    wire RegDst;//指令读取时判断是rt还是rd进入寄存器组的写数据端，0为rt，1为rd
    wire RegWre;//寄存器组是否需要写功能，0为无写功能，1为写功能
    wire [2:0] ALUOp;//ALU8种运算功能码
    wire [1:0] PCSrc;//PC更新信号，00为PC+4，01为跳转，10为无条件跳转
    wire ALUSrcA;//寄存器堆Data1的输出，0为寄存器本身输出，1为指令码的最后16位立即数
    wire ALUSrcB;//寄存器堆Data2的输出，0位本身的输出，1为扩展后的立即数
    wire RD;	//读数据存储器功能，0时读取
    wire WR;    //写数据存储器功能，1时写
    wire DBDataSrc;//寄存器堆写入数据的数据来源，0为ALU运算结果，1为数据存储器
    wire [4:0] WriteRegAddr;//寄存器堆的写寄存器
    wire [31:0] ALU_inA,ALU_inB;//ALU的两个操作数
    wire zero,sign;//ALU的2个输出，zero和sign
    wire [31:0] MemOut;//数据存储器的输出
    wire [31:0] Ext_Imm;//位扩展后的立即数
    wire [31:0] CurPC_4 = CurPC+4;
    assign newAddress = (PCSrc == 2'b01)?{CurPC_4[31:28],instcode[25:0],2'b00}:(PCSrc == 2'b10)?CurPC_4+(Ext_Imm<<2):CurPC_4;//PC更新选择
    PC pc(clk,PCWre,Reset,newAddress,CurPC);
    ALU alu(ALUOp,ALU_inA,ALU_inB,zero,ALU_res,sign);
    Datamem dm(ALU_res,clk,RD,WR,Reg2Value,MemOut);
    SignExtend se(instcode[15:0],ExtSel,Ext_Imm);
    Mux5 mux21R(RegDst,instcode[20:16],instcode[15:11],WriteRegAddr);
    Mux32 mux21A(ALUSrcA,Reg1Value,{27'b000000000000000000000000000,instcode[10:6]},ALU_inA);
    Mux32 mux21B(ALUSrcB,Reg2Value,Ext_Imm,ALU_inB);
    Mux32 mux21RW(DBDataSrc,ALU_res,MemOut,WriteData);
    RegFile rgf(RegWre,clk,instcode[25:21],instcode[20:16],WriteRegAddr,WriteData,Reg1Value,Reg2Value);
    ControlUnit cu(PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, RD, WR, RegDst, ExtSel, PCSrc,ALUOp,zero,sign,instcode[31:26]);
    InstrucMem im(CurPC,InsMemRW,instcode);
endmodule
