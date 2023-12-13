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
    input clk,Reset;//ʱ���ź� �����ź�
    output [31:0]CurPC;//��ǰָ���ַ��
    output [31:0] newAddress;//��һ��ָ���ַ
    output [31:0] instcode; //ָ��
    output [31:0] Reg1Value;//�Ĵ���rs��ֵ
    output [31:0] Reg2Value;//�Ĵ���rt��ֵ
    output [31:0] ALU_res;//ALU��������
    output [31:0] WriteData;//DB����ֵ
    
    wire ExtSel;//λ��չ�źţ�1Ϊ������չ��0Ϊ0��չ
    wire PCWre;//PC�����źţ�0�����ģ�1����
    wire InsMemRW;//ָ��洢���źţ�0Ϊд��1Ϊ��
    wire RegDst;//ָ���ȡʱ�ж���rt����rd����Ĵ������д���ݶˣ�0Ϊrt��1Ϊrd
    wire RegWre;//�Ĵ������Ƿ���Ҫд���ܣ�0Ϊ��д���ܣ�1Ϊд����
    wire [2:0] ALUOp;//ALU8�����㹦����
    wire [1:0] PCSrc;//PC�����źţ�00ΪPC+4��01Ϊ��ת��10Ϊ��������ת
    wire ALUSrcA;//�Ĵ�����Data1�������0Ϊ�Ĵ������������1Ϊָ��������16λ������
    wire ALUSrcB;//�Ĵ�����Data2�������0λ����������1Ϊ��չ���������
    wire RD;	//�����ݴ洢�����ܣ�0ʱ��ȡ
    wire WR;    //д���ݴ洢�����ܣ�1ʱд
    wire DBDataSrc;//�Ĵ�����д�����ݵ�������Դ��0ΪALU��������1Ϊ���ݴ洢��
    wire [4:0] WriteRegAddr;//�Ĵ����ѵ�д�Ĵ���
    wire [31:0] ALU_inA,ALU_inB;//ALU������������
    wire zero,sign;//ALU��2�������zero��sign
    wire [31:0] MemOut;//���ݴ洢�������
    wire [31:0] Ext_Imm;//λ��չ���������
    wire [31:0] CurPC_4 = CurPC+4;
    assign newAddress = (PCSrc == 2'b01)?{CurPC_4[31:28],instcode[25:0],2'b00}:(PCSrc == 2'b10)?CurPC_4+(Ext_Imm<<2):CurPC_4;//PC����ѡ��
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
