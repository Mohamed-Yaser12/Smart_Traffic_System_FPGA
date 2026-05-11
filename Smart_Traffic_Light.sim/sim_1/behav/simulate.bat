@echo off
set xv_path=D:\\Vivado\\Vivado\\2016.4\\bin
call %xv_path%/xsim MainTB_behav -key {Behavioral:sim_1:Functional:MainTB} -tclbatch MainTB.tcl -view C:/Users/Eng.Mohamed/Desktop/DSD_Project_Final_Version/DSD_Project_Final_Version.srcs/sim_1/imports/Desktop/MainTB_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
