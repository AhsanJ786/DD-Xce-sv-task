module router_top (clk,rst,packet,ready,valid,read_data);
// Packet_gen --> Router
input logic [12:0] packet;
input logic valid;

// router --> packet_gen
output logic ready;

// tb --> router
input logic clk,rst;

output logic [7:0] read_data;

//intermediate wire
logic valid_packet,write_en;

//joining both modules
router_controler rc(.clk(clk),
                    .rst(rst),
                    .valid(valid),
                    .ready(ready),
                    .write_en(write_en),
                    .valid_packet(valid_packet));

router_datapath rd(.clk(clk),
                    .rst(rst),
                    .packet(packet),
                    .write_en(write_en),
                    .valid_packet(valid_packet),
                    .read_data(read_data));

endmodule