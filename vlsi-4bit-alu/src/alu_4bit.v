module alu_4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] sel,
    output reg [3:0] Y,
    output reg carry_out,
    output reg zero
);

    reg [4:0] temp;

    always @(*) begin
        carry_out = 0;
        temp = 5'b00000;

        case (sel)
            3'b000: begin
                temp = A + B;
                Y = temp[3:0];
                carry_out = temp[4];
            end

            3'b001: begin
                temp = A - B;
                Y = temp[3:0];
                carry_out = temp[4];
            end

            3'b010: begin
                Y = A & B;
            end

            3'b011: begin
                Y = A | B;
            end

            3'b100: begin
                Y = A ^ B;
            end

            3'b101: begin
                Y = ~A;
            end

            3'b110: begin
                Y = A << 1;
            end

            3'b111: begin
                Y = A >> 1;
            end

            default: begin
                Y = 4'b0000;
            end
        endcase

        if (Y == 4'b0000)
            zero = 1;
        else
            zero = 0;
    end

endmodule