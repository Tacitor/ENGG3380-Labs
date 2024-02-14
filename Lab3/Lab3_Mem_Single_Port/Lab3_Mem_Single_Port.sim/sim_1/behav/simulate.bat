@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim RAM_TB_behav -key {Behavioral:sim_1:Functional:RAM_TB} -tclbatch RAM_TB.tcl -view D:/ENGG_3380/Labs/Lab3/Lab3_Mem_Single_Port/RAM_TB_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
