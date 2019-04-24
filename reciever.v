//////////////////////////////////////////////////////////////////////////////////
// Company: San Jose State University
// Engineer: Praveen Waliitagi
// 
// Create Date:    13:08:29 04/09/2015 
// Design Name: USART0
// Module Name:    reciever
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module reciever (
input org_clk,
input clk,
input rst,
input rxen,
input sin,
input u2xn,
input [1:0] upmn,
input [7:0] addr,
output rxcn,
output dor,
output fr_err,
output par_err,
output [7:0] data,
input [2:0] cs,
input read,
input rxack,
output reg a7,
output reg a4,
output reg a3,
output reg a2,
output reg b1
);


parameter idle      = 3'b000;
parameter start     = 3'b001;
parameter recieve     = 3'b010;
parameter parity    = 3'b011;
parameter stop_error  = 3'b100;
//parameter wait_for_rd = 3'b101;
parameter wait_for_idle = 3'b101;

//reg [11:0] data_reg [0:1];
reg [12:0] data_reg;
reg rd_ptr;

reg clr_tick_cnt;
reg inc_tick_cnt;
reg inc_rx_cnt;
reg clr_rx_cnt;
reg shift;
reg load;
reg fr_err_reg;
reg p_on;
reg [2:0] nxt_state,state;
reg rxcn_bit;
//reg rxcn_reg;
reg dor_reg;

//reg [1:0] ld_cnt;

reg pbit;


reg [3:0] tick_counter;
reg [3:0] rx_cnt,bit_cnt,bit_cnt_reg;
//reg [7:0] rcv_shift_reg;
//reg [8:0] rcv_shift_reg;
reg [9:0] rcv_shift_reg;

//Add Logic for bit_cnt_reg

wire [3:0] ctr_pt,total;

assign ctr_pt = u2xn ? 4'b0011 : 4'b0111;
assign total = u2xn ?  4'b0111 : 4'b1111;


wire[3:0] remaining;

reg [2:0] state_ext; 
reg  parity_err;
reg load_reg;

