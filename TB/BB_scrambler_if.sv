
/* ----------------------------------------------------------------------------------------------- //
Project Title: UVM-Based Functional Verification of Scrambler IP
Institution: University of Science and Technology, Zewail City
By: Marwan Eid - 201901246
Supervised by: Dr. Rania Hassan - Eng. Sherif Hosny - Eng. John Saber
File Description: Scrambler Interface
// ----------------------------------------------------------------------------------------------- */

interface BB_scrambler_if;

    // inputs
    logic           clk;
    logic           reset_n;
    logic [1:15]    initial_state;
    logic           in_bit;
    logic           en;

    // outputs
    logic           out_bit;
    logic           scmb_en;

endinterface: BB_scrambler_if
