module Base_Adder_Carry(
  input [4:0] A, B,
  input C_in,
  output [4:0] S,
  output C_Out
);
  wire [4:0] G, P;
  wire [5:0] C;  
  assign G = A & B;
  assign P = A ^ B;  
  assign C[0] = C_in;
  assign C[1] = G[0]|(P[0]&C_in);
  assign C[2] = G[1]|(P[1]&G[0])|(P[1]&P[0]&C_in);
  assign C[3] = G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&C_in);
  assign C[4] = G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0])|(P[3]&P[2]&P[1]&P[0]&C_in);
  assign C[5] = G[4]|(P[4]&G[3])|(P[4]&P[3]&G[2])|(P[4]&P[3]&P[2]&G[1])|(P[4]&P[3]&P[2]&P[1]&G[0])|(P[4]&P[3]&P[2]&P[1]&P[0]&C_in);
  assign S = P ^ C[4:0];
  assign C_Out = C[5];
endmodule

module CSA(input [49:0]A,B,
           output [49:0]sum, 
             output C_out); 
  wire C1, C2, C3, C4, C5, C6, C7, C8, C9; 
  wire [4:0] S1_0,S1_1, S2_0, S2_1, S3_0, S3_1, S4_0, S4_1, S5_0, S5_1, S6_0, S6_1, S7_0, S7_1, S8_0, S8_1, S9_0, S9_1; 
  wire C1_0, C1_1, C2_0, C2_1, C3_0, C3_1, C4_0, C4_1,C5_0, C5_1, C6_0, C6_1, C7_0, C7_1, C8_0, C8_1, C9_0, C9_1;  
  
  //<-------------------  Stage 1 -------------------------->\\
  Base_Adder_Carry BA1(A[4:0], B[4:0], 1'b0, sum[4:0], C1); 
  //<-------------------  Stage 2 -------------------------->\\ 
  Base_Adder_Carry BAC1_0(A[9:5], B[9:5], 1'b0, S1_0, C1_0); 
  Base_Adder_Carry BAC1_1(A[9:5], B[9:5], 1'b1, S1_1, C1_1);
  //MUX logic for carry select and sum select 
  assign {sum[9:5], C2} = C1? {S1_1, C1_1}:{S1_0, C1_0}; 
  
  //<-------------------  Stage 3 -------------------------->\\ 
  Base_Adder_Carry BAC2_0(A[14:10], B[14:10], 1'b0, S2_0, C2_0); 
  Base_Adder_Carry BAC2_1(A[14:10], B[14:10], 1'b1, S2_1, C2_1);
  //MUX logic for carry select and sum select 
  assign {sum[14:10], C3} = C2? {S2_1, C2_1}:{S2_0, C2_0}; 
  
  //<-------------------  Partial Stage 4 -------------------------->\\ 
  Base_Adder_Carry BAC3_0(A[19:15], B[19:15], 1'b0, S3_0, C3_0); 
  Base_Adder_Carry BAC3_1(A[19:15], B[19:15], 1'b1, S3_1, C3_1);
  //MUX logic for carry select and sum select 
  assign {sum[19:15], C4} = C3? {S3_1, C3_1}:{S3_0, C3_0}; 
  //<-------------------  Partial Stage 5 -------------------------->\\ 
  Base_Adder_Carry BAC4_0(A[24:20], B[24:20], 1'b0, S4_0, C4_0); 
  Base_Adder_Carry BAC4_1(A[24:20], B[24:20], 1'b1, S4_1, C4_1);
  //MUX logic for carry select and sum select 
  assign {sum[24:20], C5} = C4? {S4_1, C4_1}:{S4_0, C4_0};
  //<-------------------  Partial Stage 6 -------------------------->\\ 
  Base_Adder_Carry BAC5_0(A[29:25], B[29:25], 1'b0, S5_0, C5_0); 
  Base_Adder_Carry BAC5_1(A[29:25], B[29:25], 1'b1, S5_1, C5_1);
  //MUX logic for carry select and sum select 
  assign {sum[29:25], C6} = C5? {S5_1, C5_1}:{S5_0, C5_0};
  //<-------------------  Partial Stage 7 -------------------------->\\ 
  Base_Adder_Carry BAC6_0(A[34:30], B[34:30], 1'b0, S6_0, C6_0); 
  Base_Adder_Carry BAC6_1(A[34:30], B[34:30], 1'b1, S6_1, C6_1);
  //MUX logic for carry select and sum select 
  assign {sum[34:30], C7} = C6? {S6_1, C6_1}:{S6_0, C6_0};
  //<-------------------  Partial Stage 8 -------------------------->\\ 
  Base_Adder_Carry BAC7_0(A[39:35], B[39:35], 1'b0, S7_0, C7_0); 
  Base_Adder_Carry BAC7_1(A[39:35], B[39:35], 1'b1, S7_1, C7_1);
  //MUX logic for carry select and sum select 
  assign {sum[39:35], C8} = C7? {S7_1, C7_1}:{S7_0, C7_0};
  //<-------------------  Partial Stage 9 -------------------------->\\ 
  Base_Adder_Carry BAC8_0(A[44:40], B[44:40], 1'b0, S8_0, C8_0); 
  Base_Adder_Carry BAC8_1(A[44:40], B[44:40], 1'b1, S8_1, C8_1);
  //MUX logic for carry select and sum select 
  assign {sum[44:40], C9} = C8? {S8_1, C8_1}:{S8_0, C8_0};
  //<-------------------  Partial Stage 10 -------------------------->\\ 
  Base_Adder_Carry BAC9_0(A[49:45], B[49:45], 1'b0, S9_0, C9_0); 
  Base_Adder_Carry BAC9_1(A[49:45], B[49:45], 1'b1, S9_1, C9_1);
  //MUX logic for carry select and sum select 
  assign {sum[49:45], C_out} = C9? {S9_1, C9_1}:{S9_0, C9_0};
endmodule

module csa_row (
  input  [49:0] A,
  input  [49:0] B,
  input  [49:0] C,
  output [49:0] sum,
  output [49:0] C_out
);
  genvar i;
  generate
    for (i = 0; i < 50; i = i + 1) begin : bit_gen
      assign sum[i] = A[i] ^ B[i] ^ C[i];
      assign C_out[i] = (A[i] & B[i]) | (B[i] & C[i]) | (A[i] & C[i]);
    end
  endgenerate
endmodule

module mult (
  input signed[24:0] A,
  input signed[24:0] B,
  input clk,
  output signed[49:0] prod 
);
  wire [24:0] A_mag, B_mag;
  wire unused_carry; 
  wire [49:0] prod_unsigned;
  
  //<----------- 2's Complementing -------------->
  wire sign = A[24] ^ B[24];
  assign A_mag = A[24] ? (~A+1'b1) : A; 
  assign B_mag = B[24] ? (~B+1'b1) : B; 
  
  //<----------- Partial products -------------->
  wire [49:0] pp [0:24];
  genvar i, j;
  generate
    for (i=0; i<25; i=i+1) begin:gen_pp
      for (j=0; j<i; j=j+1) begin:gen_lsb
        assign pp[i][j] = 1'b0;
      end
      for (j=0; j<25; j=j+1) begin:gen_bit
        assign pp[i][i+j] = A_mag[j] & B_mag[i];
      end
      for (j=i+25; j<50; j=j+1) begin:gen_msb
        assign pp[i][j] = 1'b0;
      end
    end
  endgenerate  
  //<------------------ STAGE 1: 25 -> 19 (6 CSAs) ------------------>
  wire [49:0] s1_sum[0:5], s1_car[0:5];
  csa_row csa1_0(pp[0], pp[1], pp[2], s1_sum[0], s1_car[0]);
  csa_row csa1_1(pp[3], pp[4], pp[5], s1_sum[1], s1_car[1]);
  csa_row csa1_2(pp[6], pp[7], pp[8], s1_sum[2], s1_car[2]);
  csa_row csa1_3(pp[9], pp[10], pp[11], s1_sum[3], s1_car[3]);
  csa_row csa1_4(pp[12], pp[13], pp[14], s1_sum[4], s1_car[4]);
  csa_row csa1_5(pp[15], pp[16], pp[17], s1_sum[5], s1_car[5]);  
  //PIPELINING
  reg [49:0] s1_sum_reg[0:5], s1_car_reg[0:5];
  reg [49:0] pp18_reg, pp19_reg, pp20_reg, pp21_reg, pp22_reg, pp23_reg, pp24_reg;
  reg sign_s1;
  integer k;  
  always @(posedge clk) begin
    for (k=0; k<6; k=k+1) begin
      s1_sum_reg[k]<= s1_sum[k];
      s1_car_reg[k]<= s1_car[k];
    end
    pp18_reg<= pp[18]; 
    pp19_reg<= pp[19]; 
    pp20_reg<= pp[20];
    pp21_reg<= pp[21]; 
    pp22_reg<= pp[22]; 
    pp23_reg<= pp[23];
    pp24_reg<= pp[24];
    sign_s1<= sign; 
  end
  //<------------------ STAGE 2: 19 -> 13 (6 CSAs) ------------------>
  wire [49:0] s2_sum[0:5], s2_car[0:5];
  csa_row csa2_0(s1_sum_reg[0], s1_sum_reg[1], s1_sum_reg[2], s2_sum[0], s2_car[0]);
  csa_row csa2_1(s1_sum_reg[3], s1_sum_reg[4], s1_sum_reg[5], s2_sum[1], s2_car[1]);
  csa_row csa2_2(s1_car_reg[0]<<1, s1_car_reg[1]<<1, s1_car_reg[2]<<1, s2_sum[2], s2_car[2]);
  csa_row csa2_3(s1_car_reg[3]<<1, s1_car_reg[4]<<1, s1_car_reg[5]<<1, s2_sum[3], s2_car[3]);
  csa_row csa2_4(pp18_reg, pp19_reg, pp20_reg, s2_sum[4], s2_car[4]);  
  csa_row csa2_5(pp21_reg, pp22_reg, pp23_reg, s2_sum[5], s2_car[5]);  
  //<------------------ STAGE 3: 13 -> 9 (4 CSAs) ------------------>
  wire [49:0] s3_sum[0:3], s3_car[0:3];
  csa_row csa3_0(s2_sum[0], s2_sum[1], s2_sum[2], s3_sum[0], s3_car[0]); 
  csa_row csa3_1(s2_sum[3], s2_sum[4], s2_sum[5], s3_sum[1], s3_car[1]);
  csa_row csa3_2(s2_car[0]<<1, s2_car[1]<<1, s2_car[2]<<1, s3_sum[2], s3_car[2]);
  csa_row csa3_3(s2_car[3]<<1, s2_car[4]<<1, s2_car[5]<<1, s3_sum[3], s3_car[3]);  
  //PIPELINE
  reg [49:0] s3_sum_reg[0:3], s3_car_reg[0:3];
  reg [49:0] pp24_reg2;
  reg sign_s2;  
  always @(posedge clk) begin
    for (k=0; k<4; k=k+1) begin
      s3_sum_reg[k]<= s3_sum[k];  
      s3_car_reg[k]<= s3_car[k];
    end
    pp24_reg2<= pp24_reg;
    sign_s2<= sign_s1;
  end  
  //<------------- STAGE 4: 9 -> 6 (3 CSAs) -------------->
  wire [49:0] s4_sum[0:2], s4_car[0:2];
  csa_row csa4_0(s3_sum_reg[0], s3_sum_reg[1], s3_sum_reg[2], s4_sum[0], s4_car[0]);
  csa_row csa4_1(s3_sum_reg[3], s3_car_reg[0]<<1, s3_car_reg[1]<<1, s4_sum[1], s4_car[1]);
  csa_row csa4_2(s3_car_reg[2]<<1, s3_car_reg[3]<<1, pp24_reg2, s4_sum[2], s4_car[2]);   
  //<------------ STAGE 5: 6 -> 4 (2 CSAs) --------------->
  wire [49:0] s5_sum[0:1], s5_car[0:1];
  csa_row csa5_0(s4_sum[0], s4_sum[1], s4_sum[2], s5_sum[0], s5_car[0]);
  csa_row csa5_1(s4_car[0]<<1, s4_car[1]<<1, s4_car[2]<<1, s5_sum[1], s5_car[1]);
  // PIPELINE
  reg [49:0] s5_sum_reg[0:1], s5_car_reg[0:1];
  reg sign_s3;  
  always @(posedge clk) begin
    s5_sum_reg[0] <= s5_sum[0];
    s5_sum_reg[1] <= s5_sum[1];
    s5_car_reg[0] <= s5_car[0];
    s5_car_reg[1] <= s5_car[1];
    sign_s3 <= sign_s2;
  end
  //<----------- STAGE 6: 4 -> 3 (1 CSA)  --------------->
  wire [49:0] s6_sum, s6_car;
  csa_row csa6_0(s5_sum_reg[0], s5_sum_reg[1], s5_car_reg[0]<<1, s6_sum, s6_car);                  
  //<----------- STAGE 7: 3 -> 2 (1 CSA) --------------->
  wire [49:0] final_sum, final_car;
  csa_row csa7_0(s6_sum, s6_car<<1, s5_car_reg[1]<<1, final_sum, final_car);  
  //<----------- FINAL ADDER --------------->
  CSA final_adder(final_sum, final_car<<1, prod_unsigned, unused_carry); 
  assign prod = sign_s2?(~prod_unsigned+1'b1):prod_unsigned; 
endmodule