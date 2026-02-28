# A-25-bit-Dadda-Multiplier
A 25-bit Dadda Multiplier has been developed, with Carry Select Adder as the final output adder. The Dadda reduction is row-wise and as follows (25 -> 19 -> 13 -> 9 -> 6 -> 4 -> 3-> 2). It provides good performance to speed ratio and quite close to the Wallace tree mutliplier it self. 
The Carry select adder at the end is an implementation of a 50 bit bit CSLA; and divided into 10 Carry Lookahead adders of 5 bits each as the base adder to provide higher speed as a CSLA is provides more parallelism than the ripple carry Adder. 

It is pipelined across 3 stages to make it meet timing; however, it can be easily removed, ensure that the necessary changes are made in the Test Bench (remove the clock waits).

Code was created to be performed in Xilinx Vivado, but it is portable and can be easily used in any other platform. 
