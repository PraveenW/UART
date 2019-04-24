//`include u0if.sv
`include "reciever.v"
`include "transmitter.v"
module u0(u0if uif);

/*
modport u0(input clk,rst,read,write,din,addr,
        txack,rxack,tcack,rxdata,
    output dout,txdata,txir,rxir,tcir);

interface u0if ;
logic clk,rst;
logic read;         // bus read operation
logic [7:0] addr;   // device address
logic [7:0] din;    // bus data to UART
logic write;        // write operation
logic [7:0] dout;   // bus data from UART
logic txir;         // transmitter interrupt request
logic txack;        // Acknowledge for txir from CPU //Need to decide ont his bit
logic rxir;         // receiver interrupt request
logic rxack;        // rxir acknowledge //Need to decide on this bit
logic tcir;         // transmitter complete interrupt request
logic tcack;        // ack for transmitter complete
logic txdata;       // UART data out
logic rxdata;       // UART data in


*/

//-------------------------------------------------------------------------
//------USART Register Write Interface
//-------------------------------------------------------------------------

reg [7:0] ua,ub,uc,ubrrnh,ubrrnl;
wire trans_txcn;

wire rcv_rxcn;
wire rcv_dor,rcv_fr_err,rcv_par_err;
wire udren_flag;
wire [7:0] rcv_data;

