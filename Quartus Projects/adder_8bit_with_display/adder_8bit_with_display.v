module adder_8bit_with_display(
    input [7:0] a,        // 8-bit input a
    input [7:0] b,        // 8-bit input b
    input cin,            // Carry input
    output [6:0] hex0,    // 7-segment display for lower nibble of sum
    output [6:0] hex1,    // 7-segment display for higher nibble of sum
    output cout           // Carry output
);

    wire [7:0] sum;
    wire [3:0] lower_nibble, higher_nibble;

    // Instantiate the 8-bit adder
    adder_8bit adder_inst (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Split the sum into two 4-bit nibbles
    assign lower_nibble = sum[3:0];  // Lower 4 bits
    assign higher_nibble = sum[7:4]; // Upper 4 bits

    // Instantiate two 7-segment decoders for the two nibbles
    seven_seg_decoder seg0 (
        .bin(lower_nibble),
        .seg(hex0)
    );
    
    seven_seg_decoder seg1 (
        .bin(higher_nibble),
        .seg(hex1)
    );

endmodule
