
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Environment Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_env extends uvm_env;

    `uvm_component_utils(BB_scrambler_env)

    BB_scrambler_cfg_obj cfg_obj_h;

    BB_scrambler_agent agent_h;
    BB_scrambler_subscriber subscriber_h;
    BB_scrambler_scoreboard scoreboard_h;
    
    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_env", uvm_component parent = null);

        super.new(name, parent);

        `uvm_info("BB_scrambler_env", "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        `uvm_info("BB_scrambler_env", "build phase", UVM_HIGH)

        agent_h = BB_scrambler_agent::type_id::create("agent_h", this);
        subscriber_h = BB_scrambler_subscriber::type_id::create("subscriber_h", this);
        scoreboard_h = BB_scrambler_scoreboard::type_id::create("scoreboard_h", this);
        cfg_obj_h = BB_scrambler_cfg_obj::type_id::create("cfg_obj_h");

        if(!uvm_config_db # (BB_scrambler_cfg_obj) :: get(this, "", "cfg_obj_h", cfg_obj_h)) begin
            `uvm_error("NO_cfg_obj", {"Configuration Object must be set for: ", get_full_name(), ".cfg_obj_h"})
        end

        uvm_config_db # (BB_scrambler_cfg_obj) :: set(this, "agent_h", "cfg_obj_h", cfg_obj_h);

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ======================================== Connect Phase ========================================
    // ----------------------------------------------------------------------------------------------- */

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        `uvm_info("BB_scrambler_env", "connect phase", UVM_HIGH)

        agent_h.analysis_port.connect(scoreboard_h.analysis_imp);
        agent_h.analysis_port.connect(subscriber_h.analysis_export);
        
    endfunction: connect_phase

endclass: BB_scrambler_env
