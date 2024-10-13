module adder_8bit(
    input [7:0] a,      // 8-bit input a
    input [7:0] b,      // 8-bit input b
    input cin,          // Carry input
    output [7:0] sum,   // 8-bit sum output
    output cout         // Carry output
);

    assign {cout, sum} = a + b + cin;  // Perform 8-bit addition with carry-in

endmodule
