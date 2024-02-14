@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim ALU_16Bit_test_behav -key {Behavioral:sim_1:Functional:ALU_16Bit_test} -tclbatch ALU_16Bit_test.tcl -view Q:/ENGG3380-Labs/Lab4/16BitALU/ALU_16Bit_Simulation.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
