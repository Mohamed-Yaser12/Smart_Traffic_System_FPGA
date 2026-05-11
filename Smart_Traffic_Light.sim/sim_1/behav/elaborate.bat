@echo off
set xv_path=D:\\Vivado\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto ee8b5b7229f040428ee8195fec938d8a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot MainTB_behav xil_defaultlib.MainTB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
