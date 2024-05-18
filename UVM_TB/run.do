
vlog \
-permissive \
-f compile_files.f

vsim \
-c \
-displaymsgmode both \
-onfinish stop \
-voptargs=+acc \
+UVM_TESTNAME=BB_scrambler_test \
+UVM_VERBOSITY=UVM_MEDIUM \
+UVM_NO_RELNOTES \
work.BB_scrambler_tb

add wave -position insertpoint  \
sim:/BB_scrambler_tb/DUT/clk \
sim:/BB_scrambler_tb/DUT/reset_n \
sim:/BB_scrambler_tb/DUT/initial_state \
sim:/BB_scrambler_tb/DUT/in_bit \
sim:/BB_scrambler_tb/DUT/en \
sim:/BB_scrambler_tb/DUT/out_bit \
sim:/BB_scrambler_tb/DUT/scmb_en

run -all

wave zoom full

radix -binary -showbase
radix signal sim:/BB_scrambler_tb/DUT/initial_state hexadecimal -showbase
