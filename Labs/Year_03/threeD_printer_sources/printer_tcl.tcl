set type_of_sim compile_all

# Create the work library
vlib work 
#vmap unisim /soft/mentor/modeltech/unisim
vmap work work

# Compile all of the work files
vcom threeD_printer_sources/loop_counter.vhd 
vcom threeD_printer_sources/serial_adder.vhd
vcom threeD_printer_sources/threeD_printer.vhd
vcom threeD_printer_sources/threeD_printer_tb.vhd

# Start simulation
vsim work.threeD_printer_tb
#vsim -voptargs=+acc work.mux_4to1_tb

set StdArithNoWarnings 1
set StdNumericStdNoWarnigns 1

echo "--COMPILATION IS OVER--"
add wave -r *
run 500ns
