@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 514ca19ce5ea44808989b08f9f98796c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot ALU_Test_behav xil_defaultlib.ALU_Test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
