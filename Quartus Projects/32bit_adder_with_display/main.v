module main(
    input [15:0] SW,        // 16 switches for 16-bit input
    input [1:0] KEY,        // Enter buttons for each input step
    input clk,              // Clock signal
    output [7:0] lcd_data,  // LCD data output
    output lcd_enable       // LCD enable signal
);

    reg [31:0] a, b;        // Two 32-bit inputs
    reg [15:0] temp_input;  // Temporary 16-bit input storage
    reg input_stage;        // To track input step (0 for a, 1 for b)
    wire [31:0] result;     // Output from the floating point adder

    // Instantiating the floating-point adder
    adder_float add(
        .a(a),
        .b(b),
        .result(result)
    );

    // Instantiating the display module to show the binary input on the LCD
    display_16bit_binary display(
        .binary_input(temp_input),
        .clk(clk),
        .lcd_data(lcd_data),
        .lcd_enable(lcd_enable)
    );

    always @(posedge clk) begin
        if (KEY[0] == 1) begin
            // Enter key for first 16-bit input
            temp_input <= SW;  // Store the 16-bit input temporarily
            input_stage <= 0;  // Indicate it's for the first input stage
        end else if (KEY[1] == 1) begin
            if (input_stage == 0) begin
                // First stage input, assign to the lower 16 bits of "a"
                a[15:0] <= temp_input;
                input_stage <= 1;  // Switch to the next stage
            end else if (input_stage == 1) begin
                // Second stage input, assign to the upper 16 bits of "a"
                a[31:16] <= SW;
                input_stage <= 0;  // Reset the input stage after completing
            end
        end
    end

endmodule
