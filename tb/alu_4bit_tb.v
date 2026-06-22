`timescale 1ns/1ps

module alu_4bit_tb;

    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] sel;

    wire [3:0] Y;
    wire carry_out;
    wire zero;
    wire negative;
    wire overflow;

    integer test_count;
    integer pass_count;
    integer fail_count;

    alu_4bit uut (
        .A(A),
        .B(B),
        .sel(sel),
        .Y(Y),
        .carry_out(carry_out),
        .zero(zero),
        .negative(negative),
        .overflow(overflow)
    );

    task check_result;
        input [3:0] expected_Y;
        input expected_zero;
        input expected_negative;
        input expected_overflow;
        input [80*8:1] test_name;

        begin
            test_count = test_count + 1;
            #1;

            if (
                Y === expected_Y &&
                zero === expected_zero &&
                negative === expected_negative &&
                overflow === expected_overflow
            ) begin
                pass_count = pass_count + 1;
                $display("PASS: %s | A=%d B=%d sel=%b Y=%d zero=%b negative=%b overflow=%b",
                         test_name, A, B, sel, Y, zero, negative, overflow);
            end else begin
                fail_count = fail_count + 1;
                $display("FAIL: %s | A=%d B=%d sel=%b", test_name, A, B, sel);
                $display("      Expected: Y=%d zero=%b negative=%b overflow=%b",
                         expected_Y, expected_zero, expected_negative, expected_overflow);
                $display("      Got:      Y=%d zero=%b negative=%b overflow=%b",
                         Y, zero, negative, overflow);
            end
        end
    endtask

    initial begin
        $dumpfile("waveforms/alu_4bit.vcd");
        $dumpvars(0, alu_4bit_tb);

        test_count = 0;
        pass_count = 0;
        fail_count = 0;

        $display("Starting Self-Checking 4-bit ALU Testbench");
        $display("------------------------------------------------");

        // Main test case: A = 5, B = 3
        A = 4'd5;
        B = 4'd3;

        sel = 3'b000; #10;
        check_result(4'd8, 0, 1, 1, "ADD 5 + 3");

        sel = 3'b001; #10;
        check_result(4'd2, 0, 0, 0, "SUB 5 - 3");

        sel = 3'b010; #10;
        check_result(4'd1, 0, 0, 0, "AND 5 & 3");

        sel = 3'b011; #10;
        check_result(4'd7, 0, 0, 0, "OR 5 | 3");

        sel = 3'b100; #10;
        check_result(4'd6, 0, 0, 0, "XOR 5 ^ 3");

        sel = 3'b101; #10;
        check_result(4'd10, 0, 1, 0, "NOT 5");

        sel = 3'b110; #10;
        check_result(4'd10, 0, 1, 0, "SHIFT LEFT 5");

        sel = 3'b111; #10;
        check_result(4'd2, 0, 0, 0, "SHIFT RIGHT 5");

        // Zero flag test
        A = 4'd3;
        B = 4'd3;
        sel = 3'b001; #10;
        check_result(4'd0, 1, 0, 0, "ZERO TEST 3 - 3");

        // Carry test: 15 + 1 = 16, lower 4 bits = 0, carry = 1
        A = 4'd15;
        B = 4'd1;
        sel = 3'b000; #10;
        check_result(4'd0, 1, 0, 0, "CARRY TEST 15 + 1");

        // Signed overflow test: 7 + 1 = 8
        // In 4-bit signed numbers, 7 + 1 overflows to -8
        A = 4'd7;
        B = 4'd1;
        sel = 3'b000; #10;
        check_result(4'd8, 0, 1, 1, "SIGNED OVERFLOW TEST 7 + 1");

        // Negative flag test
        A = 4'd8;
        B = 4'd1;
        sel = 3'b010; #10;
        check_result(4'd0, 1, 0, 0, "AND 8 & 1");

        A = 4'd8;
        B = 4'd1;
        sel = 3'b011; #10;
        check_result(4'd9, 0, 1, 0, "NEGATIVE FLAG TEST 8 | 1");

        $display("------------------------------------------------");
        $display("Testbench completed");
        $display("Total tests: %0d", test_count);
        $display("Passed:      %0d", pass_count);
        $display("Failed:      %0d", fail_count);

        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $finish;
    end

endmodule