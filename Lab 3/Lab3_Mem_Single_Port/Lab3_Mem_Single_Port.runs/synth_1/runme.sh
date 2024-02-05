#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=C:/Xilinx/Vivado/2016.3/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2016.3/ids_lite/ISE/lib/nt64:C:/Xilinx/Vivado/2016.3/bin
else
  PATH=C:/Xilinx/Vivado/2016.3/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2016.3/ids_lite/ISE/lib/nt64:C:/Xilinx/Vivado/2016.3/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='C:/Users/Lukas/OneDrive/OneDrive - University of Guelph/Documents/University of Guelph/Sem 4/ENGG3380/Git/ENGG3380-Labs/Lab 3/Lab3_Mem_Single_Port/Lab3_Mem_Single_Port.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log lab2mem.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source lab2mem.tcl