always@(posedge org_clk or posedge rst)
begin
if (rst)
begin
a7 <= 1'b0;
state_ext <= 3'b000;
a4 <= 1'b0;
a3 <= 1'b0;
a2 <= 1'b0;
b1 <= 1'b0;
//load_reg <= 1'b0;
end
else
begin
//load_reg <= load;
if(load && bit_cnt_reg==4'b1000 && upmn[1])
b1 <= rcv_shift_reg[8];
else if(load && bit_cnt_reg==4'b1000 && ~upmn[1])
b1 <= rcv_shift_reg[9];

//if(addr==8'hc1 && read)
if(addr==8'hc6 && read)
b1 <= 1'b0;


state_ext <= state;
                if(state_ext == stop_error && data_reg[12]) 
		begin
		a7 <= 1'b1;
	//	a4<= fr_err_reg;
	//	a3<= 1'b0;
	//		if(upmn[1])
	//		a2<= rcv_shift_reg[8];
	//		else
	//		a2<= 1'b0;
		end
                if(fr_err_reg)
                a4 <= fr_err_reg;
                if(upmn[1])
                a2 <= ~parity_err;
			
                if(addr==8'hc6 && read)
		begin
                a7 <= 1'b0;
                a4<= 1'b0;
                a3<= 1'b0;
                a2<= 1'b0;
                end

end
end




always@(*)
begin

clr_tick_cnt = 0;
inc_tick_cnt =0;
inc_rx_cnt =0;
clr_rx_cnt =0;
shift=0;
load=0;
fr_err_reg=0;
p_on=0;
nxt_state=state;
rxcn_bit=0;
dor_reg=0;


case (state)

idle: begin 
        if (rxen && sin==1'b0)
        nxt_state = start;
        else
        nxt_state = idle;
      end

start: begin
          if(sin == 1'b1) 
              begin
              nxt_state = idle;
              clr_tick_cnt =1'b1;
              end
         else
          if(tick_counter == ctr_pt)
               begin
               nxt_state = recieve;
               clr_tick_cnt =1'b1;
               end
           else
              inc_tick_cnt =1'b1; 
        end

recieve: begin
            if(tick_counter < total && rx_cnt <= bit_cnt_reg)
                 inc_tick_cnt =1'b1;
            else
                begin
                   clr_tick_cnt=1'b1;
                   if(rx_cnt <= bit_cnt_reg)
                   begin
                       shift =1'b1;
                       inc_rx_cnt =1'b1;
                   end
                   else
                   begin
                        clr_rx_cnt =1'b1;
                        if(upmn[1])
                            nxt_state = parity;
                        else
                            nxt_state = stop_error;
                   end
                end
              end



parity: begin
            if(tick_counter < total )
               inc_tick_cnt =1'b1;
            else
               begin
               clr_tick_cnt = 1'b1;
               //p_on=1;
               shift=1;
               nxt_state = stop_error;
              end
       end

stop_error: begin
                 if(tick_counter < total )
                     inc_tick_cnt =1'b1;
                 else
                     begin
                           clr_tick_cnt = 1'b1;
                           //nxt_state = idle;
                           rxcn_bit =1'b1;
                           load =1'b1;
                           
                           if(sin ==1'b0)
                              begin
                                fr_err_reg = 1'b1;
                                nxt_state = wait_for_idle;
                              end
                           else
                              begin
                                fr_err_reg = 1'b0;  //Need to Think about this Logic
                                nxt_state = idle; 
                              end
                          //  if(ld_cnt < 2'b10)
                          //         begin
                          //         load =1'b1;
                          //         nxt_state = idle;
                          //         end
                          //   else
                          //         nxt_state = wait_for_rd;
                       end
             end

//Add Logic for bit_cnt_reg and ld_cnt


//wait_for_rd: begin
//                 if(tick_counter < total)
//                      inc_tick_cnt =1'b1;
//                 else
//                    begin 
//                         if(ld_cnt == 2'b10 && sin==1'b0)
//                             begin
//                             dor_reg = 1'b1; //Need to work on this
//                             nxt_state = wait_for_rd;
//                             end
//                          else
//                             begin 
//                             load=1'b1;
//                             nxt_state = idle;
//                             dor_reg = 1'b1;
//                             end
//                    end
//               end
//

wait_for_idle : begin  if (sin==1'b0)
                        nxt_state = wait_for_idle;
                       else
                        nxt_state = idle;
                end

                    




endcase                 

end


always@(posedge clk or posedge rst)
begin
      if(rst)
      begin 
          state <= idle;
          tick_counter <= 4'b0;
          rx_cnt <= 4'b0;
          rcv_shift_reg <= 10'b0;
          data_reg <= 13'b0;
          //data_reg[1] <= 12'b0;
          //ld_cnt <= 2'b00;
          //bit_cnt_reg <=  4'b0000;
          pbit <= 1'b0;
          bit_cnt_reg <= 4'b0111;
          //rxcn_reg <= 1'b0;
          
      end

     else
          begin
          state <= nxt_state;
          bit_cnt_reg <= bit_cnt;
          //rxcn_reg <= rxcn_bit;
          if(clr_tick_cnt) tick_counter <= 4'b0000;
          else if(inc_tick_cnt) tick_counter <= tick_counter + 4'b0001; 
          
          //if(p_on) 
          //pbit <= sin;
          
          
          if(inc_rx_cnt) rx_cnt <= rx_cnt + 4'b0001;
          else if(clr_rx_cnt) rx_cnt <= 4'b0000;
          
          if(shift)
          //rcv_shift_reg <= {sin,rcv_shift_reg[8:1]};
          rcv_shift_reg <= {sin,rcv_shift_reg[9:1]};
          
          if(load==1'b1 && upmn[1]) 
          //data_reg <= {rxcn_bit,dor_reg,fr_err_reg,pbit,(rcv_shift_reg >> remaining)};
          //data_reg <= {dor_reg,fr_err_reg,pbit,(rcv_shift_reg >> remaining)};
          //data_reg <= {dor_reg,fr_err_reg,rcv_shift_reg[8],(rcv_shift_reg[7:0] >> remaining)};
          data_reg <= {dor_reg,fr_err_reg,rcv_shift_reg[9],(rcv_shift_reg[8:0] >> remaining)};
          else if(load==1'b1 && ~upmn[1])
          //data_reg <= {rxcn_bit,dor_reg,fr_err_reg,1'b0,(rcv_shift_reg >> remaining)};
          //data_reg <= {dor_reg,fr_err_reg,1'b0,(rcv_shift_reg >> remaining)};
          data_reg <= {dor_reg,fr_err_reg,1'b0,(rcv_shift_reg[9:1] >> remaining)};
          
          data_reg[12] <= rxcn_bit;
           //ld_cnt <= ld_cnt + 2'b01;
          //else if(read && addr == 8'hc6)
          //ld_cnt <= ld_cnt - 2'b01;
      
          end

end

          
          
//----------------------------------------------------------------------------------------
//Bit counts to Recieve total number of bits
//----------------------------------------------------------------------------------------
reg even_pbit0,odd_pbit0,even_pbit1,odd_pbit1;
reg parity_error;
//reg [1:0] parity_err;


always@(*)
begin
bit_cnt = bit_cnt_reg;
even_pbit0 =0;
odd_pbit0 =0;
//even_pbit1=0;
//odd_pbit1=0;    
    case (cs) //synopsys_fullcase
3'b000: begin bit_cnt = 4'b0100;
              even_pbit0= data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b0;
              odd_pbit0=  data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b1;
               
              //even_pbit1= data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b0;
              //odd_pbit1=  data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b1;
        end

3'b001: begin bit_cnt = 4'b0101; 
              even_pbit0= data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b0;
              odd_pbit0=  data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b1;
              
              //even_pbit1= data_reg[5] ^ data_reg[4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b0;
              //odd_pbit1=  data_reg[5] ^ data_reg[4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b1;
        end

3'b010: begin bit_cnt = 4'b0110;
              even_pbit0= data_reg[6] ^ data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b0;
              odd_pbit0=  data_reg[6] ^ data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b1;
                            
              //even_pbit1= data_reg[1][6] ^ data_reg[1][5] ^ data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b0;
              //odd_pbit1=  data_reg[1][6] ^ data_reg[1][5] ^ data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b1;
        end


3'b011: begin bit_cnt = 4'b0111; 
              even_pbit0= data_reg[7] ^ data_reg[6] ^ data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b0;
              odd_pbit0=  data_reg[7] ^ data_reg[6] ^ data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b1;
              
              //even_pbit1= data_reg[1][7] ^ data_reg[1][6] ^ data_reg[1][5] ^ data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b0;
              //odd_pbit1=  data_reg[1][7] ^ data_reg[1][6] ^ data_reg[1][5] ^ data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b1;
                
        end


3'b111: begin bit_cnt = 4'b1000;
              even_pbit0= data_reg[8]^data_reg[7] ^ data_reg[6] ^ data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b0;
              odd_pbit0=  data_reg[8]^data_reg[7] ^ data_reg[6] ^ data_reg[5] ^ data_reg[4] ^ data_reg[3] ^ data_reg[2] ^ data_reg[1] ^ data_reg[0] ^ 1'b1;
              //odd_pbit1=  data_reg[1][7] ^ data_reg[1][6] ^ data_reg[1][5] ^ data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b1;
              //even_pbit1= data_reg[1][7] ^ data_reg[1][6] ^ data_reg[1][5] ^ data_reg[1][4] ^ data_reg[1][3] ^ data_reg[1][2] ^ data_reg[1][1] ^ data_reg[1][0] ^ 1'b0;
        end
endcase
end

//------------------------------------------------------------------------------
//----Parity Error Logic
//------------------------------------------------------------------------------

always@(*)
begin

if(upmn[1])
begin
if(~upmn[0])
begin
parity_err = (even_pbit0 != data_reg[9]);
//parity_err = (even_pbit0 != data_reg[8]);
//parity_err = (even_pbit0 != rcv_shift_reg[8]);
//parity_err[1] = (even_pbit1 != data_reg[1][8]);
end
else
begin
parity_err = (odd_pbit0 != data_reg[9]);
//parity_err = (odd_pbit0 != data_reg[8]);
//parity_err = (odd_pbit0 != rcv_shift_reg[8]);
//parity_err[1] = (odd_pbit1 != data_reg[1][8]);
end
end
else
parity_err = 1'b0;
end



assign remaining = 4'd8 - bit_cnt_reg;



//always@(posedge clk or posedge rst)
//begin
//     if(rst)
//     rd_ptr <= 0;
//     else
//     if(read && addr == 8'hc6)
//      rd_ptr <= ~rd_ptr;
//end



//assign data = (read && addr==8'hc6) ? data_reg[7:0] : 8'b0;
assign data = data_reg[7:0];

assign rxcn = data_reg[12]; //Need to Handle Multiple Data

//assign dor = (read && addr==8'hc0) ? data_reg[10] : 1'b0;
assign dor = data_reg[10];
//assign fr_err = (read && addr==8'hc0) ? data_reg[9] : 1'b0;
assign fr_err = data_reg[9];
//assign par_err = (read && addr==8'hc0) ? data_reg[8] : 1'b0;
assign par_err = data_reg[8];



endmodule

