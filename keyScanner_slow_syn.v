
module keyScanner_slow ( ph1, ph2, reset, rows, cols, currentDigit, lastDigit, 
        slowtimer );
  input [3:0] rows;
  output [3:0] cols;
  output [3:0] currentDigit;
  output [3:0] lastDigit;
  input ph1, ph2, reset;
  output slowtimer;
  wire   timerreg_d2_0_, timerreg_f_mid_0_, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167;
  wire   [17:0] enabletimer;
  wire   [1:0] state;
  wire   [3:0] lastrow;
  wire   [17:0] enablereg_d2;
  wire   [1:0] statereg_d2;
  wire   [3:0] lastrowreg_d2;
  wire   [3:0] currentdigitreg_d2;
  wire   [3:0] lastdigitreg_d2;
  wire   [17:0] enablereg_f_mid;
  wire   [1:0] statereg_f_mid;
  wire   [3:0] lastrowreg_f_mid;
  wire   [3:0] currentdigitreg_f_mid;
  wire   [3:0] lastdigitreg_f_mid;

  latch_c_1x enablereg_f_master_q_reg_0_ ( .ph(ph2), .d(enablereg_d2[0]), .q(
        enablereg_f_mid[0]) );
  latch_c_1x enablereg_f_master_q_reg_1_ ( .ph(ph2), .d(enablereg_d2[1]), .q(
        enablereg_f_mid[1]) );
  latch_c_1x enablereg_f_master_q_reg_2_ ( .ph(ph2), .d(enablereg_d2[2]), .q(
        enablereg_f_mid[2]) );
  latch_c_1x enablereg_f_master_q_reg_3_ ( .ph(ph2), .d(enablereg_d2[3]), .q(
        enablereg_f_mid[3]) );
  latch_c_1x enablereg_f_master_q_reg_4_ ( .ph(ph2), .d(enablereg_d2[4]), .q(
        enablereg_f_mid[4]) );
  latch_c_1x enablereg_f_master_q_reg_5_ ( .ph(ph2), .d(enablereg_d2[5]), .q(
        enablereg_f_mid[5]) );
  latch_c_1x enablereg_f_master_q_reg_6_ ( .ph(ph2), .d(enablereg_d2[6]), .q(
        enablereg_f_mid[6]) );
  latch_c_1x enablereg_f_master_q_reg_7_ ( .ph(ph2), .d(enablereg_d2[7]), .q(
        enablereg_f_mid[7]) );
  latch_c_1x enablereg_f_master_q_reg_8_ ( .ph(ph2), .d(enablereg_d2[8]), .q(
        enablereg_f_mid[8]) );
  latch_c_1x enablereg_f_master_q_reg_9_ ( .ph(ph2), .d(enablereg_d2[9]), .q(
        enablereg_f_mid[9]) );
  latch_c_1x enablereg_f_master_q_reg_10_ ( .ph(ph2), .d(enablereg_d2[10]), 
        .q(enablereg_f_mid[10]) );
  latch_c_1x enablereg_f_master_q_reg_11_ ( .ph(ph2), .d(enablereg_d2[11]), 
        .q(enablereg_f_mid[11]) );
  latch_c_1x enablereg_f_master_q_reg_12_ ( .ph(ph2), .d(enablereg_d2[12]), 
        .q(enablereg_f_mid[12]) );
  latch_c_1x enablereg_f_master_q_reg_13_ ( .ph(ph2), .d(enablereg_d2[13]), 
        .q(enablereg_f_mid[13]) );
  latch_c_1x enablereg_f_master_q_reg_14_ ( .ph(ph2), .d(enablereg_d2[14]), 
        .q(enablereg_f_mid[14]) );
  latch_c_1x enablereg_f_master_q_reg_15_ ( .ph(ph2), .d(enablereg_d2[15]), 
        .q(enablereg_f_mid[15]) );
  latch_c_1x enablereg_f_master_q_reg_16_ ( .ph(ph2), .d(enablereg_d2[16]), 
        .q(enablereg_f_mid[16]) );
  latch_c_1x enablereg_f_master_q_reg_17_ ( .ph(ph2), .d(enablereg_d2[17]), 
        .q(enablereg_f_mid[17]) );
  latch_c_1x enablereg_f_slave_q_reg_0_ ( .ph(ph1), .d(enablereg_f_mid[0]), 
        .q(enabletimer[0]) );
  latch_c_1x enablereg_f_slave_q_reg_1_ ( .ph(ph1), .d(enablereg_f_mid[1]), 
        .q(enabletimer[1]) );
  latch_c_1x enablereg_f_slave_q_reg_2_ ( .ph(ph1), .d(enablereg_f_mid[2]), 
        .q(enabletimer[2]) );
  latch_c_1x enablereg_f_slave_q_reg_3_ ( .ph(ph1), .d(enablereg_f_mid[3]), 
        .q(enabletimer[3]) );
  latch_c_1x enablereg_f_slave_q_reg_4_ ( .ph(ph1), .d(enablereg_f_mid[4]), 
        .q(enabletimer[4]) );
  latch_c_1x enablereg_f_slave_q_reg_5_ ( .ph(ph1), .d(enablereg_f_mid[5]), 
        .q(enabletimer[5]) );
  latch_c_1x enablereg_f_slave_q_reg_6_ ( .ph(ph1), .d(enablereg_f_mid[6]), 
        .q(enabletimer[6]) );
  latch_c_1x enablereg_f_slave_q_reg_7_ ( .ph(ph1), .d(enablereg_f_mid[7]), 
        .q(enabletimer[7]) );
  latch_c_1x enablereg_f_slave_q_reg_8_ ( .ph(ph1), .d(enablereg_f_mid[8]), 
        .q(enabletimer[8]) );
  latch_c_1x enablereg_f_slave_q_reg_9_ ( .ph(ph1), .d(enablereg_f_mid[9]), 
        .q(enabletimer[9]) );
  latch_c_1x enablereg_f_slave_q_reg_10_ ( .ph(ph1), .d(enablereg_f_mid[10]), 
        .q(enabletimer[10]) );
  latch_c_1x enablereg_f_slave_q_reg_11_ ( .ph(ph1), .d(enablereg_f_mid[11]), 
        .q(enabletimer[11]) );
  latch_c_1x enablereg_f_slave_q_reg_12_ ( .ph(ph1), .d(enablereg_f_mid[12]), 
        .q(enabletimer[12]) );
  latch_c_1x enablereg_f_slave_q_reg_13_ ( .ph(ph1), .d(enablereg_f_mid[13]), 
        .q(enabletimer[13]) );
  latch_c_1x enablereg_f_slave_q_reg_14_ ( .ph(ph1), .d(enablereg_f_mid[14]), 
        .q(enabletimer[14]) );
  latch_c_1x enablereg_f_slave_q_reg_15_ ( .ph(ph1), .d(enablereg_f_mid[15]), 
        .q(enabletimer[15]) );
  latch_c_1x enablereg_f_slave_q_reg_16_ ( .ph(ph1), .d(enablereg_f_mid[16]), 
        .q(enabletimer[16]) );
  latch_c_1x enablereg_f_slave_q_reg_17_ ( .ph(ph1), .d(enablereg_f_mid[17]), 
        .q(enabletimer[17]) );
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
  latch_c_1x lastrowreg_f_master_q_reg_2_ ( .ph(ph2), .d(lastrowreg_d2[2]), 
        .q(lastrowreg_f_mid[2]) );
  latch_c_1x lastrowreg_f_slave_q_reg_2_ ( .ph(ph1), .d(lastrowreg_f_mid[2]), 
        .q(lastrow[2]) );
  latch_c_1x lastrowreg_f_master_q_reg_1_ ( .ph(ph2), .d(lastrowreg_d2[1]), 
        .q(lastrowreg_f_mid[1]) );
  latch_c_1x lastrowreg_f_slave_q_reg_1_ ( .ph(ph1), .d(lastrowreg_f_mid[1]), 
        .q(lastrow[1]) );
  latch_c_1x lastrowreg_f_master_q_reg_0_ ( .ph(ph2), .d(lastrowreg_d2[0]), 
        .q(lastrowreg_f_mid[0]) );
  latch_c_1x lastrowreg_f_slave_q_reg_0_ ( .ph(ph1), .d(lastrowreg_f_mid[0]), 
        .q(lastrow[0]) );
  latch_c_1x currentdigitreg_f_master_q_reg_3_ ( .ph(ph2), .d(
        currentdigitreg_d2[3]), .q(currentdigitreg_f_mid[3]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_3_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[3]), .q(currentDigit[3]) );
  latch_c_1x lastdigitreg_f_master_q_reg_3_ ( .ph(ph2), .d(lastdigitreg_d2[3]), 
        .q(lastdigitreg_f_mid[3]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_3_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[3]), .q(lastDigit[3]) );
  latch_c_1x currentdigitreg_f_master_q_reg_2_ ( .ph(ph2), .d(
        currentdigitreg_d2[2]), .q(currentdigitreg_f_mid[2]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_2_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[2]), .q(currentDigit[2]) );
  latch_c_1x lastdigitreg_f_master_q_reg_2_ ( .ph(ph2), .d(lastdigitreg_d2[2]), 
        .q(lastdigitreg_f_mid[2]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_2_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[2]), .q(lastDigit[2]) );
  latch_c_1x currentdigitreg_f_master_q_reg_1_ ( .ph(ph2), .d(
        currentdigitreg_d2[1]), .q(currentdigitreg_f_mid[1]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_1_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[1]), .q(currentDigit[1]) );
  latch_c_1x lastdigitreg_f_master_q_reg_1_ ( .ph(ph2), .d(lastdigitreg_d2[1]), 
        .q(lastdigitreg_f_mid[1]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_1_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[1]), .q(lastDigit[1]) );
  latch_c_1x currentdigitreg_f_master_q_reg_0_ ( .ph(ph2), .d(
        currentdigitreg_d2[0]), .q(currentdigitreg_f_mid[0]) );
  latch_c_1x currentdigitreg_f_slave_q_reg_0_ ( .ph(ph1), .d(
        currentdigitreg_f_mid[0]), .q(currentDigit[0]) );
  latch_c_1x lastdigitreg_f_master_q_reg_0_ ( .ph(ph2), .d(lastdigitreg_d2[0]), 
        .q(lastdigitreg_f_mid[0]) );
  latch_c_1x lastdigitreg_f_slave_q_reg_0_ ( .ph(ph1), .d(
        lastdigitreg_f_mid[0]), .q(lastDigit[0]) );
  latch_c_1x lastrowreg_f_master_q_reg_3_ ( .ph(ph2), .d(lastrowreg_d2[3]), 
        .q(lastrowreg_f_mid[3]) );
  inv_4x U110 ( .a(n97), .y(n151) );
  inv_4x U111 ( .a(n160), .y(n157) );
  nor2_2x U112 ( .a(state[1]), .b(n73), .y(cols[2]) );
  nor2_2x U113 ( .a(n73), .b(n91), .y(cols[0]) );
  inv_2x U114 ( .a(state[1]), .y(n91) );
  inv_2x U115 ( .a(state[0]), .y(n73) );
  nor2_1x U116 ( .a(n72), .b(n155), .y(n156) );
  nor2_2x U117 ( .a(reset), .b(n119), .y(n166) );
  nand2_1x U118 ( .a(n165), .b(n164), .y(statereg_d2[1]) );
  nand2_1x U119 ( .a(n160), .b(n72), .y(n163) );
  nand2_1x U120 ( .a(n162), .b(n161), .y(n165) );
  inv_1x U121 ( .a(n158), .y(n162) );
  nor2_1x U122 ( .a(n153), .b(n72), .y(n154) );
  nor2_1x U123 ( .a(n151), .b(n72), .y(n152) );
  nor2_1x U124 ( .a(n72), .b(n149), .y(n150) );
  nor2_1x U125 ( .a(n104), .b(n72), .y(n105) );
  nor2_1x U126 ( .a(n151), .b(cols[3]), .y(n102) );
  nor2_1x U127 ( .a(n72), .b(n146), .y(n147) );
  nor2_1x U128 ( .a(n100), .b(n72), .y(n101) );
  nor2_1x U129 ( .a(n153), .b(cols[0]), .y(n98) );
  nor2_1x U130 ( .a(n161), .b(n151), .y(n99) );
  nor2_1x U131 ( .a(cols[3]), .b(cols[0]), .y(n161) );
  nor2_1x U132 ( .a(cols[2]), .b(n149), .y(n103) );
  nand2_1x U133 ( .a(n90), .b(n89), .y(currentdigitreg_d2[0]) );
  nor2_1x U134 ( .a(n72), .b(n144), .y(n145) );
  nor2_1x U135 ( .a(n95), .b(n72), .y(n96) );
  nor2_1x U136 ( .a(n153), .b(n91), .y(n93) );
  nor2_1x U137 ( .a(n72), .b(n142), .y(n143) );
  nor2_1x U138 ( .a(n72), .b(n140), .y(n141) );
  inv_1x U139 ( .a(n159), .y(n71) );
  inv_1x U140 ( .a(n88), .y(n83) );
  nand2_1x U141 ( .a(n160), .b(n158), .y(n148) );
  nand2_1x U142 ( .a(n167), .b(n88), .y(n158) );
  nor2_2x U143 ( .a(rows[0]), .b(n149), .y(n88) );
  nand2_1x U144 ( .a(n76), .b(n75), .y(n149) );
  inv_4x U145 ( .a(rows[1]), .y(n75) );
  nor2_2x U146 ( .a(reset), .b(n86), .y(n167) );
  inv_1x U147 ( .a(n82), .y(n87) );
  inv_1x U148 ( .a(n86), .y(n119) );
  nand2_2x U149 ( .a(n120), .b(enabletimer[17]), .y(n86) );
  inv_1x U150 ( .a(n77), .y(n125) );
  nand2_1x U151 ( .a(rows[2]), .b(n155), .y(n153) );
  inv_1x U152 ( .a(rows[3]), .y(n155) );
  inv_4x U153 ( .a(n71), .y(n72) );
  nor2_1x U154 ( .a(rows[3]), .b(rows[2]), .y(n76) );
  nor2_1x U155 ( .a(state[0]), .b(n91), .y(cols[1]) );
  nor2_1x U156 ( .a(state[0]), .b(state[1]), .y(cols[3]) );
  nor3_1x U157 ( .a(rows[3]), .b(rows[2]), .c(n75), .y(n97) );
  nor3_1x U158 ( .a(n97), .b(state[0]), .c(rows[3]), .y(n74) );
  a2o1_1x U159 ( .a(state[0]), .b(n153), .c(n74), .y(n85) );
  or2_1x U160 ( .a(n91), .b(n149), .y(n84) );
  nand3_1x U161 ( .a(enabletimer[0]), .b(enabletimer[1]), .c(enabletimer[2]), 
        .y(n77) );
  and2_1x U162 ( .a(n125), .b(enabletimer[3]), .y(n127) );
  and2_1x U163 ( .a(n127), .b(enabletimer[4]), .y(n129) );
  and2_1x U164 ( .a(n129), .b(enabletimer[5]), .y(n131) );
  and2_1x U165 ( .a(n131), .b(enabletimer[6]), .y(n133) );
  and2_1x U166 ( .a(n133), .b(enabletimer[7]), .y(n135) );
  and2_1x U167 ( .a(n135), .b(enabletimer[8]), .y(n137) );
  and2_1x U168 ( .a(n137), .b(enabletimer[9]), .y(n139) );
  and2_1x U169 ( .a(n139), .b(enabletimer[10]), .y(n107) );
  and2_1x U170 ( .a(n107), .b(enabletimer[11]), .y(n109) );
  and2_1x U171 ( .a(n109), .b(enabletimer[12]), .y(n111) );
  and2_1x U172 ( .a(n111), .b(enabletimer[13]), .y(n113) );
  and2_1x U173 ( .a(n113), .b(enabletimer[14]), .y(n115) );
  and2_1x U174 ( .a(n115), .b(enabletimer[15]), .y(n117) );
  and2_1x U175 ( .a(n117), .b(enabletimer[16]), .y(n120) );
  nand2_1x U176 ( .a(rows[1]), .b(lastrow[1]), .y(n80) );
  nand2_1x U177 ( .a(rows[3]), .b(lastrow[3]), .y(n79) );
  nand2_1x U178 ( .a(rows[0]), .b(lastrow[0]), .y(n78) );
  nand3_1x U179 ( .a(n80), .b(n79), .c(n78), .y(n81) );
  a2o1_1x U180 ( .a(rows[2]), .b(lastrow[2]), .c(n81), .y(n82) );
  nand3_1x U181 ( .a(n167), .b(n87), .c(n83), .y(n159) );
  a2o1_1x U182 ( .a(n85), .b(n84), .c(n72), .y(n90) );
  a2o1_1x U183 ( .a(n119), .b(n87), .c(reset), .y(n160) );
  nand2_1x U184 ( .a(currentDigit[0]), .b(n148), .y(n89) );
  nor2_1x U185 ( .a(n149), .b(state[0]), .y(n94) );
  mux2_c_1x U186 ( .d0(rows[3]), .d1(n97), .s(cols[3]), .y(n92) );
  nor3_1x U187 ( .a(n94), .b(n93), .c(n92), .y(n95) );
  a2o1_1x U188 ( .a(n148), .b(currentDigit[1]), .c(n96), .y(
        currentdigitreg_d2[1]) );
  nor3_1x U189 ( .a(n103), .b(n99), .c(n98), .y(n100) );
  a2o1_1x U190 ( .a(n148), .b(currentDigit[2]), .c(n101), .y(
        currentdigitreg_d2[2]) );
  nor3_1x U191 ( .a(n103), .b(cols[0]), .c(n102), .y(n104) );
  a2o1_1x U192 ( .a(n148), .b(currentDigit[3]), .c(n105), .y(
        currentdigitreg_d2[3]) );
  nor2_1x U193 ( .a(reset), .b(enabletimer[0]), .y(enablereg_d2[0]) );
  nor2_1x U194 ( .a(n139), .b(enabletimer[10]), .y(n106) );
  nor3_1x U195 ( .a(reset), .b(n107), .c(n106), .y(enablereg_d2[10]) );
  nor2_1x U196 ( .a(n107), .b(enabletimer[11]), .y(n108) );
  nor3_1x U197 ( .a(reset), .b(n109), .c(n108), .y(enablereg_d2[11]) );
  nor2_1x U198 ( .a(n109), .b(enabletimer[12]), .y(n110) );
  nor3_1x U199 ( .a(reset), .b(n111), .c(n110), .y(enablereg_d2[12]) );
  nor2_1x U200 ( .a(n111), .b(enabletimer[13]), .y(n112) );
  nor3_1x U201 ( .a(reset), .b(n113), .c(n112), .y(enablereg_d2[13]) );
  nor2_1x U202 ( .a(n113), .b(enabletimer[14]), .y(n114) );
  nor3_1x U203 ( .a(reset), .b(n115), .c(n114), .y(enablereg_d2[14]) );
  nor2_1x U204 ( .a(n115), .b(enabletimer[15]), .y(n116) );
  nor3_1x U205 ( .a(reset), .b(n117), .c(n116), .y(enablereg_d2[15]) );
  nor2_1x U206 ( .a(n117), .b(enabletimer[16]), .y(n118) );
  nor3_1x U207 ( .a(reset), .b(n120), .c(n118), .y(enablereg_d2[16]) );
  or2_1x U208 ( .a(enabletimer[17]), .b(n120), .y(n121) );
  and2_1x U209 ( .a(n166), .b(n121), .y(enablereg_d2[17]) );
  and2_1x U210 ( .a(enabletimer[0]), .b(enabletimer[1]), .y(n123) );
  nor2_1x U211 ( .a(enabletimer[0]), .b(enabletimer[1]), .y(n122) );
  nor3_1x U212 ( .a(reset), .b(n123), .c(n122), .y(enablereg_d2[1]) );
  nor2_1x U213 ( .a(n123), .b(enabletimer[2]), .y(n124) );
  nor3_1x U214 ( .a(reset), .b(n125), .c(n124), .y(enablereg_d2[2]) );
  nor2_1x U215 ( .a(n125), .b(enabletimer[3]), .y(n126) );
  nor3_1x U216 ( .a(reset), .b(n127), .c(n126), .y(enablereg_d2[3]) );
  nor2_1x U217 ( .a(n127), .b(enabletimer[4]), .y(n128) );
  nor3_1x U218 ( .a(reset), .b(n129), .c(n128), .y(enablereg_d2[4]) );
  nor2_1x U219 ( .a(n129), .b(enabletimer[5]), .y(n130) );
  nor3_1x U220 ( .a(reset), .b(n131), .c(n130), .y(enablereg_d2[5]) );
  nor2_1x U221 ( .a(n131), .b(enabletimer[6]), .y(n132) );
  nor3_1x U222 ( .a(reset), .b(n133), .c(n132), .y(enablereg_d2[6]) );
  nor2_1x U223 ( .a(n133), .b(enabletimer[7]), .y(n134) );
  nor3_1x U224 ( .a(reset), .b(n135), .c(n134), .y(enablereg_d2[7]) );
  nor2_1x U225 ( .a(n135), .b(enabletimer[8]), .y(n136) );
  nor3_1x U226 ( .a(reset), .b(n137), .c(n136), .y(enablereg_d2[8]) );
  nor2_1x U227 ( .a(n137), .b(enabletimer[9]), .y(n138) );
  nor3_1x U228 ( .a(reset), .b(n139), .c(n138), .y(enablereg_d2[9]) );
  inv_1x U229 ( .a(currentDigit[0]), .y(n140) );
  a2o1_1x U230 ( .a(lastDigit[0]), .b(n148), .c(n141), .y(lastdigitreg_d2[0])
         );
  inv_1x U231 ( .a(currentDigit[1]), .y(n142) );
  a2o1_1x U232 ( .a(lastDigit[1]), .b(n148), .c(n143), .y(lastdigitreg_d2[1])
         );
  inv_1x U233 ( .a(currentDigit[2]), .y(n144) );
  a2o1_1x U234 ( .a(lastDigit[2]), .b(n148), .c(n145), .y(lastdigitreg_d2[2])
         );
  inv_1x U235 ( .a(currentDigit[3]), .y(n146) );
  a2o1_1x U236 ( .a(lastDigit[3]), .b(n148), .c(n147), .y(lastdigitreg_d2[3])
         );
  a2o1_1x U237 ( .a(lastrow[0]), .b(n157), .c(n150), .y(lastrowreg_d2[0]) );
  a2o1_1x U238 ( .a(lastrow[1]), .b(n157), .c(n152), .y(lastrowreg_d2[1]) );
  a2o1_1x U239 ( .a(lastrow[2]), .b(n157), .c(n154), .y(lastrowreg_d2[2]) );
  a2o1_1x U240 ( .a(lastrow[3]), .b(n157), .c(n156), .y(lastrowreg_d2[3]) );
  mux2_c_1x U241 ( .d0(n162), .d1(n163), .s(state[0]), .y(statereg_d2[0]) );
  nand2_1x U242 ( .a(state[1]), .b(n163), .y(n164) );
  mux2_c_1x U243 ( .d0(n167), .d1(n166), .s(slowtimer), .y(timerreg_d2_0_) );
endmodule