always@(posedge uif.clk or posedge uif.rst)
begin
     if(uif.rst)
     begin 
     //ua <= 8'h20;
     //ua[7] <= 1'b0;
     //ua[4:0] <= 5'b00000;
     ua[1:0] <= 2'b00;
    // ub <= 8'h00;
     ub[0] <= 1'b0; //Ignore bit 1 write
     ub[7:2] <= 6'b0;
     uc <= 8'h06;
     ubrrnh <= 8'h00;
     ubrrnl <= 8'h00;
     end
     else
     begin 
          //ua[7] <= rcv_rxcn;
         // ua[4] <= rcv_fr_err;
         // ua[3] <= rcv_dor;
         // ua[2] <= rcv_par_err;
 //Need to check This Logic
       // if(uif.write && uif.addr == 8'hc6 && udren_flag == 1'b1)
       //   ua[5] <= 1'b0;;
     	if(uif.addr==8'hc0 && uif.write)
         begin
           //ua[6] <= ( uif.din[6] | trans_txcn) && (~uif.tcack);
           //ua[6] <= ( trans_txcn);
           ua[1] <= uif.din[1];
           ua[0] <= uif.din[0];
         end

         if(uif.addr==8'hc1 && uif.write)
         begin
           ub[0] <= uif.din[0]; //Ignore bit 1 write
           ub[7:2] <= uif.din[7:2];
         end
     
         if(uif.addr==8'hc2 && uif.write)
         begin
           uc <= uif.din;
         end

         if(uif.addr==8'hc5 && uif.write)
         begin
           ubrrnh <= uif.din;
         end
         
         if(uif.addr==8'hc4 && uif.write)
         begin
           ubrrnl <= uif.din;
         end
end
end



reg [7:0] addr_reg;
reg  write_reg;

always@(posedge uif.clk or posedge uif.rst)
begin
if(uif.rst)
begin
addr_reg <= 8'd0;
write_reg <= 1'b0;
end
else
begin
addr_reg <= uif.addr;
write_reg <= uif.write;
end
end




//----------------------------------------------------------------
//--UART Clock Generation Logic
//----------------------------------------------------------------
reg[11:0] cnt;
reg baud_clk;

always@ (posedge uif.clk or posedge uif.rst)
begin
   if(uif.rst)
   begin
   cnt <= 12'b0;
   baud_clk <= 0;
   end
   else
   	//if(cnt == 12'b0 || (uif.write && uif.addr==8'hc4))
   	if(cnt == 12'b0 || (write_reg && addr_reg==8'hc4))
             cnt <= ubrrnl[0] ? ({ubrrnh[3:0],ubrrnl} >> 1) : (({ubrrnh[3:0],ubrrnl} >> 1) - 12'h001);
        else
             cnt <= cnt - 12'h001;
             if(cnt == 12'h001)
             baud_clk <= ~baud_clk; 
end

//wire [11:0] cmp_value;
//assign cmp_value = ({ubrrnh[3:0],ubrrnl} >> 1);

//always@(posedge uif.clk or posedge uif.rst)
//begin
//    if(uif.rst)
//        baud_clk <= 0;
//    else
//     if(cnt == 12'b0)
//        baud_clk <= ~baud_clk;
//end

reg div_by2;

always@(posedge baud_clk or posedge uif.rst)
begin
   if(uif.rst)
   div_by2 <= 0;
   else
   div_by2 <= ~div_by2;
end


reg div_by4;

always@(posedge div_by2 or posedge uif.rst)
begin
   if(uif.rst)
   div_by4 <= 0;
   else
   div_by4 <= ~div_by4;
end


reg div_by8;

always@(posedge div_by4 or posedge uif.rst)
begin
   if(uif.rst)
   div_by8 <= 0;
   else
   div_by8 <= ~div_by8;
end



reg div_by16;

always@(posedge div_by8 or posedge uif.rst)
begin
   if(uif.rst)
   div_by16 <= 0;
   else
   div_by16 <= ~div_by16;
end

//----------------------------------------------------------------------------------------------------


wire txclk,rxclk,u2xn;

assign u2xn = ua[1];

assign txclk = u2xn? div_by8 : div_by16;
//assign rxclk = ~u2xn? baud_clk : div_by2;
assign rxclk = u2xn? div_by2 :baud_clk;




//Need to Work on Read Block and Instantiation of Transmitter and reciever
//------------------------------------------------------------------------
//-----Transmitter Block Instantiation
//------------------------------------------------------------------------
transmitter u1_trans (
.org_clk(uif.clk),
.clk(txclk),
.rst(uif.rst),


.tx_en(ub[3]), //From regB
.cs({ub[2],uc[2:1]}), //From reg B and C UCSZn
.txb8n(ub[0]),

//Reg C
.upmn(uc[5:4]),
.usbsn(uc[3]),

//Reg A
.txcn_flag(trans_txcn),
//.udren(uif.txir),
.udren(udren_flag),

.din(uif.din),
.addr(uif.addr),
.write(uif.write),
.txd(uif.txdata),
.a5(ua[5]),
.a6(ua[6]),
.tcack(uif.tcack)
);


//--------------------------------------------------------------------------
//-----Reciever Instantiation
//--------------------------------------------------------------------------


reciever u1_recv (
.org_clk(uif.clk),
//.clk(uif.clk),
.clk(rxclk),
.rst(uif.rst),
.rxen(ub[4]),
.sin(uif.rxdata),
.u2xn(ua[1]),
.upmn(uc[5:4]),
.addr(uif.addr),
.rxcn(rcv_rxcn),
.dor(rcv_dor),
.fr_err(rcv_fr_err),
.par_err(rcv_par_err),
.data(rcv_data),
.cs({ub[2],uc[2:1]}),
.read(uif.read),
.rxack(uif.rxack),
.a7(ua[7]),
.a4(ua[4]),
.a3(ua[3]),
.a2(ua[2]),
.b1(ub[1])
);








//-------------------------------------------------------------
//--USART Register Read Interface
//-------------------------------------------------------------

//always@(posedge uif.clk)
always@(*)
begin
if(uif.addr==8'hc0 && uif.read)
uif.dout <= ua;

if(uif.addr==8'hc1 && uif.read)
uif.dout <= ub;

if(uif.addr==8'hc2 && uif.read)
uif.dout <= uc;

if(uif.addr==8'hc6 && uif.read)
uif.dout <= rcv_data;



end



assign uif.rxir = rcv_rxcn;
assign uif.tcir = trans_txcn;
assign uif.txir = udren_flag;



endmodule


