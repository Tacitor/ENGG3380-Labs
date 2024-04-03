@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto 51f36733ffb3419b85aead7a04405342 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot CPU_3380_Test_behav xil_defaultlib.CPU_3380_Test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
