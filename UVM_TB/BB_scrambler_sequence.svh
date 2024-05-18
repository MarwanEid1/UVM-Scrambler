
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Sequence Object Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_reset_sequence extends uvm_sequence;

    `uvm_object_utils(BB_scrambler_reset_sequence)

    BB_scrambler_sequence_item sequence_item_h;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_reset_sequence");

        super.new(name);

        `uvm_info("BB_scrambler_reset_sequence", "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    task pre_body;

        `uvm_info("BB_scrambler_reset_sequence", "pre_body", UVM_HIGH)

        sequence_item_h = BB_scrambler_sequence_item::type_id::create("sequence_item_h");

    endtask: pre_body

    task body;

        `uvm_info("BB_scrambler_reset_sequence", "body", UVM_HIGH)

        // $display("------------------------------------------------------------------------------------------------------------------------------------");
        // $display("\n");
        // $display("************************************************************************************************************************************");
        // $display("Starting Reset Sequence:");
        // $display("************************************************************************************************************************************");

        start_item(sequence_item_h);

        sequence_item_h.reset_n = 1'b0;

        sequence_item_h.display_in("BB_scrambler_reset_sequence");

        finish_item(sequence_item_h);

    endtask: body

endclass: BB_scrambler_reset_sequence


class BB_scrambler_sequence extends uvm_sequence;

    `uvm_object_utils(BB_scrambler_sequence)

    BB_scrambler_sequence_item sequence_item_h;

    logic in_vector [1:50][1:1504];

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_sequence");

        super.new(name);

        `uvm_info("BB_scrambler_sequence", "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    task pre_body;

        `uvm_info("BB_scrambler_sequence", "pre_body", UVM_HIGH)

        sequence_item_h = BB_scrambler_sequence_item::type_id::create("sequence_item_h");

        $readmemb("Frame synchronous BaseBand scrambler input.txt", in_vector);

    endtask: pre_body

    task body;

        `uvm_info("BB_scrambler_sequence", "body", UVM_HIGH)

        // $display("------------------------------------------------------------------------------------------------------------------------------------");
        // $display("\n");
        // $display("************************************************************************************************************************************");
        // $display("Starting Sequence:");
        // $display("************************************************************************************************************************************");

        for (int i = 32'd1; i <= 32'd50; i++) begin
        
        // $display("");
        // $display("****************************************************************************************************");
        // $display("Packet no. %0d:", i);
        // $display("****************************************************************************************************");

            for (int j = 32'd1; j <= 32'd1504; j++) begin

            // $display("");
            // $display("********************************************************************************");
            // $display("Bit no. %0d:", j);
            // $display("********************************************************************************");

                start_item(sequence_item_h);

                sequence_item_h.reset_n = 1'b1;
                sequence_item_h.initial_state = 15'b100_1010_1000_0000;
                sequence_item_h.in_bit = in_vector[i][j];
                sequence_item_h.en = 1'b1;

                sequence_item_h.display_in("BB_scrambler_sequence");

                finish_item(sequence_item_h);

            end

            start_item(sequence_item_h);

            sequence_item_h.en = 1'b0;

            sequence_item_h.display_in("BB_scrambler_sequence");

            finish_item(sequence_item_h);

            repeat (1) begin

                start_item(sequence_item_h);

                finish_item(sequence_item_h);

            end

        end

    endtask: body

endclass: BB_scrambler_sequence
