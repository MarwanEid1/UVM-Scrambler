
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Subscriber Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_subscriber extends uvm_subscriber # (BB_scrambler_sequence_item);

    `uvm_component_utils(BB_scrambler_subscriber)

    BB_scrambler_sequence_item sequence_item_h;

    covergroup cvr_grp;

        out_bit_cp: coverpoint sequence_item_h.out_bit {
                bins zero = {1'b0};
                bins one = {1'b1};
        }

        scmb_en_cp: coverpoint sequence_item_h.scmb_en {
                bins zero = {1'b0};
                bins one = {1'b1};
        }

    endgroup: cvr_grp

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_subscriber", uvm_component parent = null);

        super.new(name, parent);

        `uvm_info("BB_scrambler_subscriber", "constructor", UVM_HIGH)

        cvr_grp = new();

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void write(BB_scrambler_sequence_item t);

        sequence_item_h = t;

        sequence_item_h.display_out("BB_scrambler_subscriber");

        cvr_grp.sample();
        
    endfunction: write

endclass: BB_scrambler_subscriber
