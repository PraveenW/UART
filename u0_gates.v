
module u0 ( \uif.clk , \uif.rst , \uif.read , \uif.write , \uif.din , 
        \uif.addr , \uif.txack , \uif.rxack , \uif.tcack , \uif.rxdata , 
        \uif.dout , \uif.txdata , \uif.txir , \uif.rxir , \uif.tcir  );
  input [7:0] \uif.din ;
  input [7:0] \uif.addr ;
  output [7:0] \uif.dout ;
  input \uif.clk , \uif.rst , \uif.read , \uif.write , \uif.txack ,
         \uif.rxack , \uif.tcack , \uif.rxdata ;
  output \uif.txdata , \uif.txir , \uif.rxir , \uif.tcir ;
  wire   write_reg, N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56,
         baud_clk, div_by2, div_by4, div_by8, div_by16, txclk, rxclk,
         rcv_fr_err, rcv_par_err, \u1_trans/stop_cnt_reg ,
         \u1_trans/bit_cnt_reg[0] , \u1_trans/bit_cnt_reg[1] ,
         \u1_trans/bit_cnt_reg[2] , \u1_trans/bit_cnt_reg[3] ,
         \u1_trans/tx_cnt[0] , \u1_trans/tx_cnt[1] , \u1_trans/tx_cnt[2] ,
         \u1_trans/tx_cnt[3] , \u1_trans/txcn , \u1_trans/tx_data ,
         \u1_trans/state[0] , \u1_trans/state[1] , \u1_trans/state[2] ,
         \u1_trans/udrn_reg[0] , \u1_trans/udrn_reg[1] ,
         \u1_trans/udrn_reg[2] , \u1_trans/udrn_reg[3] ,
         \u1_trans/udrn_reg[4] , \u1_trans/udrn_reg[5] ,
         \u1_trans/udrn_reg[6] , \u1_trans/udrn_reg[7] , \u1_recv/rx_cnt[0] ,
         \u1_recv/rx_cnt[1] , \u1_recv/rx_cnt[2] , \u1_recv/rx_cnt[3] ,
         \u1_recv/tick_counter[0] , \u1_recv/tick_counter[1] ,
         \u1_recv/tick_counter[2] , \u1_recv/tick_counter[3] ,
         \u1_recv/rxcn_bit , \u1_recv/state[0] , \u1_recv/state[1] ,
         \u1_recv/state[2] , \u1_recv/rcv_shift_reg[0] ,
         \u1_recv/rcv_shift_reg[1] , \u1_recv/rcv_shift_reg[2] ,
         \u1_recv/rcv_shift_reg[3] , \u1_recv/rcv_shift_reg[4] ,
         \u1_recv/rcv_shift_reg[5] , \u1_recv/rcv_shift_reg[6] ,
         \u1_recv/rcv_shift_reg[7] , \u1_recv/rcv_shift_reg[8] ,
         \u1_recv/rcv_shift_reg[9] , \u1_recv/bit_cnt_reg[0] ,
         \u1_recv/bit_cnt_reg[1] , \u1_recv/bit_cnt_reg[2] ,
         \u1_recv/bit_cnt_reg[3] , n313, n314, n315, n316, n317, n318, n319,
         n320, n321, n322, n323, n324, n325, n326, n327, n328, n329, n330,
         n331, n332, n333, n334, n335, n336, n337, n338, n339, n340, n341,
         n342, n343, n344, n345, n346, n347, n348, n349, n350, n351, n352,
         n353, n354, n355, n356, n357, n358, n359, n360, n361, n362, n363,
         n364, n365, n366, n367, n368, n369, n370, n371, n372, n373, n374,
         n375, n376, n377, n378, n379, n380, n381, n382, n383, n384, n385,
         n386, n387, n388, n389, n390, n391, n392, n393, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464,
         n465, n466, n467, n468, n469, n470, n471, n472, n473, n474, n475,
         n476, n477, n478, n479, n480, n481, n482, n483, n484, n485, n486,
         n487, n488, n489, n490, n491, n492, n493, n494, n495, n496, n497,
         n498, n499, n500, n501, n502, n503, n504, n505, n506, n507, n508,
         n509, n510, n511, n512, n513, n514, n515, n516, n517, n518, n519,
         n520, n521, n522, n523, n524, n525, n526, n527, n528, n529, n530,
         n531, n532, n533, n534, n535, n536, n537, n538, n539, n540, n541,
         n542, n543, n544, n545, n546, n547, n548, n549, n550, n551, n552,
         n553, n554, n555, n556, n557, n558, n559, n560, n561, n562, n563,
         n564, n565, n566, n567, n568, n569, n570, n571, n572, n573, n574,
         n575, n576, n577, n578, n579, n580, n581, n582, n583, n584, n585,
         n586, n587, n588, n589, n590, n591, n592, n593, n594, n595, n596,
         n597, n598, n599, n600, n601, n602, n603, n604, n605, n606, n607,
         n608, n609, n610, n611, n612, n613, n614, n615, n616, n617, n618,
         n619, n620, n621, n622, n623, n624, n625, n626, n627, n628, n629,
         n630, n631, n632, n633, n634, n635, n636, n637, n638, n639, n640,
         n641, n642, n643, n644, n645, n646, n647, n648, n649, n650, n651,
         n652, n653, n654, n655, n656, n657, n658, n659, n660, n661, n662,
         n663, n664, n665, n666, n667, n668, n669, n670, n671, n672, n673,
         n674, n675, n676, n677, n678, n679, n680, n681, n682, n683, n684,
         n685, n686, n687, n688, n689, n690, n691, n692, n693, n694, n695,
         n696, n697, n698, n699, n700, n701, n702, n703, n704, n705, n706,
         n707, n708, n709, n710;
  wire   [7:0] ua;
  wire   [7:0] ub;
  wire   [7:0] uc;
  wire   [3:0] ubrrnh;
  wire   [7:0] ubrrnl;
  wire   [7:0] addr_reg;
  wire   [11:0] cnt;
  wire   [7:0] rcv_data;
  wire   [7:0] data_out;
  wire   [3:0] \u1_trans/bit_cnt ;
  wire   [7:0] \u1_trans/shift_reg_q ;
  wire   [7:0] \u1_trans/shift_reg ;
  wire   [3:0] \u1_recv/bit_cnt ;
  wire   [2:0] \u1_recv/nxt_state ;
  wire   [2:0] \u1_recv/state_ext ;

  CFD4QXL \uc_reg[2]  ( .D(n314), .CP(\uif.clk ), .SD(n450), .Q(uc[2]) );
  CFD4QXL \uc_reg[1]  ( .D(n313), .CP(\uif.clk ), .SD(n450), .Q(uc[1]) );
  CFD4QXL \u1_trans/bit_cnt_reg_reg[0]  ( .D(\u1_trans/bit_cnt [0]), .CP(txclk), .SD(n450), .Q(\u1_trans/bit_cnt_reg[0] ) );
  CFD4QXL \u1_trans/bit_cnt_reg_reg[1]  ( .D(\u1_trans/bit_cnt [1]), .CP(txclk), .SD(n450), .Q(\u1_trans/bit_cnt_reg[1] ) );
  CFD4QXL \u1_trans/bit_cnt_reg_reg[2]  ( .D(\u1_trans/bit_cnt [2]), .CP(txclk), .SD(n450), .Q(\u1_trans/bit_cnt_reg[2] ) );
  CFD4QXL \u1_trans/udren_flag_reg  ( .D(n393), .CP(\uif.clk ), .SD(n450), .Q(
        \uif.txir ) );
  CFD4QXL \u1_trans/txcn_intr_reg  ( .D(\u1_trans/txcn ), .CP(txclk), .SD(n450), .Q(\uif.tcir ) );
  CFD4QXL \u1_trans/a5_reg  ( .D(n384), .CP(\uif.clk ), .SD(n450), .Q(ua[5])
         );
  CFD4QXL \u1_trans/tx_data_reg_reg  ( .D(\u1_trans/tx_data ), .CP(txclk), 
        .SD(n450), .Q(\uif.txdata ) );
  CFD4QXL \u1_trans/a6_reg  ( .D(n383), .CP(\uif.clk ), .SD(n450), .Q(ua[6])
         );
  CFD4QXL \u1_recv/bit_cnt_reg_reg[0]  ( .D(\u1_recv/bit_cnt [0]), .CP(rxclk), 
        .SD(n450), .Q(\u1_recv/bit_cnt_reg[0] ) );
  CFD4QXL \u1_recv/bit_cnt_reg_reg[1]  ( .D(\u1_recv/bit_cnt [1]), .CP(rxclk), 
        .SD(n450), .Q(\u1_recv/bit_cnt_reg[1] ) );
  CFD4QXL \u1_recv/bit_cnt_reg_reg[2]  ( .D(\u1_recv/bit_cnt [2]), .CP(rxclk), 
        .SD(n450), .Q(\u1_recv/bit_cnt_reg[2] ) );
  CFD2QXL \u1_trans/shift_reg_q_reg[7]  ( .D(\u1_trans/shift_reg [7]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [7]) );
  CFD2QXL \u1_trans/shift_reg_q_reg[6]  ( .D(\u1_trans/shift_reg [6]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [6]) );
  CFD2QXL \u1_trans/shift_reg_q_reg[5]  ( .D(\u1_trans/shift_reg [5]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [5]) );
  CFD2QXL \u1_trans/shift_reg_q_reg[4]  ( .D(\u1_trans/shift_reg [4]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [4]) );
  CFD2QXL \u1_trans/shift_reg_q_reg[3]  ( .D(\u1_trans/shift_reg [3]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [3]) );
  CFD2QXL \u1_trans/shift_reg_q_reg[2]  ( .D(\u1_trans/shift_reg [2]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [2]) );
  CFD2QXL \u1_trans/shift_reg_q_reg[1]  ( .D(\u1_trans/shift_reg [1]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [1]) );
  CFD2QXL \u1_trans/shift_reg_q_reg[0]  ( .D(\u1_trans/shift_reg [0]), .CP(
        txclk), .CD(n450), .Q(\u1_trans/shift_reg_q [0]) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[5]  ( .D(n374), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[5] ) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[2]  ( .D(n371), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[2] ) );
  CFD2QXL \u1_recv/data_reg_reg[12]  ( .D(\u1_recv/rxcn_bit ), .CP(rxclk), 
        .CD(n450), .Q(\uif.rxir ) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[3]  ( .D(n372), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[3] ) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[0]  ( .D(n369), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[0] ) );
  CFD2QXL div_by4_reg ( .D(n397), .CP(div_by2), .CD(n450), .Q(div_by4) );
  CFD2QXL \u1_recv/rx_cnt_reg[2]  ( .D(n366), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/rx_cnt[2] ) );
  CFD2QXL \u1_recv/rx_cnt_reg[3]  ( .D(n365), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/rx_cnt[3] ) );
  CFD2QXL div_by16_reg ( .D(n399), .CP(div_by8), .CD(n450), .Q(div_by16) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[8]  ( .D(n377), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[8] ) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[7]  ( .D(n376), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[7] ) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[6]  ( .D(n375), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[6] ) );
  CFD2QXL \u1_recv/data_reg_reg[8]  ( .D(n356), .CP(rxclk), .CD(n450), .Q(
        rcv_par_err) );
  CFD2QXL \u1_recv/rx_cnt_reg[1]  ( .D(n367), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/rx_cnt[1] ) );
  CFD2QXL \u1_trans/bit_cnt_reg_reg[3]  ( .D(\u1_trans/bit_cnt [3]), .CP(txclk), .CD(n450), .Q(\u1_trans/bit_cnt_reg[3] ) );
  CFD2QXL \u1_trans/stop_cnt_reg_reg  ( .D(n385), .CP(txclk), .CD(n450), .Q(
        \u1_trans/stop_cnt_reg ) );
  CFD2QXL \u1_recv/data_reg_reg[9]  ( .D(n355), .CP(rxclk), .CD(n450), .Q(
        rcv_fr_err) );
  CFD2QXL \u1_recv/tick_counter_reg[0]  ( .D(n381), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/tick_counter[0] ) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[4]  ( .D(n373), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[4] ) );
  CFD2QXL div_by2_reg ( .D(n396), .CP(baud_clk), .CD(n450), .Q(div_by2) );
  CFD2QXL div_by8_reg ( .D(n398), .CP(div_by4), .CD(n450), .Q(div_by8) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[1]  ( .D(n370), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[1] ) );
  CFD2QXL \u1_recv/tick_counter_reg[1]  ( .D(n380), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/tick_counter[1] ) );
  CFD2QXL \u1_recv/data_reg_reg[3]  ( .D(n361), .CP(rxclk), .CD(n450), .Q(
        rcv_data[3]) );
  CFD2QXL \u1_recv/data_reg_reg[5]  ( .D(n359), .CP(rxclk), .CD(n450), .Q(
        rcv_data[5]) );
  CFD2QXL \u1_recv/data_reg_reg[7]  ( .D(n357), .CP(rxclk), .CD(n450), .Q(
        rcv_data[7]) );
  CFD2QXL \u1_recv/data_reg_reg[6]  ( .D(n358), .CP(rxclk), .CD(n450), .Q(
        rcv_data[6]) );
  CFD2QXL \u1_recv/data_reg_reg[0]  ( .D(n364), .CP(rxclk), .CD(n450), .Q(
        rcv_data[0]) );
  CFD2QXL \u1_recv/data_reg_reg[2]  ( .D(n362), .CP(rxclk), .CD(n450), .Q(
        rcv_data[2]) );
  CFD2QXL \u1_trans/tx_cnt_reg[3]  ( .D(n390), .CP(txclk), .CD(n450), .Q(
        \u1_trans/tx_cnt[3] ) );
  CFD2QXL \u1_recv/data_reg_reg[4]  ( .D(n360), .CP(rxclk), .CD(n450), .Q(
        rcv_data[4]) );
  CFD2QXL \u1_recv/data_reg_reg[1]  ( .D(n363), .CP(rxclk), .CD(n450), .Q(
        rcv_data[1]) );
  CFD2QXL \u1_recv/rcv_shift_reg_reg[9]  ( .D(n378), .CP(rxclk), .CD(n450), 
        .Q(\u1_recv/rcv_shift_reg[9] ) );
  CFD2QXL \u1_recv/tick_counter_reg[3]  ( .D(n382), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/tick_counter[3] ) );
  CFD2QXL \u1_trans/tx_cnt_reg[2]  ( .D(n387), .CP(txclk), .CD(n450), .Q(
        \u1_trans/tx_cnt[2] ) );
  CFD2QXL \u1_recv/state_reg[0]  ( .D(\u1_recv/nxt_state [0]), .CP(rxclk), 
        .CD(n450), .Q(\u1_recv/state[0] ) );
  CFD2QXL \u1_recv/tick_counter_reg[2]  ( .D(n379), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/tick_counter[2] ) );
  CFD2QXL \u1_recv/bit_cnt_reg_reg[3]  ( .D(\u1_recv/bit_cnt [3]), .CP(rxclk), 
        .CD(n450), .Q(\u1_recv/bit_cnt_reg[3] ) );
  CFD2QXL \u1_trans/tx_cnt_reg[1]  ( .D(n388), .CP(txclk), .CD(n450), .Q(
        \u1_trans/tx_cnt[1] ) );
  CFD2QXL \u1_recv/rx_cnt_reg[0]  ( .D(n368), .CP(rxclk), .CD(n450), .Q(
        \u1_recv/rx_cnt[0] ) );
  CFD2QXL \u1_trans/state_reg[0]  ( .D(n392), .CP(txclk), .CD(n450), .Q(
        \u1_trans/state[0] ) );
  CFD2QXL \u1_trans/tx_cnt_reg[0]  ( .D(n389), .CP(txclk), .CD(n450), .Q(
        \u1_trans/tx_cnt[0] ) );
  CFD2QXL \u1_recv/state_reg[2]  ( .D(\u1_recv/nxt_state [2]), .CP(rxclk), 
        .CD(n450), .Q(\u1_recv/state[2] ) );
  CFD2QXL \u1_trans/state_reg[1]  ( .D(n391), .CP(txclk), .CD(n450), .Q(
        \u1_trans/state[1] ) );
  CFD2QXL \u1_recv/state_reg[1]  ( .D(\u1_recv/nxt_state [1]), .CP(rxclk), 
        .CD(n450), .Q(\u1_recv/state[1] ) );
  CFD2QXL \u1_trans/state_reg[2]  ( .D(n386), .CP(txclk), .CD(n450), .Q(
        \u1_trans/state[2] ) );
  CFD2QXL \u1_recv/state_ext_reg[2]  ( .D(\u1_recv/state[2] ), .CP(\uif.clk ), 
        .CD(n450), .Q(\u1_recv/state_ext [2]) );
  CFD2QXL baud_clk_reg ( .D(n323), .CP(\uif.clk ), .CD(n450), .Q(baud_clk) );
  CFD2QXL \data_out_reg[3]  ( .D(\uif.dout [3]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[3]) );
  CFD2QXL \data_out_reg[6]  ( .D(\uif.dout [6]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[6]) );
  CFD2QXL \data_out_reg[5]  ( .D(\uif.dout [5]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[5]) );
  CFD2QXL \data_out_reg[0]  ( .D(\uif.dout [0]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[0]) );
  CFD2QXL \data_out_reg[2]  ( .D(\uif.dout [2]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[2]) );
  CFD2QXL \data_out_reg[4]  ( .D(\uif.dout [4]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[4]) );
  CFD2QXL \data_out_reg[7]  ( .D(\uif.dout [7]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[7]) );
  CFD2QXL \data_out_reg[1]  ( .D(\uif.dout [1]), .CP(\uif.clk ), .CD(n450), 
        .Q(data_out[1]) );
  CFD2QXL \u1_recv/state_ext_reg[0]  ( .D(\u1_recv/state[0] ), .CP(\uif.clk ), 
        .CD(n450), .Q(\u1_recv/state_ext [0]) );
  CFD2QXL \u1_recv/state_ext_reg[1]  ( .D(\u1_recv/state[1] ), .CP(\uif.clk ), 
        .CD(n450), .Q(\u1_recv/state_ext [1]) );
  CFD2QXL \u1_recv/a4_reg  ( .D(n353), .CP(\uif.clk ), .CD(n450), .Q(ua[4]) );
  CFD2QXL \ubrrnh_reg[3]  ( .D(n327), .CP(\uif.clk ), .CD(n450), .Q(ubrrnh[3])
         );
  CFD2QXL \ubrrnh_reg[2]  ( .D(n326), .CP(\uif.clk ), .CD(n450), .Q(ubrrnh[2])
         );
  CFD2QXL \ubrrnh_reg[1]  ( .D(n325), .CP(\uif.clk ), .CD(n450), .Q(ubrrnh[1])
         );
  CFD2QXL \ubrrnh_reg[0]  ( .D(n324), .CP(\uif.clk ), .CD(n450), .Q(ubrrnh[0])
         );
  CFD2QXL \u1_recv/b1_reg  ( .D(n351), .CP(\uif.clk ), .CD(n450), .Q(ub[1]) );
  CFD2QXL \ua_reg[0]  ( .D(n341), .CP(\uif.clk ), .CD(n450), .Q(ua[0]) );
  CFD2QXL \ub_reg[7]  ( .D(n340), .CP(\uif.clk ), .CD(n450), .Q(ub[7]) );
  CFD2QXL \ub_reg[6]  ( .D(n339), .CP(\uif.clk ), .CD(n450), .Q(ub[6]) );
  CFD2QXL \ub_reg[5]  ( .D(n338), .CP(\uif.clk ), .CD(n450), .Q(ub[5]) );
  CFD2QXL \uc_reg[7]  ( .D(n333), .CP(\uif.clk ), .CD(n450), .Q(uc[7]) );
  CFD2QXL \uc_reg[6]  ( .D(n332), .CP(\uif.clk ), .CD(n450), .Q(uc[6]) );
  CFD2QXL \u1_recv/a2_reg  ( .D(n354), .CP(\uif.clk ), .CD(n450), .Q(ua[2]) );
  CFD2QXL \uc_reg[0]  ( .D(n328), .CP(\uif.clk ), .CD(n450), .Q(uc[0]) );
  CFD2QXL \u1_recv/a7_reg  ( .D(n352), .CP(\uif.clk ), .CD(n450), .Q(ua[7]) );
  CFD2QXL \ub_reg[3]  ( .D(n336), .CP(\uif.clk ), .CD(n450), .Q(ub[3]) );
  CFD2QXL \ub_reg[4]  ( .D(n337), .CP(\uif.clk ), .CD(n450), .Q(ub[4]) );
  CFD2QXL \u1_trans/udrn_reg_reg[0]  ( .D(n322), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[0] ) );
  CFD2QXL \u1_trans/udrn_reg_reg[6]  ( .D(n316), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[6] ) );
  CFD2QXL \u1_trans/udrn_reg_reg[4]  ( .D(n318), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[4] ) );
  CFD2QXL \u1_trans/udrn_reg_reg[7]  ( .D(n315), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[7] ) );
  CFD2QXL \u1_trans/udrn_reg_reg[3]  ( .D(n319), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[3] ) );
  CFD2QXL \u1_trans/udrn_reg_reg[1]  ( .D(n321), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[1] ) );
  CFD2QXL \u1_trans/udrn_reg_reg[2]  ( .D(n320), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[2] ) );
  CFD2QXL \u1_trans/udrn_reg_reg[5]  ( .D(n317), .CP(\uif.clk ), .CD(n450), 
        .Q(\u1_trans/udrn_reg[5] ) );
  CFD2QXL \uc_reg[3]  ( .D(n329), .CP(\uif.clk ), .CD(n450), .Q(uc[3]) );
  CFD2QXL \ub_reg[0]  ( .D(n334), .CP(\uif.clk ), .CD(n450), .Q(ub[0]) );
  CFD2QXL \uc_reg[4]  ( .D(n330), .CP(\uif.clk ), .CD(n450), .Q(uc[4]) );
  CFD2QXL \uc_reg[5]  ( .D(n331), .CP(\uif.clk ), .CD(n450), .Q(uc[5]) );
  CFD2QXL \ubrrnl_reg[7]  ( .D(n350), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[7])
         );
  CFD2QXL \ubrrnl_reg[6]  ( .D(n349), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[6])
         );
  CFD2QXL \ubrrnl_reg[5]  ( .D(n348), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[5])
         );
  CFD2QXL \ubrrnl_reg[4]  ( .D(n347), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[4])
         );
  CFD2QXL \ubrrnl_reg[3]  ( .D(n346), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[3])
         );
  CFD2QXL \ub_reg[2]  ( .D(n335), .CP(\uif.clk ), .CD(n450), .Q(ub[2]) );
  CFD2QXL \addr_reg_reg[2]  ( .D(\uif.addr [2]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[2]) );
  CFD2QXL write_reg_reg ( .D(\uif.write ), .CP(\uif.clk ), .CD(n450), .Q(
        write_reg) );
  CFD2QXL \addr_reg_reg[7]  ( .D(\uif.addr [7]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[7]) );
  CFD2QXL \addr_reg_reg[6]  ( .D(\uif.addr [6]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[6]) );
  CFD2QXL \addr_reg_reg[1]  ( .D(\uif.addr [1]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[1]) );
  CFD2QXL \addr_reg_reg[4]  ( .D(\uif.addr [4]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[4]) );
  CFD2QXL \ubrrnl_reg[2]  ( .D(n345), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[2])
         );
  CFD2QXL \ubrrnl_reg[1]  ( .D(n344), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[1])
         );
  CFD2QXL \ubrrnl_reg[0]  ( .D(n343), .CP(\uif.clk ), .CD(n450), .Q(ubrrnl[0])
         );
  CFD2QXL \cnt_reg[5]  ( .D(N50), .CP(\uif.clk ), .CD(n450), .Q(cnt[5]) );
  CFD2QXL \cnt_reg[4]  ( .D(N49), .CP(\uif.clk ), .CD(n450), .Q(cnt[4]) );
  CFD2QXL \cnt_reg[1]  ( .D(N46), .CP(\uif.clk ), .CD(n450), .Q(cnt[1]) );
  CFD2QXL \cnt_reg[0]  ( .D(N45), .CP(\uif.clk ), .CD(n450), .Q(cnt[0]) );
  CFD2QXL \addr_reg_reg[0]  ( .D(\uif.addr [0]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[0]) );
  CFD2QXL \addr_reg_reg[3]  ( .D(\uif.addr [3]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[3]) );
  CFD2QXL \addr_reg_reg[5]  ( .D(\uif.addr [5]), .CP(\uif.clk ), .CD(n450), 
        .Q(addr_reg[5]) );
  CFD2QXL \cnt_reg[6]  ( .D(N51), .CP(\uif.clk ), .CD(n450), .Q(cnt[6]) );
  CFD2QXL \cnt_reg[7]  ( .D(N52), .CP(\uif.clk ), .CD(n450), .Q(cnt[7]) );
  CFD2QXL \cnt_reg[8]  ( .D(N53), .CP(\uif.clk ), .CD(n450), .Q(cnt[8]) );
  CFD2QXL \cnt_reg[9]  ( .D(N54), .CP(\uif.clk ), .CD(n450), .Q(cnt[9]) );
  CFD2QXL \cnt_reg[3]  ( .D(N48), .CP(\uif.clk ), .CD(n450), .Q(cnt[3]) );
  CFD2QXL \cnt_reg[11]  ( .D(N56), .CP(\uif.clk ), .CD(n450), .Q(cnt[11]) );
  CFD2QXL \cnt_reg[10]  ( .D(N55), .CP(\uif.clk ), .CD(n450), .Q(cnt[10]) );
  CFD2QXL \cnt_reg[2]  ( .D(N47), .CP(\uif.clk ), .CD(n450), .Q(cnt[2]) );
  CFD2QXL \ua_reg[1]  ( .D(n342), .CP(\uif.clk ), .CD(n450), .Q(ua[1]) );
  CMX2XL U433 ( .A0(div_by16), .A1(div_by8), .S(ua[1]), .Z(txclk) );
  CMX2X1 U434 ( .A0(baud_clk), .A1(div_by2), .S(ua[1]), .Z(rxclk) );
  CNR3XL U435 ( .A(addr_reg[0]), .B(addr_reg[3]), .C(addr_reg[5]), .Z(n473) );
  CNR2X1 U436 ( .A(\uif.addr [0]), .B(n483), .Z(n621) );
  CAN2X1 U437 ( .A(n621), .B(\uif.write ), .Z(n486) );
  CAN2X1 U438 ( .A(\uif.read ), .B(n621), .Z(n630) );
  CND2X1 U439 ( .A(\uif.addr [1]), .B(n486), .Z(n484) );
  COND1X1 U440 ( .A(cnt[0]), .B(n618), .C(n474), .Z(n658) );
  CND3XL U441 ( .A(n473), .B(n472), .C(n471), .Z(n474) );
  CND3XL U442 ( .A(\uif.addr [2]), .B(n486), .C(n485), .Z(n487) );
  CND2X1 U443 ( .A(n624), .B(\uif.write ), .Z(n669) );
  CND2X1 U444 ( .A(\u1_recv/rcv_shift_reg[9] ), .B(n535), .Z(n661) );
  CND2X1 U445 ( .A(\uif.read ), .B(n624), .Z(n647) );
  CAN2X1 U446 ( .A(n630), .B(n629), .Z(n650) );
  CANR4CX1 U447 ( .A(\uif.addr [1]), .B(n625), .C(n630), .D(n652), .Z(n651) );
  CIVX2 U448 ( .A(n647), .Z(n652) );
  CNR2X1 U449 ( .A(n625), .B(n626), .Z(n679) );
  CNR2X1 U450 ( .A(n511), .B(n588), .Z(n510) );
  CIVX2 U451 ( .A(\uif.rxdata ), .Z(n657) );
  CIVX2 U452 ( .A(\u1_recv/rxcn_bit ), .Z(n665) );
  CANR5CXL U453 ( .A(\u1_recv/tick_counter[3] ), .B(ua[1]), .C(n510), .Z(n567)
         );
  COR2X1 U454 ( .A(n700), .B(uc[2]), .Z(n675) );
  CNR3X1 U455 ( .A(n625), .B(n707), .C(n484), .Z(n710) );
  CNR2X1 U456 ( .A(\uif.addr [2]), .B(n484), .Z(n680) );
  CENX1 U457 ( .A(n478), .B(n477), .Z(N47) );
  CENX1 U458 ( .A(n476), .B(n475), .Z(N48) );
  CENX1 U459 ( .A(n482), .B(n481), .Z(N45) );
  CENX1 U460 ( .A(n480), .B(n479), .Z(N46) );
  CENX1 U461 ( .A(n660), .B(n659), .Z(N49) );
  CNR3XL U462 ( .A(\u1_recv/state[0] ), .B(n567), .C(n507), .Z(
        \u1_recv/rxcn_bit ) );
  CEOX1 U463 ( .A(rcv_data[0]), .B(rcv_data[1]), .Z(n400) );
  CENX1 U464 ( .A(rcv_data[4]), .B(rcv_data[2]), .Z(n401) );
  CENX1 U465 ( .A(n400), .B(n401), .Z(n402) );
  CENX1 U466 ( .A(rcv_data[3]), .B(n402), .Z(n403) );
  CENX1 U467 ( .A(rcv_data[5]), .B(n403), .Z(n404) );
  CEOX1 U468 ( .A(rcv_data[6]), .B(n404), .Z(n405) );
  COND1XL U469 ( .A(n404), .B(n675), .C(uc[4]), .Z(n406) );
  COND1XL U470 ( .A(n674), .B(n673), .C(n694), .Z(n407) );
  CND2X1 U471 ( .A(rcv_par_err), .B(n672), .Z(n408) );
  CEOX1 U472 ( .A(rcv_data[7]), .B(n405), .Z(n409) );
  CMXI2X1 U473 ( .A0(n407), .A1(n408), .S(n409), .Z(n410) );
  CANR3X1 U474 ( .A(n676), .B(n403), .C(n406), .D(n410), .Z(n411) );
  CIVX1 U475 ( .A(n675), .Z(n412) );
  CMXI2X1 U476 ( .A0(n408), .A1(n407), .S(n409), .Z(n413) );
  CANR1XL U477 ( .A(n404), .B(n412), .C(n413), .Z(n414) );
  COND3X1 U478 ( .A(n671), .B(n403), .C(n670), .D(n414), .Z(n415) );
  CANR1XL U479 ( .A(n678), .B(n405), .C(n415), .Z(n416) );
  CANR4CX1 U480 ( .A(n405), .B(n677), .C(n411), .D(n416), .Z(n417) );
  CEOX1 U481 ( .A(n417), .B(rcv_fr_err), .Z(n418) );
  CMXI2X1 U482 ( .A0(ua[2]), .A1(n418), .S(uc[5]), .Z(n419) );
  CNR2X1 U483 ( .A(n679), .B(n419), .Z(n354) );
  CNR3XL U484 ( .A(\uif.addr [5]), .B(\uif.addr [4]), .C(\uif.addr [3]), .Z(
        n420) );
  CND3XL U485 ( .A(\uif.addr [7]), .B(n420), .C(\uif.addr [6]), .Z(n483) );
  COND1XL U486 ( .A(n663), .B(n662), .C(n661), .Z(n421) );
  CNR2X1 U487 ( .A(n665), .B(n664), .Z(n422) );
  CMX2GX1 U488 ( .GN(n679), .A0(ub[1]), .A1(n421), .S(n422), .Z(n351) );
  CIVX1 U489 ( .A(n483), .Z(n423) );
  CND3XL U490 ( .A(n485), .B(\uif.addr [0]), .C(n423), .Z(n488) );
  COR8X1 U491 ( .A(cnt[5]), .B(cnt[4]), .C(cnt[3]), .D(cnt[2]), .E(n470), .F(
        cnt[1]), .G(cnt[11]), .H(cnt[10]), .Z(n618) );
  CENX1 U492 ( .A(\u1_recv/tick_counter[2] ), .B(ua[1]), .Z(n424) );
  CNR3XL U493 ( .A(n588), .B(\u1_recv/tick_counter[3] ), .C(n424), .Z(n548) );
  CANR1XL U494 ( .A(\u1_recv/rxcn_bit ), .B(n657), .C(ua[4]), .Z(n425) );
  CNR2X1 U495 ( .A(n679), .B(n425), .Z(n353) );
  CIVX1 U496 ( .A(\uif.write ), .Z(n426) );
  CNR3XL U497 ( .A(n488), .B(n625), .C(n426), .Z(n489) );
  CNR2IX1 U498 ( .B(\u1_trans/tx_cnt[0] ), .A(n571), .Z(n609) );
  CNR2X1 U499 ( .A(n681), .B(n682), .Z(n427) );
  CND2IX1 U500 ( .B(n658), .A(cnt[11]), .Z(n428) );
  CENX1 U501 ( .A(n427), .B(n428), .Z(N56) );
  CANR2X1 U502 ( .A(n562), .B(n563), .C(\u1_recv/state[2] ), .D(n613), .Z(n429) );
  CND2X1 U503 ( .A(n657), .B(n610), .Z(n430) );
  COND3X1 U504 ( .A(n567), .B(n566), .C(n429), .D(n430), .Z(
        \u1_recv/nxt_state [2]) );
  CEOX1 U505 ( .A(\u1_trans/udrn_reg[0] ), .B(\u1_trans/udrn_reg[4] ), .Z(n431) );
  CENX1 U506 ( .A(\u1_trans/udrn_reg[1] ), .B(\u1_trans/udrn_reg[3] ), .Z(n432) );
  CENX1 U507 ( .A(n431), .B(n432), .Z(n433) );
  CENX1 U508 ( .A(\u1_trans/udrn_reg[2] ), .B(n433), .Z(n434) );
  CENX1 U509 ( .A(\u1_trans/udrn_reg[5] ), .B(n434), .Z(n435) );
  CENX1 U510 ( .A(\u1_trans/udrn_reg[6] ), .B(n435), .Z(n436) );
  CIVX1 U511 ( .A(n435), .Z(n437) );
  COND2X1 U512 ( .A(n677), .B(n436), .C(n675), .D(n437), .Z(n438) );
  CENX1 U513 ( .A(\u1_trans/udrn_reg[7] ), .B(n436), .Z(n439) );
  CND2X1 U514 ( .A(n672), .B(ub[0]), .Z(n440) );
  COND2X1 U515 ( .A(n671), .B(n434), .C(n439), .D(n440), .Z(n441) );
  CENX1 U516 ( .A(uc[4]), .B(n439), .Z(n442) );
  CANR3X1 U517 ( .A(ub[2]), .B(ub[0]), .C(n695), .D(n442), .Z(n443) );
  CANR4CX1 U518 ( .A(n438), .B(n441), .C(n670), .D(n443), .Z(n444) );
  CIVX1 U519 ( .A(n440), .Z(n445) );
  CANR2X1 U520 ( .A(n676), .B(n434), .C(n445), .D(n439), .Z(n446) );
  COND1XL U521 ( .A(n675), .B(n435), .C(n446), .Z(n447) );
  COND4CX1 U522 ( .A(n678), .B(n436), .C(n447), .D(uc[4]), .Z(n448) );
  CANR4CX1 U523 ( .A(n604), .B(\u1_trans/shift_reg_q [0]), .C(n603), .D(
        \u1_trans/state[2] ), .Z(n449) );
  COND4CX1 U524 ( .A(n444), .B(n448), .C(n605), .D(n449), .Z(
        \u1_trans/tx_data ) );
  CIVX8 U525 ( .A(\uif.rst ), .Z(n450) );
  CIVX2 U526 ( .A(\u1_recv/tick_counter[2] ), .Z(n511) );
  CND2XL U527 ( .A(\u1_recv/tick_counter[0] ), .B(\u1_recv/tick_counter[1] ), 
        .Z(n588) );
  CIVXL U528 ( .A(\u1_recv/state[1] ), .Z(n551) );
  CND2XL U529 ( .A(\u1_recv/state[2] ), .B(n551), .Z(n507) );
  CNR2XL U530 ( .A(\u1_recv/bit_cnt_reg[0] ), .B(\u1_recv/bit_cnt_reg[1] ), 
        .Z(n530) );
  CMXI2XL U531 ( .A0(\u1_recv/rcv_shift_reg[6] ), .A1(
        \u1_recv/rcv_shift_reg[7] ), .S(\u1_recv/bit_cnt_reg[0] ), .Z(n462) );
  CIVX2 U532 ( .A(n530), .Z(n584) );
  CND2XL U533 ( .A(\u1_recv/bit_cnt_reg[0] ), .B(\u1_recv/bit_cnt_reg[1] ), 
        .Z(n532) );
  CND2X1 U534 ( .A(n584), .B(n532), .Z(n496) );
  CIVX2 U535 ( .A(\u1_recv/rcv_shift_reg[5] ), .Z(n570) );
  COND2X1 U536 ( .A(n462), .B(n496), .C(n570), .D(n532), .Z(n451) );
  CANR1XL U537 ( .A(n530), .B(\u1_recv/rcv_shift_reg[4] ), .C(n451), .Z(n525)
         );
  CNR2X1 U538 ( .A(uc[5]), .B(n665), .Z(n535) );
  CIVX1 U539 ( .A(n535), .Z(n602) );
  CNR2X1 U540 ( .A(n584), .B(\u1_recv/bit_cnt_reg[2] ), .Z(n458) );
  CND2XL U541 ( .A(\u1_recv/bit_cnt_reg[3] ), .B(n458), .Z(n664) );
  COR2X1 U542 ( .A(n458), .B(\u1_recv/bit_cnt_reg[3] ), .Z(n583) );
  CANR1XL U543 ( .A(n584), .B(\u1_recv/bit_cnt_reg[2] ), .C(n458), .Z(n453) );
  CANR1XL U544 ( .A(n664), .B(n583), .C(n453), .Z(n597) );
  CIVX2 U545 ( .A(n597), .Z(n456) );
  CND2XL U546 ( .A(\u1_recv/rxcn_bit ), .B(uc[5]), .Z(n662) );
  CIVX1 U547 ( .A(n662), .Z(n598) );
  CIVX2 U548 ( .A(\u1_recv/rcv_shift_reg[3] ), .Z(n558) );
  CIVX2 U549 ( .A(\u1_recv/rcv_shift_reg[6] ), .Z(n569) );
  CMXI2XL U550 ( .A0(n570), .A1(n569), .S(\u1_recv/bit_cnt_reg[0] ), .Z(n497)
         );
  COND2X1 U551 ( .A(\u1_recv/rcv_shift_reg[4] ), .B(n532), .C(n497), .D(n496), 
        .Z(n452) );
  CANR3X1 U552 ( .A(n530), .B(n558), .C(n456), .D(n452), .Z(n467) );
  CNR2IXL U553 ( .B(n453), .A(\u1_recv/bit_cnt_reg[3] ), .Z(n595) );
  CIVX2 U554 ( .A(\u1_recv/rcv_shift_reg[7] ), .Z(n518) );
  CIVX2 U555 ( .A(\u1_recv/rcv_shift_reg[8] ), .Z(n663) );
  CMXI2XL U556 ( .A0(n518), .A1(n663), .S(\u1_recv/bit_cnt_reg[0] ), .Z(n498)
         );
  CND2X1 U557 ( .A(n496), .B(n498), .Z(n466) );
  CIVXL U558 ( .A(\u1_recv/rcv_shift_reg[9] ), .Z(n517) );
  CIVXL U559 ( .A(\u1_recv/bit_cnt_reg[0] ), .Z(n697) );
  CND2X1 U560 ( .A(\u1_recv/rcv_shift_reg[8] ), .B(n697), .Z(n461) );
  COND1XL U561 ( .A(n517), .B(n697), .C(n461), .Z(n500) );
  CND3XL U562 ( .A(n535), .B(n496), .C(n500), .Z(n454) );
  COND1XL U563 ( .A(n466), .B(n662), .C(n454), .Z(n502) );
  CANR2X1 U564 ( .A(n598), .B(n467), .C(n595), .D(n502), .Z(n455) );
  COND11X1 U565 ( .A(n525), .B(n602), .C(n456), .D(n455), .Z(n457) );
  CAOR1XL U566 ( .A(rcv_data[3]), .B(n665), .C(n457), .Z(n361) );
  CIVX2 U567 ( .A(rcv_par_err), .Z(n673) );
  COND1XL U568 ( .A(n662), .B(n461), .C(n661), .Z(n580) );
  CND2X1 U569 ( .A(n458), .B(n580), .Z(n538) );
  COND2XL U570 ( .A(\u1_recv/rxcn_bit ), .B(n673), .C(n538), .D(n664), .Z(n356) );
  CIVX2 U571 ( .A(\u1_recv/rcv_shift_reg[4] ), .Z(n547) );
  CIVX2 U572 ( .A(\u1_recv/rcv_shift_reg[2] ), .Z(n559) );
  CMXI2X1 U573 ( .A0(n547), .A1(n559), .S(n496), .Z(n526) );
  CANR1XL U574 ( .A(\u1_recv/bit_cnt_reg[1] ), .B(\u1_recv/rcv_shift_reg[3] ), 
        .C(n697), .Z(n459) );
  COND1XL U575 ( .A(n570), .B(\u1_recv/bit_cnt_reg[1] ), .C(n459), .Z(n460) );
  COND3X1 U576 ( .A(\u1_recv/bit_cnt_reg[0] ), .B(n526), .C(n597), .D(n460), 
        .Z(n601) );
  CND3XL U577 ( .A(\u1_recv/bit_cnt_reg[1] ), .B(\u1_recv/rcv_shift_reg[9] ), 
        .C(n697), .Z(n465) );
  CIVX2 U578 ( .A(n461), .Z(n463) );
  CIVX2 U579 ( .A(n496), .Z(n529) );
  CNR2X1 U580 ( .A(n529), .B(n462), .Z(n499) );
  COND4CX1 U581 ( .A(n463), .B(n584), .C(n499), .D(n598), .Z(n464) );
  COND4CX1 U582 ( .A(n466), .B(n465), .C(n602), .D(n464), .Z(n503) );
  CANR2XL U583 ( .A(n595), .B(n503), .C(rcv_data[2]), .D(n665), .Z(n469) );
  CND2XL U584 ( .A(n535), .B(n467), .Z(n468) );
  COND3XL U585 ( .A(n601), .B(n662), .C(n469), .D(n468), .Z(n362) );
  CAOR2XL U586 ( .A(n665), .B(rcv_fr_err), .C(n598), .D(
        \u1_recv/rcv_shift_reg[9] ), .Z(n355) );
  COR4X1 U587 ( .A(cnt[9]), .B(cnt[8]), .C(cnt[7]), .D(cnt[6]), .Z(n470) );
  CNR2X1 U588 ( .A(addr_reg[4]), .B(addr_reg[1]), .Z(n472) );
  CAN4X1 U589 ( .A(addr_reg[2]), .B(write_reg), .C(addr_reg[7]), .D(
        addr_reg[6]), .Z(n471) );
  CMX2XL U590 ( .A0(cnt[4]), .A1(ubrrnl[5]), .S(n658), .Z(n660) );
  CMX2XL U591 ( .A0(cnt[3]), .A1(ubrrnl[4]), .S(n658), .Z(n476) );
  CMX2XL U592 ( .A0(cnt[2]), .A1(ubrrnl[3]), .S(n658), .Z(n478) );
  CMX2XL U593 ( .A0(cnt[1]), .A1(ubrrnl[2]), .S(n658), .Z(n480) );
  CMX2XL U594 ( .A0(cnt[0]), .A1(ubrrnl[1]), .S(n658), .Z(n482) );
  CAN2X1 U595 ( .A(n658), .B(ubrrnl[0]), .Z(n481) );
  COR2X1 U596 ( .A(n482), .B(n481), .Z(n479) );
  COR2X1 U597 ( .A(n480), .B(n479), .Z(n477) );
  COR2X1 U598 ( .A(n478), .B(n477), .Z(n475) );
  COR2X1 U599 ( .A(n476), .B(n475), .Z(n659) );
  CIVX1 U600 ( .A(\uif.addr [1]), .Z(n485) );
  CNR2X1 U601 ( .A(\uif.addr [2]), .B(n488), .Z(n624) );
  CMX2XL U602 ( .A0(\uif.din [7]), .A1(ub[7]), .S(n669), .Z(n340) );
  CMX2XL U603 ( .A0(\uif.din [6]), .A1(ub[6]), .S(n669), .Z(n339) );
  CMX2XL U604 ( .A0(\uif.din [5]), .A1(ub[5]), .S(n669), .Z(n338) );
  CIVX2 U605 ( .A(\uif.addr [2]), .Z(n625) );
  CIVX2 U606 ( .A(\uif.txir ), .Z(n707) );
  CNR2IXL U607 ( .B(ua[6]), .A(n710), .Z(n383) );
  CMX2XL U608 ( .A0(uc[7]), .A1(\uif.din [7]), .S(n680), .Z(n333) );
  CMX2XL U609 ( .A0(uc[6]), .A1(\uif.din [6]), .S(n680), .Z(n332) );
  CMX2XL U610 ( .A0(uc[1]), .A1(\uif.din [1]), .S(n680), .Z(n313) );
  CMX2XL U611 ( .A0(uc[0]), .A1(\uif.din [0]), .S(n680), .Z(n328) );
  CMX2XL U612 ( .A0(uc[2]), .A1(\uif.din [2]), .S(n680), .Z(n314) );
  CMX2XL U613 ( .A0(\uif.din [3]), .A1(ub[3]), .S(n669), .Z(n336) );
  CMX2XL U614 ( .A0(\uif.din [4]), .A1(ub[4]), .S(n669), .Z(n337) );
  CMX2XL U615 ( .A0(uc[3]), .A1(\uif.din [3]), .S(n680), .Z(n329) );
  CMX2XL U616 ( .A0(uc[4]), .A1(\uif.din [4]), .S(n680), .Z(n330) );
  CNR2XL U617 ( .A(\uif.addr [2]), .B(\uif.addr [1]), .Z(n629) );
  CND2X1 U618 ( .A(n629), .B(n486), .Z(n668) );
  CMX2XL U619 ( .A0(\uif.din [0]), .A1(ua[0]), .S(n668), .Z(n341) );
  CMX2XL U620 ( .A0(\uif.din [5]), .A1(ubrrnl[5]), .S(n487), .Z(n348) );
  CMX2XL U621 ( .A0(\uif.din [4]), .A1(ubrrnl[4]), .S(n487), .Z(n347) );
  CMX2XL U622 ( .A0(\uif.din [3]), .A1(ubrrnl[3]), .S(n487), .Z(n346) );
  CMX2XL U623 ( .A0(\uif.din [2]), .A1(ubrrnl[2]), .S(n487), .Z(n345) );
  CMX2XL U624 ( .A0(\uif.din [1]), .A1(ubrrnl[1]), .S(n487), .Z(n344) );
  CMX2XL U625 ( .A0(\uif.din [0]), .A1(ubrrnl[0]), .S(n487), .Z(n343) );
  CMX2XL U626 ( .A0(\uif.din [7]), .A1(ubrrnl[7]), .S(n487), .Z(n350) );
  CMX2XL U627 ( .A0(\uif.din [6]), .A1(ubrrnl[6]), .S(n487), .Z(n349) );
  CMX2XL U628 ( .A0(\u1_trans/udrn_reg[5] ), .A1(\uif.din [5]), .S(n710), .Z(
        n317) );
  CMX2XL U629 ( .A0(\u1_trans/udrn_reg[0] ), .A1(\uif.din [0]), .S(n710), .Z(
        n322) );
  CMX2XL U630 ( .A0(\u1_trans/udrn_reg[3] ), .A1(\uif.din [3]), .S(n710), .Z(
        n319) );
  CMX2XL U631 ( .A0(\u1_trans/udrn_reg[6] ), .A1(\uif.din [6]), .S(n710), .Z(
        n316) );
  CMX2XL U632 ( .A0(\u1_trans/udrn_reg[7] ), .A1(\uif.din [7]), .S(n710), .Z(
        n315) );
  CMX2XL U633 ( .A0(\u1_trans/udrn_reg[1] ), .A1(\uif.din [1]), .S(n710), .Z(
        n321) );
  CMX2XL U634 ( .A0(\u1_trans/udrn_reg[4] ), .A1(\uif.din [4]), .S(n710), .Z(
        n318) );
  CMX2XL U635 ( .A0(\u1_trans/udrn_reg[2] ), .A1(\uif.din [2]), .S(n710), .Z(
        n320) );
  CMX2XL U636 ( .A0(ubrrnh[2]), .A1(\uif.din [2]), .S(n489), .Z(n326) );
  CMX2XL U637 ( .A0(ubrrnh[1]), .A1(\uif.din [1]), .S(n489), .Z(n325) );
  CMX2XL U638 ( .A0(ubrrnh[0]), .A1(\uif.din [0]), .S(n489), .Z(n324) );
  CMX2XL U639 ( .A0(ubrrnh[3]), .A1(\uif.din [3]), .S(n489), .Z(n327) );
  CNR2XL U640 ( .A(\u1_trans/state[1] ), .B(\u1_trans/state[0] ), .Z(n591) );
  COND1XL U641 ( .A(uc[3]), .B(\u1_trans/stop_cnt_reg ), .C(
        \u1_trans/state[2] ), .Z(n490) );
  CANR1XL U642 ( .A(uc[3]), .B(\u1_trans/stop_cnt_reg ), .C(n490), .Z(n590) );
  CND2XL U643 ( .A(n591), .B(\u1_trans/state[2] ), .Z(n703) );
  CAOR2XL U644 ( .A(n591), .B(n590), .C(\u1_trans/stop_cnt_reg ), .D(n703), 
        .Z(n385) );
  CIVXL U645 ( .A(\u1_trans/state[0] ), .Z(n603) );
  CNR3X1 U646 ( .A(\u1_trans/state[1] ), .B(\u1_trans/state[2] ), .C(n603), 
        .Z(n667) );
  CENX1 U647 ( .A(\u1_trans/tx_cnt[2] ), .B(\u1_trans/bit_cnt_reg[2] ), .Z(
        n494) );
  CENX1 U648 ( .A(\u1_trans/tx_cnt[3] ), .B(\u1_trans/bit_cnt_reg[3] ), .Z(
        n493) );
  CENX1 U649 ( .A(\u1_trans/tx_cnt[1] ), .B(\u1_trans/bit_cnt_reg[1] ), .Z(
        n492) );
  CENX1 U650 ( .A(\u1_trans/tx_cnt[0] ), .B(\u1_trans/bit_cnt_reg[0] ), .Z(
        n491) );
  CAN4X1 U651 ( .A(n494), .B(n493), .C(n492), .D(n491), .Z(n572) );
  CIVXL U652 ( .A(uc[5]), .Z(n562) );
  CND2X1 U653 ( .A(n572), .B(n562), .Z(n545) );
  COND4CXL U654 ( .A(n603), .B(n545), .C(\u1_trans/state[2] ), .D(
        \u1_trans/state[1] ), .Z(n495) );
  CND2IXL U655 ( .B(n667), .A(n495), .Z(n391) );
  CIVXL U656 ( .A(\u1_trans/state[1] ), .Z(n604) );
  CNR3XL U657 ( .A(\u1_trans/state[0] ), .B(\u1_trans/state[2] ), .C(n604), 
        .Z(n606) );
  CIVX2 U658 ( .A(n606), .Z(n546) );
  CNR2X1 U659 ( .A(n546), .B(n572), .Z(n666) );
  CAOR2XL U660 ( .A(ub[0]), .B(n666), .C(\u1_trans/udrn_reg[7] ), .D(n667), 
        .Z(\u1_trans/shift_reg [7]) );
  CIVXL U661 ( .A(div_by8), .Z(n398) );
  CIVXL U662 ( .A(div_by2), .Z(n396) );
  CMXI2X1 U663 ( .A0(n498), .A1(n497), .S(n496), .Z(n524) );
  COND4CXL U664 ( .A(n529), .B(n500), .C(n499), .D(n535), .Z(n501) );
  COND1XL U665 ( .A(n524), .B(n662), .C(n501), .Z(n594) );
  CAOR2XL U666 ( .A(n597), .B(n594), .C(rcv_data[5]), .D(n665), .Z(n359) );
  CAOR2XL U667 ( .A(n597), .B(n502), .C(rcv_data[7]), .D(n665), .Z(n357) );
  CIVXL U668 ( .A(div_by16), .Z(n399) );
  CAOR2XL U669 ( .A(n597), .B(n503), .C(rcv_data[6]), .D(n665), .Z(n358) );
  CIVXL U670 ( .A(div_by4), .Z(n397) );
  CIVX2 U671 ( .A(n666), .Z(n571) );
  CMXI2X1 U672 ( .A0(n571), .A1(n606), .S(\u1_trans/tx_cnt[0] ), .Z(n389) );
  CIVXL U673 ( .A(\u1_recv/rx_cnt[3] ), .Z(n523) );
  CIVXL U674 ( .A(\u1_recv/bit_cnt_reg[2] ), .Z(n693) );
  CIVXL U675 ( .A(\u1_recv/rx_cnt[1] ), .Z(n514) );
  CND2X1 U676 ( .A(n697), .B(\u1_recv/rx_cnt[0] ), .Z(n504) );
  CANR5CXL U677 ( .A(\u1_recv/bit_cnt_reg[1] ), .B(n514), .C(n504), .Z(n505)
         );
  CANR5CXL U678 ( .A(\u1_recv/rx_cnt[2] ), .B(n693), .C(n505), .Z(n506) );
  CANR5CXL U679 ( .A(\u1_recv/bit_cnt_reg[3] ), .B(n523), .C(n506), .Z(n552)
         );
  CIVX2 U680 ( .A(n552), .Z(n550) );
  CIVXL U681 ( .A(\u1_recv/state[2] ), .Z(n560) );
  CND2XL U682 ( .A(\u1_recv/state[1] ), .B(n560), .Z(n549) );
  CANR3X1 U683 ( .A(n550), .B(n567), .C(\u1_recv/state[0] ), .D(n549), .Z(n519) );
  CND2X1 U684 ( .A(n550), .B(n519), .Z(n521) );
  CMXI2X1 U685 ( .A0(n521), .A1(n519), .S(\u1_recv/rx_cnt[0] ), .Z(n368) );
  CIVXL U686 ( .A(n567), .Z(n508) );
  CNR2XL U687 ( .A(n508), .B(\u1_recv/state[0] ), .Z(n561) );
  COND1XL U688 ( .A(n552), .B(n549), .C(n507), .Z(n509) );
  CIVXL U689 ( .A(\u1_recv/state[0] ), .Z(n611) );
  COR4X1 U690 ( .A(\u1_recv/state[1] ), .B(\u1_recv/state[2] ), .C(
        \uif.rxdata ), .D(n611), .Z(n557) );
  CNR2X1 U691 ( .A(n548), .B(n557), .Z(n565) );
  CND2IXL U692 ( .B(n549), .A(\u1_recv/state[0] ), .Z(n566) );
  CNR2X1 U693 ( .A(n508), .B(n566), .Z(n614) );
  CANR3X1 U694 ( .A(n561), .B(n509), .C(n565), .D(n614), .Z(n589) );
  CIVX2 U695 ( .A(n510), .Z(n513) );
  CIVX2 U696 ( .A(n589), .Z(n576) );
  CANR3XL U697 ( .A(\u1_recv/state[0] ), .B(n560), .C(n519), .D(
        \u1_recv/rxcn_bit ), .Z(n577) );
  CND2X1 U698 ( .A(\u1_recv/tick_counter[0] ), .B(n576), .Z(n579) );
  COND1XL U699 ( .A(n577), .B(n576), .C(n579), .Z(n516) );
  COND1XL U700 ( .A(\u1_recv/tick_counter[1] ), .B(n589), .C(n516), .Z(n586)
         );
  COND4CXL U701 ( .A(n511), .B(n576), .C(n586), .D(\u1_recv/tick_counter[3] ), 
        .Z(n512) );
  COND11XL U702 ( .A(\u1_recv/tick_counter[3] ), .B(n589), .C(n513), .D(n512), 
        .Z(n382) );
  COND1X1 U703 ( .A(n566), .B(n567), .C(n521), .Z(n568) );
  CMXI2X1 U704 ( .A0(n517), .A1(n657), .S(n568), .Z(n378) );
  CMXI2X1 U705 ( .A0(n547), .A1(n570), .S(n568), .Z(n373) );
  CIVX2 U706 ( .A(\u1_recv/rcv_shift_reg[1] ), .Z(n533) );
  CMXI2X1 U707 ( .A0(n533), .A1(n559), .S(n568), .Z(n370) );
  CMXI2X1 U708 ( .A0(n569), .A1(n518), .S(n568), .Z(n375) );
  CEOX1 U709 ( .A(n514), .B(\u1_recv/rx_cnt[0] ), .Z(n515) );
  COND2X1 U710 ( .A(n521), .B(n515), .C(n519), .D(n514), .Z(n367) );
  CMXI2X1 U711 ( .A0(n579), .A1(n516), .S(\u1_recv/tick_counter[1] ), .Z(n380)
         );
  CMXI2X1 U712 ( .A0(n663), .A1(n517), .S(n568), .Z(n377) );
  CMXI2X1 U713 ( .A0(n518), .A1(n663), .S(n568), .Z(n376) );
  CND2XL U714 ( .A(\u1_recv/rx_cnt[0] ), .B(\u1_recv/rx_cnt[1] ), .Z(n541) );
  CIVX2 U715 ( .A(n519), .Z(n520) );
  CANR1XL U716 ( .A(n550), .B(n541), .C(n520), .Z(n543) );
  CIVXL U717 ( .A(\u1_recv/rx_cnt[2] ), .Z(n542) );
  CND2IX1 U718 ( .B(n521), .A(n542), .Z(n540) );
  COR4X1 U719 ( .A(\u1_recv/rx_cnt[3] ), .B(n542), .C(n541), .D(n521), .Z(n522) );
  COND4CX1 U720 ( .A(n543), .B(n540), .C(n523), .D(n522), .Z(n365) );
  CIVX2 U721 ( .A(n664), .Z(n539) );
  COND2X1 U722 ( .A(n525), .B(n662), .C(n524), .D(n602), .Z(n581) );
  CANR2XL U723 ( .A(n595), .B(n581), .C(rcv_data[0]), .D(n665), .Z(n537) );
  COND2X1 U724 ( .A(\u1_recv/rcv_shift_reg[1] ), .B(n584), .C(n697), .D(n526), 
        .Z(n527) );
  CANR11X1 U725 ( .A(\u1_recv/bit_cnt_reg[1] ), .B(n697), .C(n558), .D(n527), 
        .Z(n596) );
  CMXI2XL U726 ( .A0(n559), .A1(n558), .S(\u1_recv/bit_cnt_reg[0] ), .Z(n528)
         );
  CANR2X1 U727 ( .A(n530), .B(\u1_recv/rcv_shift_reg[0] ), .C(n529), .D(n528), 
        .Z(n531) );
  CANR4CXL U728 ( .A(n533), .B(n532), .C(n531), .D(n662), .Z(n534) );
  COND4CXL U729 ( .A(n535), .B(n596), .C(n534), .D(n597), .Z(n536) );
  COND3X1 U730 ( .A(n539), .B(n538), .C(n537), .D(n536), .Z(n364) );
  COND2X1 U731 ( .A(n543), .B(n542), .C(n541), .D(n540), .Z(n366) );
  CMXI2XL U732 ( .A0(\u1_trans/state[2] ), .A1(n590), .S(n591), .Z(n544) );
  CND2XL U733 ( .A(\u1_trans/state[1] ), .B(\u1_trans/state[0] ), .Z(n605) );
  COND3X1 U734 ( .A(n546), .B(n545), .C(n544), .D(n605), .Z(n386) );
  CMX2X1 U735 ( .A0(\u1_recv/rcv_shift_reg[0] ), .A1(
        \u1_recv/rcv_shift_reg[1] ), .S(n568), .Z(n369) );
  CMXI2X1 U736 ( .A0(n558), .A1(n547), .S(n568), .Z(n372) );
  CIVX2 U737 ( .A(n548), .Z(n556) );
  CNR3XL U738 ( .A(n550), .B(\u1_recv/state[0] ), .C(n549), .Z(n563) );
  CND2XL U739 ( .A(uc[5]), .B(n563), .Z(n616) );
  CNR3XL U740 ( .A(\u1_recv/state[0] ), .B(n552), .C(n551), .Z(n553) );
  CANR4CXL U741 ( .A(\u1_recv/state[1] ), .B(n561), .C(\u1_recv/state[2] ), 
        .D(n553), .Z(n564) );
  CIVX2 U742 ( .A(n564), .Z(n554) );
  COND1XL U743 ( .A(n614), .B(n554), .C(\u1_recv/state[1] ), .Z(n555) );
  COND3X1 U744 ( .A(n557), .B(n556), .C(n616), .D(n555), .Z(
        \u1_recv/nxt_state [1]) );
  CMXI2X1 U745 ( .A0(n559), .A1(n558), .S(n568), .Z(n371) );
  CNR3XL U746 ( .A(\u1_recv/state[1] ), .B(n561), .C(n560), .Z(n610) );
  CND2IX1 U747 ( .B(n565), .A(n564), .Z(n613) );
  CMXI2X1 U748 ( .A0(n570), .A1(n569), .S(n568), .Z(n374) );
  CIVXL U749 ( .A(\u1_trans/tx_cnt[2] ), .Z(n575) );
  CND2X1 U750 ( .A(\u1_trans/tx_cnt[1] ), .B(n609), .Z(n706) );
  CND2X1 U751 ( .A(n572), .B(n606), .Z(n573) );
  CIVX2 U752 ( .A(n573), .Z(n607) );
  COND4CX1 U753 ( .A(\u1_trans/tx_cnt[1] ), .B(\u1_trans/tx_cnt[0] ), .C(n607), 
        .D(n606), .Z(n704) );
  COND4CX1 U754 ( .A(n575), .B(n573), .C(n704), .D(\u1_trans/tx_cnt[3] ), .Z(
        n574) );
  COND11X1 U755 ( .A(\u1_trans/tx_cnt[3] ), .B(n575), .C(n706), .D(n574), .Z(
        n390) );
  CANR1XL U756 ( .A(n577), .B(\u1_recv/tick_counter[0] ), .C(n576), .Z(n578)
         );
  CNR2IX1 U757 ( .B(n579), .A(n578), .Z(n381) );
  CIVX2 U758 ( .A(n580), .Z(n585) );
  CANR2XL U759 ( .A(n597), .B(n581), .C(rcv_data[4]), .D(n665), .Z(n582) );
  COND11X1 U760 ( .A(n585), .B(n584), .C(n583), .D(n582), .Z(n360) );
  CND2X1 U761 ( .A(\u1_recv/tick_counter[2] ), .B(n586), .Z(n587) );
  COND11X1 U762 ( .A(n589), .B(\u1_recv/tick_counter[2] ), .C(n588), .D(n587), 
        .Z(n379) );
  CNR2IX1 U763 ( .B(n591), .A(n590), .Z(\u1_trans/txcn ) );
  CND3XL U764 ( .A(n707), .B(\u1_trans/txcn ), .C(ub[3]), .Z(n593) );
  CANR2XL U765 ( .A(uc[5]), .B(n607), .C(\u1_trans/state[0] ), .D(
        \u1_trans/state[2] ), .Z(n592) );
  CND2X1 U766 ( .A(n593), .B(n592), .Z(n392) );
  CANR2XL U767 ( .A(n595), .B(n594), .C(rcv_data[1]), .D(n665), .Z(n600) );
  CND3XL U768 ( .A(n598), .B(n597), .C(n596), .Z(n599) );
  COND3X1 U769 ( .A(n602), .B(n601), .C(n600), .D(n599), .Z(n363) );
  CIVX2 U770 ( .A(ub[2]), .Z(n674) );
  CND2XL U771 ( .A(uc[2]), .B(n674), .Z(n698) );
  CNR2X1 U772 ( .A(uc[1]), .B(n698), .Z(n678) );
  CIVX1 U773 ( .A(n678), .Z(n677) );
  CND2XL U774 ( .A(n674), .B(uc[1]), .Z(n700) );
  CND2X1 U775 ( .A(uc[1]), .B(uc[2]), .Z(n695) );
  CNR2X1 U776 ( .A(n674), .B(n695), .Z(n672) );
  CNR3XL U777 ( .A(ub[2]), .B(uc[1]), .C(uc[2]), .Z(n676) );
  CIVX1 U778 ( .A(n676), .Z(n671) );
  CIVXL U779 ( .A(uc[4]), .Z(n670) );
  COND1XL U780 ( .A(\u1_trans/tx_cnt[0] ), .B(n607), .C(n606), .Z(n608) );
  CMX2X1 U781 ( .A0(n609), .A1(n608), .S(\u1_trans/tx_cnt[1] ), .Z(n388) );
  CAOR1X1 U782 ( .A(\u1_trans/bit_cnt_reg[2] ), .B(n695), .C(n674), .Z(
        \u1_trans/bit_cnt [2]) );
  CNR2XL U783 ( .A(\u1_recv/state[1] ), .B(\u1_recv/state[2] ), .Z(n612) );
  CANR11XL U784 ( .A(n612), .B(ub[4]), .C(n611), .D(n610), .Z(n617) );
  COND1XL U785 ( .A(n614), .B(n613), .C(\u1_recv/state[0] ), .Z(n615) );
  COND3X1 U786 ( .A(\uif.rxdata ), .B(n617), .C(n616), .D(n615), .Z(
        \u1_recv/nxt_state [0]) );
  CND2IXL U787 ( .B(n618), .A(cnt[0]), .Z(n619) );
  CENX1 U788 ( .A(baud_clk), .B(n619), .Z(n323) );
  CIVXL U789 ( .A(\uif.din [0]), .Z(n620) );
  CIVX2 U790 ( .A(ub[0]), .Z(n648) );
  CMXI2X1 U791 ( .A0(n620), .A1(n648), .S(n669), .Z(n334) );
  CND2X1 U792 ( .A(\uif.addr [1]), .B(n630), .Z(n626) );
  CNR2X1 U793 ( .A(\u1_recv/state_ext [1]), .B(\u1_recv/state_ext [0]), .Z(
        n622) );
  CANR11X1 U794 ( .A(\uif.rxir ), .B(\u1_recv/state_ext [2]), .C(n622), .D(
        ua[7]), .Z(n623) );
  CNR2X1 U795 ( .A(n679), .B(n623), .Z(n352) );
  CANR2X1 U796 ( .A(n679), .B(rcv_data[3]), .C(n652), .D(ub[3]), .Z(n628) );
  CNR2X1 U797 ( .A(\uif.addr [2]), .B(n626), .Z(n649) );
  CANR2X1 U798 ( .A(n651), .B(data_out[3]), .C(n649), .D(uc[3]), .Z(n627) );
  CND2X1 U799 ( .A(n628), .B(n627), .Z(\uif.dout [3]) );
  CIVX2 U800 ( .A(n679), .Z(n656) );
  CIVX2 U801 ( .A(rcv_data[5]), .Z(n633) );
  CANR2X1 U802 ( .A(uc[5]), .B(n649), .C(n650), .D(ua[5]), .Z(n632) );
  CANR2X1 U803 ( .A(n652), .B(ub[5]), .C(n651), .D(data_out[5]), .Z(n631) );
  COND3X1 U804 ( .A(n656), .B(n633), .C(n632), .D(n631), .Z(\uif.dout [5]) );
  CIVX2 U805 ( .A(rcv_data[4]), .Z(n636) );
  CANR2X1 U806 ( .A(uc[4]), .B(n649), .C(n650), .D(ua[4]), .Z(n635) );
  CANR2X1 U807 ( .A(ub[4]), .B(n652), .C(n651), .D(data_out[4]), .Z(n634) );
  COND3X1 U808 ( .A(n656), .B(n636), .C(n635), .D(n634), .Z(\uif.dout [4]) );
  CANR2X1 U809 ( .A(uc[2]), .B(n649), .C(ua[2]), .D(n650), .Z(n638) );
  CANR2X1 U810 ( .A(n679), .B(rcv_data[2]), .C(n651), .D(data_out[2]), .Z(n637) );
  COND3X1 U811 ( .A(n674), .B(n647), .C(n638), .D(n637), .Z(\uif.dout [2]) );
  CIVX2 U812 ( .A(rcv_data[6]), .Z(n641) );
  CANR2X1 U813 ( .A(n650), .B(ua[6]), .C(n649), .D(uc[6]), .Z(n640) );
  CANR2X1 U814 ( .A(n652), .B(ub[6]), .C(n651), .D(data_out[6]), .Z(n639) );
  COND3X1 U815 ( .A(n656), .B(n641), .C(n640), .D(n639), .Z(\uif.dout [6]) );
  CIVX2 U816 ( .A(rcv_data[7]), .Z(n644) );
  CANR2X1 U817 ( .A(n650), .B(ua[7]), .C(n649), .D(uc[7]), .Z(n643) );
  CANR2X1 U818 ( .A(n652), .B(ub[7]), .C(n651), .D(data_out[7]), .Z(n642) );
  COND3X1 U819 ( .A(n656), .B(n644), .C(n643), .D(n642), .Z(\uif.dout [7]) );
  CANR2X1 U820 ( .A(n650), .B(ua[0]), .C(uc[0]), .D(n649), .Z(n646) );
  CANR2X1 U821 ( .A(n679), .B(rcv_data[0]), .C(n651), .D(data_out[0]), .Z(n645) );
  COND3X1 U822 ( .A(n648), .B(n647), .C(n646), .D(n645), .Z(\uif.dout [0]) );
  CIVX2 U823 ( .A(rcv_data[1]), .Z(n655) );
  CANR2XL U824 ( .A(ua[1]), .B(n650), .C(uc[1]), .D(n649), .Z(n654) );
  CANR2X1 U825 ( .A(ub[1]), .B(n652), .C(n651), .D(data_out[1]), .Z(n653) );
  COND3X1 U826 ( .A(n656), .B(n655), .C(n654), .D(n653), .Z(\uif.dout [1]) );
  CMX2XL U827 ( .A0(cnt[10]), .A1(ubrrnh[3]), .S(n658), .Z(n682) );
  CMX2XL U828 ( .A0(cnt[9]), .A1(ubrrnh[2]), .S(n658), .Z(n684) );
  CMX2X1 U829 ( .A0(cnt[8]), .A1(ubrrnh[1]), .S(n658), .Z(n686) );
  CMX2X1 U830 ( .A0(cnt[7]), .A1(ubrrnh[0]), .S(n658), .Z(n688) );
  CMX2X1 U831 ( .A0(cnt[6]), .A1(ubrrnl[7]), .S(n658), .Z(n690) );
  CMX2X1 U832 ( .A0(cnt[5]), .A1(ubrrnl[6]), .S(n658), .Z(n692) );
  COR2X1 U833 ( .A(n660), .B(n659), .Z(n691) );
  COR2X1 U834 ( .A(n692), .B(n691), .Z(n689) );
  COR2X1 U835 ( .A(n690), .B(n689), .Z(n687) );
  COR2X1 U836 ( .A(n688), .B(n687), .Z(n685) );
  COR2X1 U837 ( .A(n686), .B(n685), .Z(n683) );
  COR2X1 U838 ( .A(n684), .B(n683), .Z(n681) );
  CIVX2 U839 ( .A(n695), .Z(n694) );
  COAN1XL U840 ( .A(n694), .B(\u1_trans/bit_cnt_reg[3] ), .C(ub[2]), .Z(
        \u1_trans/bit_cnt [3]) );
  CAOR2XL U841 ( .A(\u1_trans/udrn_reg[0] ), .B(n667), .C(n666), .D(
        \u1_trans/shift_reg_q [1]), .Z(\u1_trans/shift_reg [0]) );
  COAN1XL U842 ( .A(\u1_recv/bit_cnt_reg[3] ), .B(n694), .C(ub[2]), .Z(
        \u1_recv/bit_cnt [3]) );
  CAOR2XL U843 ( .A(\u1_trans/udrn_reg[1] ), .B(n667), .C(n666), .D(
        \u1_trans/shift_reg_q [2]), .Z(\u1_trans/shift_reg [1]) );
  CAOR2XL U844 ( .A(\u1_trans/udrn_reg[2] ), .B(n667), .C(n666), .D(
        \u1_trans/shift_reg_q [3]), .Z(\u1_trans/shift_reg [2]) );
  CAOR2XL U845 ( .A(\u1_trans/udrn_reg[5] ), .B(n667), .C(n666), .D(
        \u1_trans/shift_reg_q [6]), .Z(\u1_trans/shift_reg [5]) );
  CAOR2XL U846 ( .A(\u1_trans/udrn_reg[3] ), .B(n667), .C(n666), .D(
        \u1_trans/shift_reg_q [4]), .Z(\u1_trans/shift_reg [3]) );
  CAOR2XL U847 ( .A(\u1_trans/udrn_reg[6] ), .B(n667), .C(n666), .D(
        \u1_trans/shift_reg_q [7]), .Z(\u1_trans/shift_reg [6]) );
  CAOR2XL U848 ( .A(\u1_trans/udrn_reg[4] ), .B(n667), .C(n666), .D(
        \u1_trans/shift_reg_q [5]), .Z(\u1_trans/shift_reg [4]) );
  CMX2XL U849 ( .A0(\uif.din [1]), .A1(ua[1]), .S(n668), .Z(n342) );
  CMX2XL U850 ( .A0(\uif.din [2]), .A1(ub[2]), .S(n669), .Z(n335) );
  CMX2XL U851 ( .A0(uc[5]), .A1(\uif.din [5]), .S(n680), .Z(n331) );
  CENX1 U852 ( .A(n682), .B(n681), .Z(N55) );
  CENX1 U853 ( .A(n684), .B(n683), .Z(N54) );
  CENX1 U854 ( .A(n686), .B(n685), .Z(N53) );
  CENX1 U855 ( .A(n688), .B(n687), .Z(N52) );
  CENX1 U856 ( .A(n690), .B(n689), .Z(N51) );
  CENX1 U857 ( .A(n692), .B(n691), .Z(N50) );
  COND1XL U858 ( .A(n694), .B(n693), .C(ub[2]), .Z(\u1_recv/bit_cnt [2]) );
  CIVXL U859 ( .A(\u1_recv/bit_cnt_reg[1] ), .Z(n696) );
  CND2XL U860 ( .A(ub[2]), .B(n695), .Z(n701) );
  COND1XL U861 ( .A(n696), .B(n701), .C(n698), .Z(\u1_recv/bit_cnt [1]) );
  COND1XL U862 ( .A(n697), .B(n701), .C(n700), .Z(\u1_recv/bit_cnt [0]) );
  CIVX2 U863 ( .A(\u1_trans/bit_cnt_reg[1] ), .Z(n699) );
  COND1XL U864 ( .A(n699), .B(n701), .C(n698), .Z(\u1_trans/bit_cnt [1]) );
  CIVX2 U865 ( .A(\u1_trans/bit_cnt_reg[0] ), .Z(n702) );
  COND1XL U866 ( .A(n702), .B(n701), .C(n700), .Z(\u1_trans/bit_cnt [0]) );
  COND1XL U867 ( .A(n710), .B(n707), .C(n703), .Z(n393) );
  CND2X1 U868 ( .A(\u1_trans/tx_cnt[2] ), .B(n704), .Z(n705) );
  COND1XL U869 ( .A(n706), .B(\u1_trans/tx_cnt[2] ), .C(n705), .Z(n387) );
  CIVXL U870 ( .A(ua[5]), .Z(n709) );
  CND3XL U871 ( .A(\uif.tcir ), .B(\uif.tcack ), .C(n707), .Z(n708) );
  COND1XL U872 ( .A(n710), .B(n709), .C(n708), .Z(n384) );
endmodule

