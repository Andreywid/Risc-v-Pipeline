`timescale 1ns / 1ps

module Controller (
    //Input
    input logic [6:0] Opcode,
    //7-bit opcode field from the instruction

    //Outputs
    output logic Halt,
    output logic ALUSrc,
    //0: The second ALU operand comes from the second register file output (Read data 2); 
    //1: The second ALU operand is the sign-extended, lower 16 bits of the instruction.
    output logic Jal,
    output logic MemtoReg,
    //0: The value fed to the register Write data input comes from the ALU.
    //1: The value fed to the register Write data input comes from the data memory.
    output logic RegWrite, //The register on the Write register input is written with the value on the Write data input 
    output logic MemRead,  //Data memory contents designated by the address input are put on the Read data output
    output logic MemWrite, //Data memory contents designated by the address input are replaced by the value on the Write data input.
    output logic [1:0] ALUOp,  //00: LW/SW; 01:Branch; 10: Rtype
    output logic Branch,  //0: branch is not taken; 1: branch is taken
    output logic Jalr
);

  logic [6:0] R_TYPE, LW, SW, BR,I_TYPE, LUI_TYPE, JAL1, JALR1, HALT;

  assign R_TYPE = 7'b0110011;  //add,and
  assign I_TYPE = 7'b0010011; // addi
  assign LW = 7'b0000011;  //lw
  assign SW = 7'b0100011;  //sw
  assign BR = 7'b1100011;  //beq
  assign LUI_TYPE = 7'b0110111; // lui
  assign JAL1 = 7'b1101111; // JAL1
  assign JALR1 = 7'b1100111; // JALR1
  assign HALT = 7'b1111111; // halt

  assign ALUSrc = (Opcode == LW || Opcode == SW || Opcode == I_TYPE || Opcode == LUI_TYPE || Opcode == JALR1);
  assign MemtoReg = (Opcode == LW);
  assign RegWrite = (Opcode == R_TYPE || Opcode == LW || Opcode == I_TYPE || Opcode == LUI_TYPE || Opcode == JALR1 || Opcode == JAL1);
  assign MemRead = (Opcode == LW);
  assign MemWrite = (Opcode == SW);
  assign ALUOp[0] = (Opcode == BR || Opcode == LUI_TYPE || Opcode == JALR1);
  assign ALUOp[1] = (Opcode == R_TYPE || Opcode == I_TYPE || Opcode == LUI_TYPE || Opcode == JALR1);
  assign Branch = (Opcode == BR);
  assign Jal = (Opcode == JAL1) || (Opcode == JALR1);
  assign Jalr = (Opcode == JALR1);
  assign Halt = (Opcode == HALT);
endmodule
