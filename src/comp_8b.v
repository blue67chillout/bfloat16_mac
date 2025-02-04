module  (
    input [7:0] in_1,   
    input [7:0] in_2,
    output gt
    
);
    assign gt = in_1 > in_2;
    
endmodule