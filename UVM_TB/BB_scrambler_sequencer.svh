
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Sequencer Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_sequencer extends uvm_sequencer # (BB_scrambler_sequence_item);

    `uvm_component_utils(BB_scrambler_sequencer)

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_sequencer", uvm_component parent = null);

        super.new(name, parent);

        `uvm_info("BB_scrambler_sequencer", "constructor", UVM_HIGH)
        
    endfunction: new

endclass: BB_scrambler_sequencer
