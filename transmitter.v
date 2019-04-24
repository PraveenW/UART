module transmitter (
input org_clk,
input clk,
input rst,


input tx_en, //From regB
input [2:0] cs, //From reg A and B UCSZn
input txb8n,

//Reg C
input [1:0] upmn,
input usbsn,

//Reg A
output txcn_flag,
output udren,

input [7:0] din,
input [7:0] addr,
input write,

output txd,
output reg a5,
output reg a6,
input tcack

);

parameter idle      = 3'b000;
parameter start     = 3'b001;
parameter shift     = 3'b010;
parameter parity    = 3'b011;
parameter stop_bit  = 3'b100;



reg [7:0] udrn_reg,shift_reg,shift_reg_q;
reg udren_flag;
reg tx_data, tx_data_reg;

reg [2:0] state,nxt_state;


reg [3:0] tx_cnt,bit_cnt_reg,bit_cnt;
reg inc_tx_cnt;
reg clr_tx_cnt;
reg clr_stop_cnt_reg;
reg inc_stop_cnt_reg;
reg even_pvalue,odd_pvalue;
reg stop_cnt_reg;
reg txcn,txcn_intr;
//reg a5_bit;

//reg [7:0] shift_reg0;

always @(posedge org_clk or posedge rst)
begin
	if(rst)
	     begin
	      udrn_reg <= 8'b0;
              udren_flag <= 1;
              //shift_reg0 <= 8'b0;
              a5 <= 1'b1;
              //txcn_intr <= 1'b1;
              a6 <= 1'b1;
             end
        else 
	     begin
                   //if(state == stop_bit)
                  // txcn_intr <= txcn;
                   //a6 <= txcn;
               // if (write && addr == 8'hc6 && tx_en)
                if (write && addr == 8'hc6 && udren_flag == 1'b1 ) 
                    begin
                        udrn_reg <= din;
                        udren_flag <= 0;
                        a5 <= 1'b0;
                        a6 <= 1'b0;
                    end
                //if (udren_flag ==0 && txcn_intr )
                //  begin
                //   shift_reg0 <= udrn_reg;
                //   udren_flag <= 1;
                //   a5 <= 1'b1;
                //  end
                  
                //if (udren_flag == 0 && state==stop_bit && tcack)   //Need to declare state and shift ---Done
                if (udren_flag == 0 && txcn_intr && tcack)   //Need to declare state and shift ---Done
                begin                  
                    //udren_flag <= 1;
                    a5 <= 1'b1;
                end
               
                if (state== stop_bit)
                   udren_flag <= 1;
end
end



//Remember to connect udren_flag to udren;
//tx_data_reg to txd;


	
always@(*)
begin

nxt_state = state;
tx_data= 1;
shift_reg = 8'b0;
inc_tx_cnt =1'b0;
clr_tx_cnt=1'b0;
clr_stop_cnt_reg = 1'b0;
inc_stop_cnt_reg = 1'b0;
txcn = 1'b0;
//a5_bit = 1'b0;



case (state)
idle:  begin txcn = 1'b1;
       if (tx_en && udren_flag == 1'b1)
         nxt_state = idle;
       else
          begin 
              if( tx_en && udren_flag == 1'b0)  //Needs to add [or count==last_shift_done]
           	begin
                 tx_data = 1'b1;
                 nxt_state = start;
                 end
           end
        end

start: begin 
              tx_data = 1'b0;
              nxt_state = shift;
              shift_reg = udrn_reg;
              //shift_reg = shift_reg0;
       end




shift: begin
              tx_data= shift_reg_q[0];
              
              if(tx_cnt != bit_cnt_reg)
                  begin 
                      inc_tx_cnt=1'b1;
                      shift_reg = {txb8n,shift_reg_q[7:1]};
                      nxt_state = shift;
                  end
              
              if((tx_cnt == bit_cnt_reg) && upmn[1])
                   begin   nxt_state = parity; clr_tx_cnt=1'b1; end
                  
              if((tx_cnt == bit_cnt_reg) && !upmn[1])
                   begin   nxt_state = stop_bit; clr_tx_cnt=1'b1; end
       end

parity: begin 
            if(!upmn[0])
             begin
             tx_data = even_pvalue;
             nxt_state = stop_bit; //added now
             end
            else
            begin
                    tx_data = odd_pvalue;
                    nxt_state = stop_bit;
             end
         end



stop_bit: begin
              //a5_bit = 1'b1;
              tx_data =1'b1;
              if(usbsn != stop_cnt_reg)
              begin 
                    inc_stop_cnt_reg = 1'b1;
                    nxt_state = stop_bit;
              end
              else 
              begin 
                    clr_stop_cnt_reg =1'b1;
                    if(tx_en && udren_flag ==1'b0) nxt_state = start; else nxt_state = idle;
                    txcn =1;
              end
           end
endcase
end


always@(posedge clk or posedge rst)
begin
     if(rst)
     begin
        tx_data_reg <= 1'b1;
        shift_reg_q <= 8'b0;
        state <= idle;
        tx_cnt <= 4'b0;
        txcn_intr <= 1'b1;
        //a6 <= 1'b1;
    end
    else
    begin
        tx_data_reg <= tx_data;
        txcn_intr <= txcn;
        //a6 <= txcn;
        shift_reg_q <= shift_reg;
        state <= nxt_state;
         if(inc_tx_cnt)
          tx_cnt <= tx_cnt + 4'b0001;
         if(clr_tx_cnt)
          tx_cnt <= 4'b0000;
    end
end


always@(posedge clk or posedge rst)
begin
     if(rst)
     begin
          stop_cnt_reg <= 1'b0;
          bit_cnt_reg <= 4'b0111;
     end
     else
     begin
              bit_cnt_reg <= bit_cnt;
              if(inc_stop_cnt_reg)
                  stop_cnt_reg <= 1'b1;
              if(clr_stop_cnt_reg)
                  stop_cnt_reg <= 1'b0;
     end
end





//----------------------------------------------------------------------------------------
//Bit counts to send and Even odd Parity Value
//----------------------------------------------------------------------------------------

always@(*)
begin
bit_cnt = bit_cnt_reg;
even_pvalue = 1'b0;
odd_pvalue =1'b0;

    
    case (cs) //synopsys_fullcase
3'b000: begin bit_cnt = 4'b0100;
              even_pvalue= udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b0;
              odd_pvalue=  udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b1;
        end

3'b001: begin bit_cnt = 4'b0101; 
              even_pvalue= udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b0;
              odd_pvalue=  udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b1;
        end

3'b010: begin bit_cnt = 4'b0110;
              even_pvalue= udrn_reg[6] ^ udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b0;
              odd_pvalue= udrn_reg[6] ^ udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b1;
        end


3'b011: begin bit_cnt = 4'b0111; 
              even_pvalue= udrn_reg[7] ^ udrn_reg[6] ^ udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b0;
              odd_pvalue=  udrn_reg[7] ^ udrn_reg[6] ^ udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b1;
        end


3'b111: begin bit_cnt = 4'b1000;
              even_pvalue= txb8n ^ udrn_reg[7] ^ udrn_reg[6] ^ udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b0;
              odd_pvalue=  txb8n ^ udrn_reg[7] ^ udrn_reg[6] ^ udrn_reg[5] ^ udrn_reg[4] ^ udrn_reg[3] ^ udrn_reg[2] ^ udrn_reg[1] ^ udrn_reg[0] ^ 1'b1;
        end
endcase
end


assign txd = tx_data_reg;
assign udren = udren_flag;
assign txcn_flag = txcn_intr;

endmodule



