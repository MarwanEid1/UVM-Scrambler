
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Test Component Class
// ----------------------------------------------------------------------------------------------- */

class BB_scrambler_test extends uvm_test;

    `uvm_component_utils(BB_scrambler_test)

    BB_scrambler_cfg_obj cfg_obj_h;

    virtual BB_scrambler_if vif;

    BB_scrambler_env env_h;
    BB_scrambler_reset_sequence reset_sequence_h;
    BB_scrambler_sequence sequence_h;

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Constructor =========================================
    // ----------------------------------------------------------------------------------------------- */

    function new(string name = "BB_scrambler_test", uvm_component parent = null);

        super.new(name, parent);

        `uvm_info("BB_scrambler_test", "constructor", UVM_HIGH)

    endfunction: new

    /* ----------------------------------------------------------------------------------------------- //
       ========================================= Build Phase =========================================
    // ----------------------------------------------------------------------------------------------- */

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        `uvm_info("BB_scrambler_test", "build phase", UVM_HIGH)

        env_h = BB_scrambler_env::type_id::create("env_h", this);
        reset_sequence_h = BB_scrambler_reset_sequence::type_id::create("reset_sequence_h");
        sequence_h = BB_scrambler_sequence::type_id::create("sequence_h");
        cfg_obj_h = BB_scrambler_cfg_obj::type_id::create("cfg_obj_h");

        if(!uvm_config_db # (virtual BB_scrambler_if) :: get(this, "", "vif", vif)) begin
            `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end

        cfg_obj_h.vif = vif;
        cfg_obj_h.is_active = UVM_ACTIVE;

        uvm_config_db # (BB_scrambler_cfg_obj) :: set(this, "env_h", "cfg_obj_h", cfg_obj_h);

    endfunction: build_phase

    /* ----------------------------------------------------------------------------------------------- //
       ================================== Start of Simulation Phase ==================================
    // ----------------------------------------------------------------------------------------------- */

  	function void start_of_simulation_phase(uvm_phase phase);

    	super.start_of_simulation_phase(phase);

    	if (uvm_report_enabled(UVM_MEDIUM)) begin

      		this.print();
      		factory.print();

    	end

  	endfunction

    /* ----------------------------------------------------------------------------------------------- //
       ========================================== Run Phase ==========================================
    // ----------------------------------------------------------------------------------------------- */

    task run_phase(uvm_phase phase);

        super.run_phase(phase);

        `uvm_info("BB_scrambler_test", "run phase", UVM_HIGH)

        phase.raise_objection(this, "Starting Sequences");

        reset_sequence_h.start(env_h.agent_h.sequencer_h);
        sequence_h.start(env_h.agent_h.sequencer_h);

        phase.drop_objection(this, "Finished Sequences");
        
    endtask: run_phase
    

endclass: BB_scrambler_test
