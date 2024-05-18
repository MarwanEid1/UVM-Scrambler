
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Package
// ----------------------------------------------------------------------------------------------- */

package BB_scrambler_pkg;

    import uvm_pkg::*;

    `include "uvm_macros.svh"

    `include "BB_scrambler_cfg_obj.svh"
    `include "BB_scrambler_sequence_item.svh"
    `include "BB_scrambler_sequence.svh"
    `include "BB_scrambler_sequencer.svh"
    `include "BB_scrambler_driver.svh"
    `include "BB_scrambler_monitor.svh"
    `include "BB_scrambler_agent.svh"
    `include "BB_scrambler_subscriber.svh"
    `include "BB_scrambler_scoreboard.svh"
    `include "BB_scrambler_env.svh"
    `include "BB_scrambler_test.svh"
    
endpackage: BB_scrambler_pkg
