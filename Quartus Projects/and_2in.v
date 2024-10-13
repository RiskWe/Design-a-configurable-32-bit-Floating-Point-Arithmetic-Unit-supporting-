`timescale 1ns/100ps

module and_2in (
    input A, B,
    output Y
);

    // Use direct assignment to output
    assign Y = A & B;

endmodule
