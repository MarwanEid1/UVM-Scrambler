
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Monitor Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_monitor extends uvm_monitor;

    `uvm_component_utils(BB_scrambler_monitor)

    virtual BB_scrambler_if vif;

    BB_scrambler_sequence_item sequence_item_h;

    uvm_analysis_port # (BB_scrambler_sequence_item) analysis_port;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_monitor", uvm_component parent = null);

        super.new(name, parent);
        
        `uvm_info("BB_scrambler_monitor", "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        `uvm_info("BB_scrambler_monitor", "build phase", UVM_HIGH)

        sequence_item_h = BB_scrambler_sequence_item::type_id::create("sequence_item_h");

        if(!uvm_config_db # (virtual BB_scrambler_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end

        analysis_port = new("analysis_port", this);

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ========================================== Run Phase ==========================================
    // ----------------------------------------------------------------------------------------------- */

    task run_phase(uvm_phase phase);

        super.run_phase(phase);

        `uvm_info("BB_scrambler_monitor", "run phase", UVM_HIGH)

        forever begin
            monitor();
            #1step;
            sequence_item_h.display_out("BB_scrambler_monitor");
            analysis_port.write(sequence_item_h);
        end

    endtask: run_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Other Methods ========================================
    // ----------------------------------------------------------------------------------------------- */

    task monitor();

        @ (posedge vif.clk);

        #1step

        // inputs
        sequence_item_h.reset_n         <= vif.reset_n;
        sequence_item_h.initial_state   <= vif.initial_state;
        sequence_item_h.in_bit          <= vif.in_bit;
        sequence_item_h.en              <= vif.en;

        // outputs
        sequence_item_h.out_bit         <= vif.out_bit;
        sequence_item_h.scmb_en         <= vif.scmb_en;

    endtask: monitor

endclass: BB_scrambler_monitor
