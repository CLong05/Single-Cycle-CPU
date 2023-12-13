`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 16:50:46
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, mRD, mWR, RegDst, ExtSel, PCSrc,ALUOp,zero,sign,op);
    input zero;
    input sign;
    input [5:0] op;
    output mRD;
    output mWR;
    output ALUSrcA;
    output ALUSrcB;
    output DBDataSrc;
    output ExtSel;
    output InsMemRW;
    output RegWre;
    output RegDst;
    output PCWre;
    output [1:0] PCSrc;
    output [2:0] ALUOp;
    
    parameter Add = 6'b000000;
    parameter Sub = 6'b000001;
    parameter Addi = 6'b000010;
    parameter Andi = 6'b010000;
    parameter And = 6'b010001;
    parameter Ori = 6'b010010;
    parameter Or = 6'b010011;
    parameter Sll = 6'b011000;
    parameter Slti = 6'b011100;
    parameter Sw = 6'b100110;
    parameter Lw = 6'b100111;
    parameter Beq = 6'b110000;
    parameter Bne = 6'b110001;
    parameter Bltz = 6'b110010;
    parameter J = 6'b111000;
    parameter Halt = 6'b111111;
    parameter A_add = 3'b000;
    parameter A_sub = 3'b001;
    parameter A_sll = 3'b010;
    parameter A_or = 3'b011;
    parameter A_and = 3'b100;
    parameter A_sltu = 3'b101;
    parameter A_slt = 3'b110;
    parameter A_xor = 3'b111;
    
    
    assign ALUSrcA = (op == Sll);
    assign ALUSrcB = (op == Addi || op == Andi || op == Ori || op == Slti || op == Sw || op == Lw);
    assign PCWre = (op == Halt)?0:1;
    assign DBDataSrc = (op == Lw);
    assign RegWre = ~(op == Beq || op == Bne || op == Bltz || op == Sw || op == Halt);
    assign InsMemRW = 1;
    assign mRD = (op == Lw)?1:1'bz;
    assign mWR = (op == Sw);
    assign RegDst = ~(op == Addi || op == Andi || op == Ori || op == Slti || op == Lw);
    assign ExtSel = (op != Andi && op != Ori);
    assign PCSrc[0] = (op == J);
    assign PCSrc[1] = ((op == Beq&& zero == 1) || (op == Bne && zero == 0) || (op == Bltz) && sign == 1);
    assign ALUOp = (op == Sub || op == Beq || op == Bne || op == Bltz)? A_sub: op == Sll? A_sll: op == Or || op == Ori? A_or: op == And || op == Andi? A_and: op == Slti? A_slt : A_add;
endmodule
