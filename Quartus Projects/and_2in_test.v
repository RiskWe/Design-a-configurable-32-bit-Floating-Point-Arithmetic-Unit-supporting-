`timescale 1ns/100ps

module and_2in_test;
    reg A, B;         // Use B instead of 'in' to avoid conflict with the Verilog keyword
    wire out;

    // Instantiate the and_2in module
    and_2in u1 (
        .A(A),
        .B(B),
        .Y(out)
    );

    // Test sequence
    initial begin
        A = 0; B = 0;
        #20 A = 1; B = 0;
        #20 A = 0; B = 1;
        #20 A = 1; B = 1;
        #40 $finish;  // Use $finish instead of both $stop and $finish
    end
endmodule
