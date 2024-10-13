module display_16bit_binary(
    input [15:0] binary_input,   // 16-bit binary input to be displayed
    input clk,                   // Clock signal
    output reg [7:0] lcd_data,   // LCD data output (register type)
    output reg lcd_enable        // LCD enable signal
);

    integer i;
    reg [7:0] binary_display[0:15];  // Array to hold ASCII characters of binary number

    always @(posedge clk) begin
        for (i = 0; i < 16; i = i + 1) begin
            // Convert binary input to ASCII ('0' = 8'h30, '1' = 8'h31)
            binary_display[i] = binary_input[i] ? 8'h31 : 8'h30;
        end
    end

    // Example to send one bit at a time to the LCD (you can modify this for full display logic)
    always @(posedge clk) begin
        lcd_enable <= 1;
        lcd_data <= binary_display[0];  // Display the first character (you can extend this to a state machine to display the entire number)
    end

endmodule
