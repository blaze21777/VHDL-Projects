set type_of_sim compile_all

vlib work 
#vmap unisim /soft/mentor/modeltech/unisim
vmap work work

vcom FPGA2019/Lab04/mux_4to1.vhd 
vcom FPGA2019/Lab04/mux_4to1_tb.vhd

vsim work.and_gate
vsim work.and_gate_tb
vsim -voptargs=+acc work.mux_4to1_tb

set StdArithNoWarnings 1

echo "--COMPILATION IS OVER--"
add wave -r *
run 500ns
