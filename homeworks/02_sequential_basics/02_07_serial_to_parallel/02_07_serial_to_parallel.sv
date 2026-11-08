//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_to_parallel
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      serial_valid,
    input                      serial_data,

    output logic               parallel_valid,
    output logic [width - 1:0] parallel_data
);
    // Task:
    // Implement a module that converts single-bit serial data to the multi-bit parallel value.
    //
    // The module should accept one-bit values with valid interface in a serial manner.
    // After accumulating 'width' bits and receiving last 'serial_valid' input,
    // the module should assert the 'parallel_valid' at the same clock cycle
    // and output 'parallel_data' value.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.

    localparam count_width = (width > 1) ? $clog2(width) : 1;
    logic [count_width - 1:0] bit_count;
    logic [width - 1:0] data_reg;

    assign parallel_valid = serial_valid && (bit_count == width - 1);
    assign parallel_data = (data_reg >> 1) | (width'(serial_data) << (width - 1));

    always_ff @ (posedge clk)
      if (rst) begin
        bit_count <= '0;
        data_reg  <= '0;
      end
      else if (serial_valid) begin
        data_reg <= parallel_data;
        if (bit_count == width - 1)
          bit_count <= '0;
        else
          bit_count <= bit_count + 1'b1;
      end

endmodule
