@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 9d1be09701d84138a29cba5fbfe6284c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot CPU_3380_behav xil_defaultlib.CPU_3380 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
