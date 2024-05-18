
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Sequence Item Object Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_sequence_item extends uvm_sequence_item;

    `uvm_object_utils(BB_scrambler_sequence_item)

    // inputs
    logic           reset_n;
    logic [1:15]    initial_state;
    logic           in_bit;
    logic           en;

    // outputs
    logic           out_bit;
    logic           scmb_en;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_sequence_item");

        super.new(name);

        `uvm_info(name, "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void display_in(input string name = "");

        // $display("------------------------------------------------------------------------------------------------------------------------------------");
        
        `uvm_info(name,
                  $sformatf("\nTransaction Data:\nreset_n = %b, initial_state = %h, in_bit = %b, en = %b",
                  reset_n, initial_state, in_bit, en),
                  UVM_HIGH);

    endfunction: display_in

    function void display_out(input string name = "");
        
        // $display("------------------------------------------------------------------------------------------------------------------------------------");
        
        `uvm_info(name,
                  $sformatf("\nTransaction Data:\nreset_n = %b, initial_state = %h, in_bit = %b, en = %b, out_bit = %b, scmb_en = %b",
                  reset_n, initial_state, in_bit, en, out_bit, scmb_en),
                  UVM_HIGH);

    endfunction: display_out

endclass: BB_scrambler_sequence_item
