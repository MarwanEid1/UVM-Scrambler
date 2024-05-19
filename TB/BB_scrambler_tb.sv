
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Tesebench Module
// ----------------------------------------------------------------------------------------------- */

`timescale 1ns/1ps

module BB_scrambler_tb;

    // internal signals and variables
    reg in_vector [1:50][1:1504];
    reg out_vector [1:50][1:1504];
    integer correct_cnt = 32'b0;
    integer incorrect_cnt = 32'b0;

    // interface instantiation
    BB_scrambler_if intf();

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

    // clock generation
    initial intf.clk = 1'b0;
    always #5 intf.clk = ~intf.clk;

    // reset task
    task reset();
        intf.reset_n = 1'b0;
        @ (negedge intf.clk);
        intf.reset_n = 1'b1;
    endtask: reset

    // read files in memory
    initial begin
        $readmemb("Frame synchronous BaseBand scrambler input.txt", in_vector);
        $readmemb("Frame synchronous BaseBand scrambler output.txt", out_vector);
    end

    // initial values
    initial begin
        repeat (2) @ (negedge intf.clk);
        intf.initial_state = 15'b100_1010_1000_0000;
        intf.en = 1'b1;
    end

    // stimulus generation
    initial begin
        reset();
        for (int i = 32'd1; i <= 32'd50; i++) begin
            for (int j = 32'd1; j <= 32'd1505; j++) begin
                @ (negedge intf.clk);
                intf.en = 1'b1;
                intf.in_bit = in_vector[i][j];
                @ (posedge intf.clk);
                #1step;
                if (j > 1) begin
                    if (intf.out_bit == out_vector [i][j-1]) begin
                        correct_cnt++;
                    end
                    else begin
                        $display("-------------------------------------------------------------------------");
                        $display("Output is incorrect at time %0t", $time);
                        $display("Expected output = %b, Actual output = %b", out_vector[i][j-1], intf.out_bit);
                        incorrect_cnt++;
                    end
                end
            end
            intf.en = 1'b0;
            repeat (3) @ (negedge intf.clk);
        end
        $display("-------------------------------------------------------------------------");
        $display("Number of correct outputs = %0d", correct_cnt);
        $display("Number of incorrect outputs = %0d", incorrect_cnt);
        $display("-------------------------------------------------------------------------");
        $stop;
    end

endmodule: BB_scrambler_tb
