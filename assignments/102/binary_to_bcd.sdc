## Generated SDC file "binary_to_bcd.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

## DATE    "Wed Dec 27 18:08:25 2023"

##
## DEVICE  "5CSEMA5F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name clk_i -period 25 [get_ports {clk_i}]
create_clock -name clk_virt -period 25


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
 
derive_clock_uncertainty

#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -clock clk_virt -max 0.550 [get_ports {start_i}]
set_input_delay -clock clk_virt -min 0.350 [get_ports {start_i}]
set_input_delay -clock clk_virt -max 0.550 [get_ports {binary_i[*]}]
set_input_delay -clock clk_virt -min 0.350 [get_ports {binary_i[*]}]

#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -clock clk_virt -max 0.550 [get_ports {bcd1_o[*]}]
set_output_delay -clock clk_virt -min 0.350 [get_ports {bcd1_o[*]}]
set_output_delay -clock clk_virt -max 0.550 [get_ports {bcd2_o[*]}]
set_output_delay -clock clk_virt -min 0.350 [get_ports {bcd2_o[*]}]
set_output_delay -clock clk_virt -max 0.550 [get_ports {bcd3_o[*]}]
set_output_delay -clock clk_virt -min 0.350 [get_ports {bcd3_o[*]}]
set_output_delay -clock clk_virt -max 0.550 [get_ports {bcd4_o[*]}]
set_output_delay -clock clk_virt -min 0.350 [get_ports {bcd4_o[*]}]
set_output_delay -clock clk_virt -max 0.550 [get_ports {ready_o}]
set_output_delay -clock clk_virt -min 0.350 [get_ports {ready_o}]

#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_ports {rst_i}] -to [all_registers]

#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

set_location_assignment PIN_AF14 -to clk_i
set_location_assignment PIN_AC12 -to rst_i
set_location_assignment PIN_AB12 -to start_i
set_location_assignment PIN_V16 -to ready_o
set_location_assignment PIN_AC23 -to bcd1_o[3]
set_location_assignment PIN_AB21 -to bcd1_o[2]
set_location_assignment PIN_AA21 -to bcd1_o[1]
set_location_assignment PIN_AB17 -to bcd1_o[0]
set_location_assignment PIN_AF25 -to bcd2_o[3]
set_location_assignment PIN_AE24 -to bcd2_o[2]
set_location_assignment PIN_AE23 -to bcd2_o[1]
set_location_assignment PIN_AD24 -to bcd2_o[0]
set_location_assignment PIN_AH24 -to bcd3_o[3]
set_location_assignment PIN_AG26 -to bcd3_o[2]
set_location_assignment PIN_AG25 -to bcd3_o[1]
set_location_assignment PIN_AF26 -to bcd3_o[0]
set_location_assignment PIN_AK28 -to bcd4_o[3]
set_location_assignment PIN_AK29 -to bcd4_o[2]
set_location_assignment PIN_AJ27 -to bcd4_o[1]
set_location_assignment PIN_AH27 -to bcd4_o[0]
set_location_assignment PIN_AG16 -to binary_i[12]
set_location_assignment PIN_AH17 -to binary_i[11]
set_location_assignment PIN_AH18 -to binary_i[10]
set_location_assignment PIN_AJ16 -to binary_i[9]
set_location_assignment PIN_AJ17 -to binary_i[8]
set_location_assignment PIN_AJ19 -to binary_i[7]
set_location_assignment PIN_AK19 -to binary_i[6]
set_location_assignment PIN_AK18 -to binary_i[5]
set_location_assignment PIN_AK16 -to binary_i[4]
set_location_assignment PIN_Y18 -to binary_i[3]
set_location_assignment PIN_AD17 -to binary_i[2]
set_location_assignment PIN_Y17 -to binary_i[1]
set_location_assignment PIN_AC18 -to binary_i[0]