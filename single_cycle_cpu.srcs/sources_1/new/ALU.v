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
    input [2:0] ALUOp; //������
    input [31:0] A,B; //����32λ������
    output zero; //zero��־
    output sign;//�����жϱ�ʶ�����Ϊ����signΪ0
    output reg [31:0] result; //ALU������
    assign zero = result == 0;
    assign sign = result[31];
    always @(*)
    begin
        case(ALUOp)
            3'b000: result = A + B;//�ӷ�
            3'b001: result = A - B;//����
            3'b010: result = B << A;//B����Aλ
            3'b011: result = A | B;//��
            3'b100: result = A & B;//��
            3'b101: result = A < B; //�Ƚ�A<B��������
            3'b110: result = (((A<B)&&(A[31] == B[31])) || ((A[31]==1&& B[31] == 0))) ? 1:0;//�Ƚ�A<B������
            3'b111: result = A ^ B;//���
            default: result = 0;
        endcase
    end
endmodule
