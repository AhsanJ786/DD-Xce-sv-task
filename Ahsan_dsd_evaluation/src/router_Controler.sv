module router_controler (clk,rst,valid,ready,write_en,valid_packet);

//Router_controller --> Router_datapath
output logic write_en;

//router_datapath --> Router_controller
input logic valid_packet;

//tb -->router controller 
input logic clk,rst;

//router controller --> packet_gen
output logic ready;

// packet_gen --> router controller 
input logic valid;

typedef enum logic [1:0] {
        Idle   = 2'b00,
        Decode = 2'b01,
        Write  = 2'b10
    } state_t;

state_t c_state,n_state;


// State transition logic
always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        c_state <= Idle;
    end 
    else begin
        c_state <= n_state;
    end
end

// output and next_state logic
always_comb begin 
    case (c_state)
       Idle:begin
            if(~valid)begin
                ready   = 1'b1;
                n_state = Idle;
            end
            else begin
                ready   = 1'b1;
                n_state = Decode;
            end
       end
       Decode:begin
            if(valid_packet) begin
                write_en = 0;
                ready    = 0;
                n_state  = Write;
            end
            else begin
                write_en = 0;
                ready    = 0;
                n_state  = Idle;   
            end
       end
       Write: begin
            write_en    =  1'b1;
            ready       =   0;
            n_state     =  Idle;
       end
        
    endcase
    
end



endmodule