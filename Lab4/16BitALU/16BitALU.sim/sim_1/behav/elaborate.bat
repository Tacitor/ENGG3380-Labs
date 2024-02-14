@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 0c468389cf534b0ca69925437eadf4ec -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot ALU_16Bit_test_behav xil_defaultlib.ALU_16Bit_test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
