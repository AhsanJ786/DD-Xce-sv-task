module tb_router;

  logic clk, rst;
  logic [1:0] dest_addr, pack_type;
  logic [7:0] paylod;
  logic [12:0] packet;
  logic ready, valid;
  logic [7:0] read_data;
  logic [7:0] ref_read_data;
  

 initial begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

  router_top dut (
    .clk(clk),
    .rst(rst),
    .packet(packet),
    .ready(ready),
    .valid(valid),
    .read_data(read_data)
  );

  packet_gen pg (
    .clk(clk),
    .rst(rst),
    .packet(packet),
    .ready(ready),
    .valid(valid),
    .dest_addr(dest_addr),
    .pack_type(pack_type),
    .paylod(paylod)
  );


  task init_sequence;
    begin
      clk = 0;
      rst = 0;
      dest_addr = 0;
      pack_type = 0;
      paylod = 0;
      @(posedge clk) rst = 1;  // Release reset
    end
  endtask


  task driver(input logic [1:0] i_dest_addr, input logic [1:0] i_pack_type, input logic [7:0] i_paylod);
    begin
      dest_addr = i_dest_addr;
      pack_type = i_pack_type;
      paylod = i_paylod;
      @(posedge clk);  // Wait for packet generation and routing
    end
  endtask

  
  task reference_model(input logic [12:0] i_packet, output logic [7:0] o_read_data);
    logic [1:0] addr;
    begin
      // Decode the destination address
      addr = i_packet[1:0];
      // Retrieve the payload from the packet
      o_read_data = i_packet[11:4];
    end
  endtask


  task monitor;
    begin
       @(posedge clk);
       @(posedge clk);
      reference_model(packet, ref_read_data);  // Generate reference data
      if (read_data !== ref_read_data) begin
        $display("ERROR: Mismatch at time %0t, Expected: %0h, Got: %0h", $time, ref_read_data, read_data);
      end
      else begin
        $display("SUCCESS: Match at time %0t, Expected: %0h, Got: %0h", $time, ref_read_data, read_data);
      end
    end
  endtask


  initial begin
    // Initialize
    init_sequence;

    // Apply test vectors
    driver(2'b00, 2'b01, 8'hAA);  
    monitor;

    driver(2'b01, 2'b10, 8'hBB); 
    monitor;

    driver(2'b10, 2'b11, 8'hCC); 
    monitor;

    driver(2'b11, 2'b00, 8'hDD);  
    monitor;



    repeat(10) @(posedge clk);
    $finish;  // End simulation
  end

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0);
  end

endmodule
