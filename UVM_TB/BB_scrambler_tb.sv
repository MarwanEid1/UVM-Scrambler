
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Tesebench Module
// ----------------------------------------------------------------------------------------------- */

`timescale 1ns/1ps

`define p_clk 10ns

module BB_scrambler_tb;

    import uvm_pkg::*;
    import BB_scrambler_pkg::*;

    BB_scrambler_if intf();

    initial begin
        uvm_config_db # (virtual BB_scrambler_if) :: set(null, "uvm_test_top", "vif", intf);
        run_test();
    end

    // clock generation
    initial intf.clk = 1'b0;
    always #(`p_clk/2) intf.clk = ~intf.clk;

    // DUT instantiation
    BB_scrambler DUT (
        .clk            (intf.clk),
        .reset_n        (intf.reset_n),
        .initial_state  (intf.initial_state),
        .in_bit         (intf.in_bit),
        .en             (intf.en),
        .out_bit        (intf.out_bit),
        .scmb_en        (intf.scmb_en)
    );

endmodule: BB_scrambler_tb
