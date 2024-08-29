module router_datapath(clk,rst,packet,write_en,valid_packet,read_data);

//output
output logic [7:0] read_data;

// tb --> router_dp 
input logic clk,rst;

// packet_gen --> router_dp
input logic [12:0] packet;

//router_dp --> router_controller
output logic valid_packet;

//router_controller --> router_dp
input logic write_en;

//reisters for storing paylog
//width = 8 bit
//depth = 4 bit
logic [7:0] reg_payload [3:0]; 

//intermediate wire for addr
logic [1:0] addr;

//decoding the package type for valid_packet
always@(*) begin
    case (packet[3:2])
          2'b00: valid_packet = 1'b1;
          2'b01: valid_packet = 1'b1;
          2'b10: valid_packet = 1'b1;
          2'b11: valid_packet = 1'b0;
    endcase
end
// decoding the dest_addr
always@(*) begin
    case (packet[1:0])
          2'b00: addr = 2'b00;
          2'b01: addr = 2'b01;
          2'b10: addr = 2'b10;
          2'b11: addr = 2'b11;
    endcase
end

//storing the payload

always_ff @(posedge clk or negedge rst) begin
    if(~rst)begin
        reg_payload[0] <= 0;
        reg_payload[1] <= 0;
        reg_payload[2] <= 0;
        reg_payload[3] <= 0;
    end
    else if (write_en)begin
        reg_payload[addr] <= packet[11:4];
    end
    else
       reg_payload[addr] <= reg_payload[addr];    
end

assign  read_data = reg_payload[addr];
 

endmodule


