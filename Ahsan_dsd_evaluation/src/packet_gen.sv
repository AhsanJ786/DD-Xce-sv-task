module packet_gen ( clk,rst,packet,ready,valid,dest_addr,pack_type,paylod); 

// TB --> Packet gen
input logic clk,rst;
input logic [1:0] dest_addr,pack_type;
input logic [7:0] paylod;

// Router --> PAcket gen
input logic ready;

// Packet gen --> Router
output logic [12:0] packet;
output logic valid;


//intermediate register to store data
logic [1:0] dest_addr_reg,pack_type_reg;
logic [7:0] paylod_reg;
logic EOP;




always_ff @( posedge clk or negedge rst ) 
begin 
    if (~rst)
    begin
        dest_addr_reg <= 0;
        pack_type_reg <= 0;
        paylod_reg    <= 0;
        valid         <= 0; 
        EOP           <= 0;   
    end
    else 
    begin
        if (ready)
        begin
            dest_addr_reg <= dest_addr;
            pack_type_reg <= pack_type;
            paylod_reg    <= paylod;
            valid         <= 1; 
            EOP           <= 1;
        end
        else 
        begin
            dest_addr_reg <= dest_addr_reg;
            pack_type_reg <= pack_type;
            paylod_reg    <= paylod_reg;
            valid         <= 0; 
            EOP           <= 1;
            
        end
    end
    
end
assign packet = {EOP,paylod_reg,pack_type_reg,dest_addr_reg};
 
    

endmodule