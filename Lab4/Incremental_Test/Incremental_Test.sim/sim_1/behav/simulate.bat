@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim TestFile_behav -key {Behavioral:sim_1:Functional:TestFile} -tclbatch TestFile.tcl -view Q:/ENGG3380-Labs/Lab4/Incremental_Test/TestFile_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0