//
// The interface for the USART0
//

interface u0if ;
logic clk,rst;
logic read;         // bus read operation
logic [7:0] addr;   // device address
logic [7:0] din;    // bus data to UART
logic write;        // write operation
logic [7:0] dout;   // bus data from UART
logic txir;         // transmitter interrupt request
logic txack;        // Acknowledge for txir from CPU
logic rxir;         // receiver interrupt request
logic rxack;        // rxir acknowledge
logic tcir;         // transmitter complete interrupt request
logic tcack;        // ack for transmitter complete
logic txdata;       // UART data out
logic rxdata;       // UART data in


clocking CB @(posedge clk );
  output #1 rst,read,addr,din,write,tcack,txack,rxack;
  input dout,txir,rxir,tcir;
endclocking

modport dw(input txir,rxir,tcir,txdata,
            rst,read,addr,din,write,clocking CB,
            output rxdata);
//
// modport u0 is on the UART design
// notice the clocking block is not given to the UART
// Note: No synchronous mode support. (No clock out)
//
modport u0(input clk,rst,read,write,din,addr,
        txack,rxack,tcack,rxdata,
    output dout,txdata,txir,rxir,tcir);

endinterface : u0if
