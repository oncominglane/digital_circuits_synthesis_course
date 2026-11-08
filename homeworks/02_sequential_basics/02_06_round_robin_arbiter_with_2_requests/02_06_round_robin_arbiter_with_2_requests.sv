//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module round_robin_arbiter_with_2_requests
(
    input        clk,
    input        rst,
    input  [1:0] requests,
    output [1:0] grants
);
    // Task:
    // Implement a "arbiter" module that accepts up to two requests
    // and grants one of them to operate in a round-robin manner.
    //
    // The module should maintain an internal register
    // to keep track of which requester is next in line for a grant.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.
    //
    // Example:
    // requests -> 01 00 10 11 11 00 11 00 11 11
    // grants   -> 01 00 10 01 10 00 01 00 10 01

    logic priority_one;

    assign grants[0] = requests[0] & (~requests[1] | ~priority_one);
    assign grants[1] = requests[1] & (~requests[0] |  priority_one);

    always_ff @ (posedge clk)
      if (rst)
        priority_one <= 1'b0;
      else if (grants[0])
        priority_one <= 1'b1;
      else if (grants[1])
        priority_one <= 1'b0;

endmodule
