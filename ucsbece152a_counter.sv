module ucsbece152a_counter #(
    parameter WIDTH = 3  // Parameter for the width of the counter
)(
    input logic clk,  // Clock signal
    input logic rst,  // Reset signal, active high
    output logic [WIDTH-1:0] count_o,  // Output of the counter
    // Part 2: Additional inputs for future features
    input logic enable_i,  // Enable input
    input logic dir_i  // Direction input (not used in this part)
);

    // Internal register to hold the count value
    logic [WIDTH-1:0] count;

    // Positive edge-triggered always block for handling the clock
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to 0 when rst is high
            count <= 0;
        end else if (enable_i) begin
            // Only increment the counter if it is enabled
            if (count == (2**WIDTH - 1)) begin
                // Wrap the counter to 0 when it reaches its maximum value
                count <= 0;
            end else begin
                // Increment the counter by 1
                count <= count + 1;
            end
        end
    end

    // Output assignment
    assign count_o = count;  // Output the value of count

endmodule
