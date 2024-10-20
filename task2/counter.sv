module counter #(
    parameter WIDTH = 8
) (
    input logic     clk,
    input logic     rst,
    input logic     en,
    output logic [WIDTH-1:0] count
);

always_ff @ (posedge clk or posedge rst)
    if (rst)  count <= {WIDTH{1'b0}};      // Reset the counter to 0
    else count <= en ? count + { {(WIDTH-1){1'b0}}, 1 } : count - { {(WIDTH-1){1'b0}}, 1 }; // Correct replication and concatenation

endmodule
