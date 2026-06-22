`timescale 1ns/1ps

module alu_4bit_tb;

    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] sel;

    wire [3:0] Y;
    wire carry_out;
    wire zero;

    alu_4bit uut (
        .A(A),
        .B(B),
        .sel(sel),
        .Y(Y),
        .carry_out(carry_out),
        .zero(zero)
    );

    initial begin
        $dumpfile("waveforms/alu_4bit.vcd");
        $dumpvars(0, alu_4bit_tb);

        $display("Starting 4-bit ALU Testbench");
        $display("--------------------------------");

        A = 4'b0101;
        B = 4'b0011;

        sel = 3'b000; #10;
        $display("ADD: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        sel = 3'b001; #10;
        $display("SUB: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        sel = 3'b010; #10;
        $display("AND: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        sel = 3'b011; #10;
        $display("OR : A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        sel = 3'b100; #10;
        $display("XOR: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        sel = 3'b101; #10;
        $display("NOT: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        sel = 3'b110; #10;
        $display("SHL: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        sel = 3'b111; #10;
        $display("SHR: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        A = 4'b0011;
        B = 4'b0011;
        sel = 3'b001; #10;
        $display("ZERO TEST: A=%b B=%b Y=%b carry=%b zero=%b", A, B, Y, carry_out, zero);

        $display("--------------------------------");
        $display("Testbench completed");

        $finish;
    end

endmodule