connect -url tcp:127.0.0.1:3121
source G:/projects_ext/validation_study/openamp/openamp.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS2 210249854941"} -index 0
rst -system
after 3000
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS2 210249854941"} -index 0
loadhw -hw G:/projects_ext/validation_study/openamp/openamp.sdk/design_1_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS2 210249854941"} -index 0
ps7_init
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS2 210249854941"} -index 0
dow -data G:/projects_ext/validation_study/openamp/openamp.sdk/slave/Debug/slave.elf 0x10000000
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS2 210249854941"} -index 0
dow G:/projects_ext/validation_study/openamp/openamp.sdk/master/Debug/master.elf
configparams force-mem-access 0
bpadd -addr &main
