# Floating-Point Adder Implementation in Verilog

## Overview
This documentation describes a Verilog implementation of a floating-point adder that follows the IEEE 754 standard for single-precision floating-point numbers. The adder takes two 32-bit floating-point numbers as inputs and produces their sum as output.

## IEEE 754 Single-Precision Format
Each 32-bit number consists of:
- 1 sign bit (bit 31)
- 8 exponent bits (bits 30-23)
- 23 mantissa bits (bits 22-0) with an implicit leading 1 for normalized numbers

## Implementation Details

### 1. Component Extraction
First, we extract the sign, exponent, and mantissa from each input number:

```verilog
wire sign_a = a[31];
wire sign_b = b[31];
wire [7:0] exp_a = a[30:23];
wire [7:0] exp_b = b[30:23];
wire [23:0] mant_a = {1'b1, a[22:0]}; // Implicit 1
wire [23:0] mant_b = {1'b1, b[22:0]}; // Implicit 1
```

### 2. Exponent Alignment
To add floating-point numbers, their exponents must be equal:

```verilog
wire [7:0] exp_diff = (exp_a > exp_b) ? (exp_a - exp_b) : (exp_b - exp_a);
assign mant_a_shifted = (exp_a > exp_b) ? mant_a : (mant_a >> exp_diff);
assign mant_b_shifted = (exp_b > exp_a) ? mant_b : (mant_b >> exp_diff);
wire [7:0] exp_common = (exp_a > exp_b) ? exp_a : exp_b;
```

### 3. Mantissa Addition/Subtraction
The aligned mantissas are added or subtracted based on the signs:

```verilog
assign mant_sum = (sign_a == sign_b) ? (mant_a_shifted + mant_b_shifted) :
                  (mant_a_shifted > mant_b_shifted) ? (mant_a_shifted - mant_b_shifted) :
                                                     (mant_b_shifted - mant_a_shifted);
```

### 4. Result Normalization
The result is normalized to maintain proper floating-point representation:

```verilog
always @(*) begin
    if (mant_sum[24]) begin
        mant_result = mant_sum[24:1];
        exp_result = exp_common + 1;
    end else begin
        mant_result = mant_sum[23:0];
        exp_result = exp_common;
    end
end
```

### 5. Sign Determination
The final sign is determined based on the operation and operand magnitudes:

```verilog
assign sign_result = (mant_sum == 0) ? 0 : 
                     (sign_a == sign_b) ? sign_a : 
                     (mant_a > mant_b) ? sign_a : sign_b;
```

### 6. Zero Handling
Special handling for zero results:

```verilog
assign result = (mant_sum == 0) ? 32'b0 : {sign_result, exp_result, mant_result[22:0]};
```

## Operation Steps
1. **Input Processing**: Break down inputs into sign, exponent, and mantissa components
2. **Alignment**: Adjust smaller exponent by shifting corresponding mantissa
3. **Operation**: Add or subtract mantissas based on signs
4. **Normalization**: Adjust result to maintain proper floating-point format
5. **Final Assembly**: Combine sign, exponent, and mantissa for final result

## Notes
- This implementation follows IEEE 754 single-precision format
- Handles basic addition and subtraction cases
- Includes proper normalization of results
- Special cases like zero are properly handled
- The implementation assumes normalized inputs

## Usage
To use this adder in your design:
1. Include the module in your Verilog project
2. Connect two 32-bit IEEE 754 single-precision floating-point numbers
3. The result will be available in the same format

## Limitations
- Does not handle special cases like NaN or infinity
- Assumes inputs are normalized
- Rounding is not implemented
