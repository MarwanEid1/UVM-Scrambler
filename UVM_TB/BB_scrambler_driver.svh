
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Driver Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_driver extends uvm_driver # (BB_scrambler_sequence_item);

    `uvm_component_utils(BB_scrambler_driver)

    virtual BB_scrambler_if vif;

    BB_scrambler_sequence_item sequence_item_h;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_driver", uvm_component parent = null);

        super.new(name, parent);

        `uvm_info("BB_scrambler_driver", "constructor", UVM_HIGH)
        
    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        `uvm_info("BB_scrambler_driver", "build phase", UVM_HIGH)

        if(!uvm_config_db # (virtual BB_scrambler_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ========================================== Run Phase ==========================================
    // ----------------------------------------------------------------------------------------------- */

    task run_phase(uvm_phase phase);

        super.run_phase(phase);
        
        `uvm_info("BB_scrambler_driver", "run phase", UVM_HIGH)

        forever begin
            seq_item_port.get_next_item(sequence_item_h);
            sequence_item_h.display_in("BB_scrambler_driver");
            drive();
            seq_item_port.item_done();
        end

    endtask: run_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    task drive();

        vif.reset_n        <= sequence_item_h.reset_n;
        vif.initial_state   <= sequence_item_h.initial_state;
        vif.in_bit          <= sequence_item_h.in_bit;
        vif.en              <= sequence_item_h.en;

        @ (negedge vif.clk);

    endtask: drive

endclass: BB_scrambler_driver
