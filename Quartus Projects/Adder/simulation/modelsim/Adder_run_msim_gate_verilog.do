transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Adder.vo}

vlog -vlog01compat -work work +incdir+E:/Quartus\ Projects/Adder {E:/Quartus Projects/Adder/adder_float_tb_1.v}

vsim -t 1ps -L altera_ver -L altera_lnsim_ver -L cyclonev_ver -L lpm_ver -L sgate_ver -L cyclonev_hssi_ver -L altera_mf_ver -L cyclonev_pcie_hip_ver -L gate_work -L work -voptargs="+acc"  adder_float_tb_1

add wave *
view structure
view signals
run -all
