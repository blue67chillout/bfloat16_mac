import numpy as np

def float_to_bfloat16(value):
    """Convert a 32-bit float to bfloat16 by truncating the least significant 16 bits."""
    float32 = np.float32(value)
    int32 = float32.view(np.uint32)  # Get 32-bit binary representation
    bfloat16 = (int32 >> 16).astype(np.uint16)  # Keep only the top 16 bits
    
    print(f"Float: {value} --> Float32 (Binary): {bin(int32)[2:].zfill(32)} --> BFloat16 (Binary): {bin(bfloat16)[2:].zfill(16)}")
    
    return bfloat16

def bfloat16_to_float(bfloat16):
    """Convert a bfloat16 value back to a 32-bit float by extending precision."""
    int32 = np.uint32(bfloat16) << 16  # Shift left to restore 32-bit representation
    float32 = int32.view(np.float32)

    print(f"BFloat16 (Binary): {bin(bfloat16)[2:].zfill(16)} --> Restored Float32 (Binary): {bin(int32)[2:].zfill(32)} --> Float: {float32}")
    
    return float32

def bfloat16_multiply(a, b):
    """Multiply two bfloat16 numbers and return the result in bfloat16."""
    float_a = bfloat16_to_float(a)
    float_b = bfloat16_to_float(b)
    result = float_a * float_b
    print(f"Multiplication: {float_a} * {float_b} = {result}")
    
    result_bf16 = float_to_bfloat16(result)
    
    return result_bf16

# Example usage:
a = float_to_bfloat16(0.24411)  
b = float_to_bfloat16(-0.10577)  
result_bf16 = bfloat16_multiply(a, b)  
result_float = bfloat16_to_float(result_bf16)  

# Print final results
print(f"\nFinal Multiplication Result in BFloat16 (Hex): {hex(result_bf16)}")
print(f"Final Multiplication Result in BFloat16 (Binary): {bin(result_bf16)[2:].zfill(16)}")
print(f"Final Multiplication Result in Decimal: {result_float}")