module fp_adder (
    input [31:0]in_1,
    input [31:0]in_2,
    output [31:0]out
);

wire sign;
wire [7:0]exp_diff;
wire [23:0]in_1_aligned_mant;
wire [23:0]in_2_aligned_mant;
wire [24:0]mant_sum;
wire [7:0]final_exp;

assign exp_diff = ( in_1[30:23] > in_2[30:23] ) ? in_1[30:23] - in_2[30:23] : in_2[30:23] - in_1[30:23];
assign final_exp = (in_1[30:23] > in_2[30:23]) ? in_1[30:23] : in_2[30:23];
assign in_1_aligned_mant = (in_1[30:23] > in_2[30:23]) ? {1'b1,in_1[22:0]} : ({1'b1,in_1[22:0]}>>exp_diff);
assign in_2_aligned_mant = (in_2[30:23] > in_1[30:23]) ? {1'b1,in_2[22:0]} : ({1'b1,in_2[22:0]}>>exp_diff);
assign sign = (in_1_aligned_mant > in_2_aligned_mant) ? in_1[31] : in_2[31];

assign mant_sum = (in_1[31] == in_2[31]) ? in_1_aligned_mant + in_2_aligned_mant : in_1_aligned_mant - in_2_aligned_mant;

reg [7:0] norm_exp;
reg [23:0] norm_mant;
integer shift;

    always @(*) begin
        if (mant_sum[24]) begin
            norm_mant = mant_sum[24:1]; // Shift right if carry
            norm_exp = final_exp + 1;
        end else begin
            norm_mant = mant_sum[23:0];
            norm_exp = final_exp;
        end

        // Normalize if leading bits are zero
        shift = 0;
        while (norm_mant[23] == 0 && norm_exp > 0) begin
            norm_mant = norm_mant << 1;
            norm_exp = norm_exp - 1;
            shift = shift + 1;
        end

        // Set result
        result = {sign_a, norm_exp, norm_mant[22:0]};
    end
    
endmodule