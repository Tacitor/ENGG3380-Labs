@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto d46453b4c6c947e59068d40ed108e862 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot RAM_TB_behav xil_defaultlib.RAM_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
