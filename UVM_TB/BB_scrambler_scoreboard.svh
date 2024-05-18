
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Scoreboard Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(BB_scrambler_scoreboard)

    BB_scrambler_sequence_item sequence_item_h;

    uvm_analysis_imp # (BB_scrambler_sequence_item, BB_scrambler_scoreboard) analysis_imp;

    logic act_out_vector [1:50][1:1504];
    logic ref_out_vector [1:50][1:1504];

    int out_bit_error_cnt = 32'd0;
    int out_bit_total_cnt = 32'd0;

    int i = 32'd1;
    int j = 32'd1;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_scoreboard", uvm_component parent = null);

        super.new(name, parent);

        `uvm_info("BB_scrambler_scoreboard", "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        `uvm_info("BB_scrambler_scoreboard", "build phase", UVM_HIGH)

        sequence_item_h = BB_scrambler_sequence_item::type_id::create("sequence_item_h");

        analysis_imp = new("analysis_imp", this);

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ================================== Start of Simulation Phase ==================================
    // ----------------------------------------------------------------------------------------------- */

    function void start_of_simulation_phase(uvm_phase phase);

        super.start_of_simulation_phase(phase);

        `uvm_info("BB_scrambler_scoreboard", "start of simulation phase", UVM_HIGH)

        $readmemb("Frame synchronous BaseBand scrambler output.txt", ref_out_vector);

    endfunction: start_of_simulation_phase

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Check Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void check_phase(uvm_phase phase);

        super.check_phase(phase);

        `uvm_info("BB_scrambler_scoreboard", "check phase", UVM_HIGH)

        for (int m = 32'd1; m <= 32'd50; m++) begin

            for (int n = 32'd1; n <= 32'd1505; n++) begin

                if (n > 32'd1) begin

                    // $display("------------------------------------------------------------------------------------------------------------------------------------");
                    // `uvm_info(  "BB_scrambler_scoreboard",
                    //             $sformat("out_bit: Expected = %b, Actual = %b", ref_out_vector[m][n-1], act_out_vector[m][n]),
                    //             UVM_LOW)

                    out_bit_total_cnt++;

                    if (act_out_vector[m][n] != ref_out_vector[m][n-1]) begin
                        out_bit_error_cnt++;
                    end

                end

            end

        end

    endfunction: check_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Report Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void report_phase(uvm_phase phase);

        super.report_phase(phase);

        `uvm_info("BB_scrambler_scoreboard", "report phase", UVM_HIGH)

        if (out_bit_error_cnt > 32'd0) begin
            `uvm_error(  "BB_scrambler_scoreboard",
                        $sformatf("\nComparison Failure - %0d Incorrect Bits Out of %0d Compared Bits", out_bit_error_cnt, out_bit_total_cnt))
        end

        else begin
            $display("------------------------------------------------------------------------------------------------------------------------------------");
            `uvm_info(  "BB_scrambler_scoreboard",
                        $sformatf("\nComparison Success - %0d Incorrect Bits Out of %0d Compared Bits", out_bit_error_cnt, out_bit_total_cnt),
                        UVM_LOW)
            $display("------------------------------------------------------------------------------------------------------------------------------------");
        end

    endfunction: report_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void write(BB_scrambler_sequence_item t);

        sequence_item_h = t;

        sequence_item_h.display_out("BB_scrambler_scoreboard");

        if (sequence_item_h.reset_n == 1'b1 && sequence_item_h.en == 1'b1) begin

            act_out_vector[i][j] = sequence_item_h.out_bit;

            j++;

            if ((j % 32'd1505) == 32'd0) begin

                i++;
                j = 32'd1;
            
            end
                
        end

    endfunction: write

endclass: BB_scrambler_scoreboard
