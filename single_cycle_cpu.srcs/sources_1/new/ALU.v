`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 16:18:58
// Design Name: 
// Module Name: ALU
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


module ALU(ALUOp, A, B, zero, result, sign);
    input [2:0] ALUOp; //操作码
    input [31:0] A,B; //两个32位操作数
    output zero; //zero标志
    output sign;//正负判断标识，结果为正，sign为0
    output reg [31:0] result; //ALU运算结果
    assign zero = result == 0;
    assign sign = result[31];
    always @(*)
    begin
        case(ALUOp)
            3'b000: result = A + B;//加法
            3'b001: result = A - B;//减法
            3'b010: result = B << A;//B左移A位
            3'b011: result = A | B;//或
            3'b100: result = A & B;//与
            3'b101: result = A < B; //比较A<B不带符号
            3'b110: result = (((A<B)&&(A[31] == B[31])) || ((A[31]==1&& B[31] == 0))) ? 1:0;//比较A<B带符号
            3'b111: result = A ^ B;//异或
            default: result = 0;
        endcase
    end
endmodule
