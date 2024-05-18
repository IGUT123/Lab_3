module ucsbece152a_counter #(
    parameter WIDTH = 3  // Parameter for the width of the counter
)(
    input logic clk,  // Clock signal
    input logic rst,  // Reset signal, active high
    output logic [WIDTH-1:0] count_o,  // Output of the counter
    input logic enable_i,  // Enable input to control counting
    input logic dir_i  // Direction input, 0 for increment, 1 for decrement
);

    // Internal register to hold the count value
    logic [WIDTH-1:0] count;

    // Positive edge-triggered always block for handling the clock
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to 0 when rst is high
            count <= 0;
        end else if (enable_i) begin
            // Only modify the counter if it is enabled
            if (dir_i) begin
                // Decrement the counter if dir_i is 1
                if (count == 0) count <= (2**WIDTH - 1);  // Wrap to max if it's 0
                else count <= count - 1;
            end else begin
                // Increment the counter if dir_i is 0
                if (count == (2**WIDTH - 1)) count <= 0;  // Wrap to 0 if max
                else count <= count + 1;
            end
        end
        // If enable_i is 0, do nothing (counter holds its value)
    end

    // Output assignment
    assign count_o = count;  // Output the value of count

endmodule
