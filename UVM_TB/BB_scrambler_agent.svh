
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Agent Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_agent extends uvm_agent;

    `uvm_component_utils(BB_scrambler_agent)

    BB_scrambler_cfg_obj cfg_obj_h;

    virtual BB_scrambler_if vif;

    BB_scrambler_sequencer sequencer_h;
    BB_scrambler_driver driver_h;
    BB_scrambler_monitor monitor_h;

    uvm_analysis_port # (BB_scrambler_sequence_item) analysis_port;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_agent", uvm_component parent = null);

        super.new(name, parent);

        `uvm_info("BB_scrambler_agent", "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        `uvm_info("BB_scrambler_agent", "build phase", UVM_HIGH)

        cfg_obj_h = BB_scrambler_cfg_obj::type_id::create("cfg_obj_h");

        if(!uvm_config_db # (BB_scrambler_cfg_obj) :: get(this, "", "cfg_obj_h", cfg_obj_h)) begin
            `uvm_error("NO_cfg_obj", {"Configuration Object must be set for: ", get_full_name(), ".cfg_obj_h"})
        end

        if (cfg_obj_h.is_active == UVM_ACTIVE) begin
            sequencer_h = BB_scrambler_sequencer::type_id::create("sequencer_h", this);
            driver_h = BB_scrambler_driver::type_id::create("driver_h", this);
        end

        monitor_h = BB_scrambler_monitor::type_id::create("monitor_h", this);

        if (cfg_obj_h.is_active == UVM_ACTIVE) begin
            uvm_config_db # (virtual BB_scrambler_if) :: set(this, "driver_h", "vif", cfg_obj_h.vif);
        end

        uvm_config_db # (virtual BB_scrambler_if) :: set(this, "monitor_h", "vif", cfg_obj_h.vif);

        analysis_port = new("analysis_port", this);

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Connect Phase ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        `uvm_info("BB_scrambler_agent", "connect phase", UVM_HIGH)

        if (cfg_obj_h.is_active == UVM_ACTIVE) begin
            driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        end

        monitor_h.analysis_port.connect(analysis_port);
        
    endfunction: connect_phase

endclass: BB_scrambler_agent
