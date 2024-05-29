#Makefile for  AHB2APB PROJECT 

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = VCS

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64


RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../ahb_master +incdir+../ahb_slave
SVTB2 = ../test/pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit mem_cov6;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit mem_cov7;run -all; exit"
VSIMBATCH8= -c -do  " log -r /* ;coverage save -onexit mem_cov8;run -all; exit"



help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                  								!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.  						!"
	@echo "! sv_cmp    	=>  Create library and compile the code.           						!"
	@echo "! run_test	=>  clean, compile & run the simulation for single_test in batch mode.		!" 
	@echo "! run_test1	=>  clean, compile & run the simulation for unspecified_test in batch mode.			!" 
	@echo "! run_test2	=>  clean, compile & run the simulation for wrap4_test in batch mode.			!"
	@echo "! run_test3	=>  clean, compile & run the simulation for incr4_test in batch mode.			!" 
	@echo "! run_test4	=>  clean, compile & run the simulation for wrap8_test in batch mode.		!" 
	@echo "! run_test5	=>  clean, compile & run the simulation for incr8_test in batch mode.			!" 
	@echo "! run_test6	=>  clean, compile & run the simulation for wrap16_test in batch mode.			!"
	@echo "! run_test7	=>  clean, compile & run the simulation for incr16_test in batch mode.			!"
	@echo "! view_wave1 =>  To view the waveform of single_test	    					!" 
	@echo "! view_wave2 =>  To view the waveform of unspecified_test	    						!" 
	@echo "! view_wave3 =>  To view the waveform of wrap4_test 	  						!" 
	@echo "! view_wave4 =>  To view the waveform of incr4_test   							!" 
	@echo "! view_wave5 =>  To view the waveform of wrap8_test	    					!" 
	@echo "! view_wave6 =>  To view the waveform of incr8_test	    						!" 
	@echo "! view_wave7 =>  To view the waveform of wrap16_test 	  						!" 
	@echo "! view_wave8 =>  To view the waveform of incr16_test   							!" 
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.		    				!"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.			!"
	@echo "! cov        =>  To open merged coverage report in html format.							!"
	@echo ====================================================================================================================

clean 	   : clean_$(SIMULATOR)
sv_cmp     : sv_cmp_$(SIMULATOR)
run_test   : run_test_$(SIMULATOR)
run_test1  : run_test1_$(SIMULATOR)
run_test2  : run_test2_$(SIMULATOR)
run_test3  : run_test3_$(SIMULATOR)
run_test4  : run_test4_$(SIMULATOR)
run_test5  : run_test5_$(SIMULATOR)
run_test6  : run_test6_$(SIMULATOR)
run_test7  : run_test7_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
view_wave5 : view_wave5_$(SIMULATOR)
view_wave6 : view_wave6_$(SIMULATOR)
view_wave7 : view_wave7_$(SIMULATOR)
view_wave8 : view_wave8_$(SIMULATOR)
regress    : regress_$(SIMULATOR)
report     : report_$(SIMULATOR)
cov        : cov_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) 	
	
run_test_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=single_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1
	
run_test1_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=unspecified_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2
	
run_test2_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=wrap4_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3
	
run_test3_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.top +UVM_TESTNAME=incr4_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4
	
run_test4_Questa: 
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test5.log  -sv_seed random  work.top +UVM_TESTNAME=wrap8_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5
	
run_test5_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave_file6.wlf -l test6.log  -sv_seed random  work.top +UVM_TESTNAME=incr8_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6
	
run_test6_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave_file7.wlf -l test7.log  -sv_seed random  work.top +UVM_TESTNAME=wrap16_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7
	
run_test7_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8)  -wlf wave_file8.wlf -l test8.log  -sv_seed random  work.top +UVM_TESTNAME=incr16_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8

view_wave1_Questa:
	vsim -view wave_file1.wlf
	
view_wave2_Questa:
	vsim -view wave_file2.wlf
	
view_wave3_Questa:
	vsim -view wave_file3.wlf
	
view_wave4_Questa:
	vsim -view wave_file4.wlf

view_wave5_Questa:
	vsim -view wave_file5.wlf
	
view_wave6_Questa:
	vsim -view wave_file6.wlf
	
view_wave7_Questa:
	vsim -view wave_file7.wlf
	
view_wave8_Questa:
	vsim -view wave_file8.wlf

report_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress_Questa: clean_Questa run_test_Questa run_test1_Questa run_test2_Questa run_test3_Questa run_test4_Questa run_test5_Questa run_test6_Questa run_test7_Questa report_Questa cov_Questa

cov_Questa:
	firefox covhtmlreport/index.html&
	
clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work
	clear

# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ns -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb  -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1) +define+UVM_REPORT_DISABLE_FILE_LINE
		      
run_test_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave1.fsdb -cm_dir ./mem_cov1 +ntb_random_seed_automatic +UVM_TESTNAME=single_test
	urg -dir mem_cov1.vdb -format both -report urgReport1
	
run_test1_VCS:	clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave2.fsdb -cm_dir ./mem_cov2 +ntb_random_seed_automatic +UVM_TESTNAME=unspecified_test 
	urg -dir mem_cov2.vdb -format both -report urgReport2
	
run_test2_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave3.fsdb -cm_dir ./mem_cov3 +ntb_random_seed_automatic +UVM_TESTNAME=wrap4_test 
	urg -dir mem_cov3.vdb -format both -report urgReport3
	
run_test3_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave4.fsdb -cm_dir ./mem_cov4 +ntb_random_seed_automatic +UVM_TESTNAME=incr4_test
	urg -dir mem_cov4.vdb -format both -report urgReport4

run_test4_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave5.fsdb -cm_dir ./mem_cov5 +ntb_random_seed_automatic +UVM_TESTNAME=wrap8_test
	urg -dir mem_cov5.vdb -format both -report urgReport5
	
run_test5_VCS:	clean  sv_cmp_VCS	
	./simv -a vcs.log +fsdbfile+wave6.fsdb -cm_dir ./mem_cov6 +ntb_random_seed_automatic +UVM_TESTNAME=incr8_test 
	urg -dir mem_cov6.vdb -format both -report urgReport6
	
run_test6_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave7.fsdb -cm_dir ./mem_cov7 +ntb_random_seed_automatic +UVM_TESTNAME=wrap16_test 
	urg -dir mem_cov7.vdb -format both -report urgReport7
	
run_test7_VCS:	clean  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave8.fsdb -cm_dir ./mem_cov8 +ntb_random_seed_automatic +UVM_TESTNAME=incr16_test
	urg -dir mem_cov8.vdb -format both -report urgReport8

	
view_wave1_VCS: 
	verdi -ssf wave1.fsdb
	
view_wave2_VCS: 
	verdi -ssf wave2.fsdb

view_wave3_VCS: 
	verdi -ssf wave3.fsdb

view_wave4_VCS: 
	verdi -ssf wave4.fsdb		
	
view_wave5_VCS: 
	verdi -ssf wave5.fsdb
	
view_wave6_VCS: 
	verdi -ssf wave6.fsdb

view_wave7_VCS: 
	verdi -ssf wave7.fsdb

view_wave8_VCS: 
	verdi -ssf wave8.fsdb		
	
report_VCS:
	urg -dir mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb mem_cov5.vdb mem_cov6.vdb mem_cov7.vdb mem_cov8.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_VCS: clean_VCS sv_cmp_VCS run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS run_test4_VCS run_test5_VCS run_test6_VCS run_test7_VCS report_VCS

cov_VCS:
	verdi -cov -covdir merged_dir.vdb

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
	clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#

