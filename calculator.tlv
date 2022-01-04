\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/LF-Building-a-RISC-V-CPU-Core/main/lib/calc_viz.tlv'])
   /* verilator lint_on WIDTH */
\TLV
   $reset = *reset;

   // Flop the $out signal and input it into $val1
   $val1[31:0] = >>1$out;
   // Get randomized data for tests
   $val2[31:0] = {28'b0, $val2_rand[3:0]};
   
   // Perform the calculations
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   
   // Select the $out signal from the calculated options
   // This is a mux with a reset signal
   $out[31:0] =
      ($reset == 1'b1) ? 32'b0 :
      ($op[1:0] == 2'b11) ? $quot[31:0] :
      ($op[1:0] == 2'b10) ? $prod[31:0] :
      ($op[1:0] == 2'b01) ? $diff[31:0] :
      $sum[31:0];

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   
   m4+calc_viz()
\SV
   endmodule
