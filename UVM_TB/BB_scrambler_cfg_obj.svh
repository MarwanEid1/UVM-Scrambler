
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Configuration Object Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_cfg_obj extends uvm_object;

    `uvm_object_utils(BB_scrambler_cfg_obj)

    virtual BB_scrambler_if vif;

    uvm_active_passive_enum is_active;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_cfg_obj");

        super.new(name);

        `uvm_info("BB_scrambler_cfg_obj", "constructor", UVM_HIGH)

    endfunction: new

endclass: BB_scrambler_cfg_obj
