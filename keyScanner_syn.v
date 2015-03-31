
module keyScanner ( ph1, ph2, reset, rows, cols, currentDigit, lastDigit, 
        slowtimer );
  input [3:0] rows;
  output [3:0] cols;
  output [3:0] currentDigit;
  output [3:0] lastDigit;
  input ph1, ph2, reset;
  output slowtimer;
  wire   timerreg_d2_0_, timerreg_f_mid_0_, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126;
  wire   [1:0] enabletimer;
  wire   [1:0] state;
  wire   [3:0] lastrow;
  wire   [1:0] enablereg_d2;
  wire   [3:0] lastrowreg_d2;
  wire   [1:0] statereg_d2;
  wire   [3:0] currentdigitreg_d2;
  wire   [3:0] lastdigitreg_d2;
  wire   [1:0] enablereg_f_mid;
  wire   [3:0] lastrowreg_f_mid;
  wire   [1:0] statereg_f_mid;
  wire   [3:0] currentdigitreg_f_mid;
  wire   [3:0] lastdigitreg_f_mid;

  latch_c_1x enablereg_f_slave_q_reg_0_ ( .ph(ph1), .d(enablereg_f_mid[0]), 
        .q(enabletimer[0]) );
  latch_c_1x enablereg_f_master_q_reg_0_ ( .ph(ph2), .d(enablereg_d2[0]), .q(
        enablereg_f_mid[0]) );
  latch_c_1x enablereg_f_slave_q_reg_1_ ( .ph(ph1), .d(enablereg_f_mid[1]), 
        .q(enabletimer[1]) );
  latch_c_1x enablereg_f_master_q_reg_1_ ( .ph(ph2), .d(enablereg_d2[1]), .q(
        enablereg_f_mid[1]) );
  latch_c_1x timerreg_f_slave_q_reg_0_ ( .ph(ph1), .d(timerreg_f_mid_0_), .q(
        slowtimer) );
  latch_c_1x timerreg_f_master_q_reg_0_ ( .ph(ph2), .d(timerreg_d2_0_), .q(
        timerreg_f_mid_0_) );
  latch_c_1x lastrowreg_f_slave_q_reg_3_ ( .ph(ph1), .d(lastrowreg_f_mid[3]), 
        .q(lastrow[3]) );
  latch_c_1x statereg_f_master_q_reg_0_ ( .ph(ph2), .d(statereg_d2[0]), .q(
        statereg_f_mid[0]) );
  latch_c_1x statereg_f_slave_q_reg_0_ ( .ph(ph1), .d(statereg_f_mid[0]), .q(
        state[0]) );
  latch_c_1x statereg_f_master_q_reg_1_ ( .ph(ph2), .d(statereg_d2[1]), .q(
        statereg_f_mid[1]) );
  latch_c_1x statereg_f_slave_q_reg_1_ ( .ph(ph1), .d(statereg_f_mid[1]), .q(
        state[1]) );
  latch_c_1x currentdigitreg_f_master_q_reg_0_ ( .ph(ph2), .d(
        currentdigitreg_d2[0]), .q(currentdigitreg_f_mid[0]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_0_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[0]), .q(currentDigit[0]) );
  latch_c_1x lastdigitreg_f_master_q_reg_0_ ( .ph(ph2), .d(lastdigitreg_d2[0]), 
        .q(lastdigitreg_f_mid[0]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_0_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[0]), .q(lastDigit[0]) );
  latch_c_1x currentdigitreg_f_master_q_reg_2_ ( .ph(ph2), .d(
        currentdigitreg_d2[2]), .q(currentdigitreg_f_mid[2]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_2_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[2]), .q(currentDigit[2]) );
  latch_c_1x lastdigitreg_f_master_q_reg_2_ ( .ph(ph2), .d(lastdigitreg_d2[2]), 
        .q(lastdigitreg_f_mid[2]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_2_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[2]), .q(lastDigit[2]) );
  latch_c_1x currentdigitreg_f_master_q_reg_3_ ( .ph(ph2), .d(
        currentdigitreg_d2[3]), .q(currentdigitreg_f_mid[3]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_3_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[3]), .q(currentDigit[3]) );
  latch_c_1x lastdigitreg_f_master_q_reg_3_ ( .ph(ph2), .d(lastdigitreg_d2[3]), 
        .q(lastdigitreg_f_mid[3]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_3_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[3]), .q(lastDigit[3]) );
  latch_c_1x currentdigitreg_f_master_q_reg_1_ ( .ph(ph2), .d(
        currentdigitreg_d2[1]), .q(currentdigitreg_f_mid[1]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_1_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[1]), .q(currentDigit[1]) );
  latch_c_1x lastdigitreg_f_master_q_reg_1_ ( .ph(ph2), .d(lastdigitreg_d2[1]), 
        .q(lastdigitreg_f_mid[1]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_1_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[1]), .q(lastDigit[1]) );
  latch_c_1x lastrowreg_f_master_q_reg_0_ ( .ph(ph2), .d(lastrowreg_d2[0]), 
        .q(lastrowreg_f_mid[0]) );
  latch_c_1x lastrowreg_f_slave_q_reg_0_ ( .ph(ph1), .d(lastrowreg_f_mid[0]), 
        .q(lastrow[0]) );
  latch_c_1x lastrowreg_f_master_q_reg_1_ ( .ph(ph2), .d(lastrowreg_d2[1]), 
        .q(lastrowreg_f_mid[1]) );
  latch_c_1x lastrowreg_f_slave_q_reg_1_ ( .ph(ph1), .d(lastrowreg_f_mid[1]), 
        .q(lastrow[1]) );
  latch_c_1x lastrowreg_f_master_q_reg_2_ ( .ph(ph2), .d(lastrowreg_d2[2]), 
        .q(lastrowreg_f_mid[2]) );
  latch_c_1x lastrowreg_f_slave_q_reg_2_ ( .ph(ph1), .d(lastrowreg_f_mid[2]), 
        .q(lastrow[2]) );
  latch_c_1x lastrowreg_f_master_q_reg_3_ ( .ph(ph2), .d(lastrowreg_d2[3]), 
        .q(lastrowreg_f_mid[3]) );
  nor2_2x U87 ( .a(reset), .b(n106), .y(n125) );
  nand2_1x U88 ( .a(n117), .b(n116), .y(n122) );
  nor2_1x U89 ( .a(n117), .b(n95), .y(n96) );
  nor2_1x U90 ( .a(n87), .b(n117), .y(n88) );
  nor2_1x U91 ( .a(n111), .b(cols[0]), .y(n85) );
  nor2_1x U92 ( .a(n121), .b(n109), .y(n86) );
  nor2_1x U93 ( .a(n117), .b(n99), .y(n100) );
  nor2_1x U94 ( .a(n113), .b(n117), .y(n114) );
  nor2_1x U95 ( .a(n91), .b(n117), .y(n92) );
  nor2_1x U96 ( .a(n109), .b(cols[3]), .y(n89) );
  nor2_1x U97 ( .a(cols[2]), .b(n107), .y(n90) );
  nor2_1x U98 ( .a(n117), .b(n101), .y(n102) );
  nor2_1x U99 ( .a(n82), .b(n117), .y(n83) );
  nor2_1x U100 ( .a(n111), .b(n78), .y(n80) );
  nor2_1x U101 ( .a(n117), .b(n97), .y(n98) );
  nor2_2x U102 ( .a(reset), .b(n75), .y(n103) );
  nor2_1x U103 ( .a(n107), .b(n117), .y(n108) );
  nor2_1x U104 ( .a(n109), .b(n117), .y(n110) );
  nor2_1x U105 ( .a(n111), .b(n117), .y(n112) );
  nor2_2x U106 ( .a(rows[0]), .b(n107), .y(n118) );
  inv_4x U107 ( .a(rows[1]), .y(n65) );
  nor2_2x U108 ( .a(rows[3]), .b(rows[2]), .y(n66) );
  nor2_2x U109 ( .a(reset), .b(n73), .y(n126) );
  nand2_2x U110 ( .a(rows[2]), .b(n113), .y(n111) );
  inv_4x U111 ( .a(rows[3]), .y(n113) );
  inv_1x U112 ( .a(n104), .y(n105) );
  nand2_2x U113 ( .a(enabletimer[0]), .b(enabletimer[1]), .y(n73) );
  inv_4x U114 ( .a(state[0]), .y(n119) );
  nor2_2x U115 ( .a(cols[3]), .b(cols[0]), .y(n121) );
  nor2_2x U116 ( .a(n94), .b(n93), .y(enablereg_d2[1]) );
  inv_4x U117 ( .a(n125), .y(n94) );
  nand2_2x U118 ( .a(n124), .b(n123), .y(statereg_d2[1]) );
  nand2_2x U119 ( .a(n121), .b(n120), .y(n124) );
  nand2_2x U120 ( .a(n77), .b(n76), .y(currentdigitreg_d2[0]) );
  inv_4x U121 ( .a(n84), .y(n109) );
  nor2_2x U122 ( .a(n118), .b(n104), .y(n74) );
  nand2_2x U123 ( .a(n66), .b(n65), .y(n107) );
  inv_4x U124 ( .a(n116), .y(n115) );
  inv_4x U125 ( .a(n73), .y(n106) );
  nor2_2x U126 ( .a(n119), .b(n78), .y(cols[0]) );
  inv_1x U127 ( .a(state[1]), .y(n78) );
  nand2_2x U128 ( .a(n126), .b(n74), .y(n117) );
  nor2_1x U129 ( .a(state[0]), .b(n78), .y(cols[1]) );
  nor2_1x U130 ( .a(state[1]), .b(n119), .y(cols[2]) );
  nor2_1x U131 ( .a(state[0]), .b(state[1]), .y(cols[3]) );
  nor3_1x U132 ( .a(rows[3]), .b(rows[2]), .c(n65), .y(n84) );
  nor3_1x U133 ( .a(n84), .b(state[0]), .c(rows[3]), .y(n64) );
  a2o1_1x U134 ( .a(state[0]), .b(n111), .c(n64), .y(n72) );
  or2_1x U135 ( .a(n78), .b(n107), .y(n71) );
  nand2_1x U136 ( .a(rows[3]), .b(lastrow[3]), .y(n69) );
  nand2_1x U137 ( .a(rows[1]), .b(lastrow[1]), .y(n68) );
  nand2_1x U138 ( .a(rows[0]), .b(lastrow[0]), .y(n67) );
  nand3_1x U139 ( .a(n69), .b(n68), .c(n67), .y(n70) );
  a2o1_1x U140 ( .a(rows[2]), .b(lastrow[2]), .c(n70), .y(n104) );
  a2o1_1x U141 ( .a(n72), .b(n71), .c(n117), .y(n77) );
  and2_1x U142 ( .a(n106), .b(n74), .y(n75) );
  nand2_1x U143 ( .a(currentDigit[0]), .b(n103), .y(n76) );
  nor2_1x U144 ( .a(n107), .b(state[0]), .y(n81) );
  mux2_c_1x U145 ( .d0(rows[3]), .d1(n84), .s(cols[3]), .y(n79) );
  nor3_1x U146 ( .a(n81), .b(n80), .c(n79), .y(n82) );
  a2o1_1x U147 ( .a(n103), .b(currentDigit[1]), .c(n83), .y(
        currentdigitreg_d2[1]) );
  nor3_1x U148 ( .a(n90), .b(n86), .c(n85), .y(n87) );
  a2o1_1x U149 ( .a(n103), .b(currentDigit[2]), .c(n88), .y(
        currentdigitreg_d2[2]) );
  nor3_1x U150 ( .a(n90), .b(cols[0]), .c(n89), .y(n91) );
  a2o1_1x U151 ( .a(n103), .b(currentDigit[3]), .c(n92), .y(
        currentdigitreg_d2[3]) );
  nor2_1x U152 ( .a(reset), .b(enabletimer[0]), .y(enablereg_d2[0]) );
  nor2_1x U153 ( .a(enabletimer[0]), .b(enabletimer[1]), .y(n93) );
  inv_1x U154 ( .a(currentDigit[0]), .y(n95) );
  a2o1_1x U155 ( .a(lastDigit[0]), .b(n103), .c(n96), .y(lastdigitreg_d2[0])
         );
  inv_1x U156 ( .a(currentDigit[1]), .y(n97) );
  a2o1_1x U157 ( .a(lastDigit[1]), .b(n103), .c(n98), .y(lastdigitreg_d2[1])
         );
  inv_1x U158 ( .a(currentDigit[2]), .y(n99) );
  a2o1_1x U159 ( .a(lastDigit[2]), .b(n103), .c(n100), .y(lastdigitreg_d2[2])
         );
  inv_1x U160 ( .a(currentDigit[3]), .y(n101) );
  a2o1_1x U161 ( .a(lastDigit[3]), .b(n103), .c(n102), .y(lastdigitreg_d2[3])
         );
  a2o1_1x U162 ( .a(n106), .b(n105), .c(reset), .y(n116) );
  a2o1_1x U163 ( .a(lastrow[0]), .b(n115), .c(n108), .y(lastrowreg_d2[0]) );
  a2o1_1x U164 ( .a(n115), .b(lastrow[1]), .c(n110), .y(lastrowreg_d2[1]) );
  a2o1_1x U165 ( .a(n115), .b(lastrow[2]), .c(n112), .y(lastrowreg_d2[2]) );
  a2o1_1x U166 ( .a(lastrow[3]), .b(n115), .c(n114), .y(lastrowreg_d2[3]) );
  and2_1x U167 ( .a(n126), .b(n118), .y(n120) );
  mux2_c_1x U168 ( .d0(n122), .d1(n120), .s(n119), .y(statereg_d2[0]) );
  nand2_1x U169 ( .a(state[1]), .b(n122), .y(n123) );
  mux2_c_1x U170 ( .d0(n126), .d1(n125), .s(slowtimer), .y(timerreg_d2_0_) );
endmodule

