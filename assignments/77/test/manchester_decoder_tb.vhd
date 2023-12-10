-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "11/28/2023 12:42:35"
                                                            
-- Vhdl Test Bench template for design  :  manchester_decoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY manchester_decoder_vhd_tst IS
END manchester_decoder_vhd_tst;
ARCHITECTURE manchester_decoder_arch OF manchester_decoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_i : STD_LOGIC;
SIGNAL data_i : STD_LOGIC;
SIGNAL data_o : STD_LOGIC;
SIGNAL valid_o : STD_LOGIC;
COMPONENT manchester_decoder
	PORT (
	clk_i : IN STD_LOGIC;
	data_i : IN STD_LOGIC;
	data_o : OUT STD_LOGIC;
	valid_o : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : manchester_decoder
	PORT MAP (
-- list connections between master ports and signals
	clk_i => clk_i,
	data_i => data_i,
	data_o => data_o,
	valid_o => valid_o
	);
                                        
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
  clk_i <= '0';
  data_i <= '0';
  wait for 5 ns;
  clk_i <= '1';
  wait for 5 ns;
  clk_i <= '0';
  wait for 5 ns;
  assert(data_o = '0' and valid_o = '0') report "Error: idle state; Expected: data_o = 0, valid_o = 0; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: idle state.";
  data_i <= '0';
  clk_i <= '1';
  wait for 5 ns;
  data_i <= '1';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '0';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '1' and valid_o = '1') report "Error: transition from idle state to state one; Expected: data_o = 1, valid_o = 1; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from idle state to state one.";
  wait for 4 ns;
  data_i <= '1';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '1';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '1' and valid_o = '1') report "Error: transition from state one to state one; Expected: data_o = 1, valid_o = 1; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from state one to state one.";
  wait for 4 ns;
  data_i <= '0';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '1';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '0' and valid_o = '1') report "Error: transition from state one to state zero; Expected: data_o = 0, valid_o = 1; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from state one to state zero.";
  wait for 4 ns;
  data_i <= '0';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '0';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '0' and valid_o = '1') report "Error: transition from state zero to state zero; Expected: data_o = 0, valid_o = 1; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from state zero to state zero.";
  wait for 4 ns;
  data_i <= '1';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '0';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '1' and valid_o = '1') report "Error: transition from state zero to state one; Expected: data_o = 1, valid_o = 1; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from state zero to state one.";
  wait for 4 ns;
  data_i <= '0';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '1';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '0' and valid_o = '0') report "Error: transition from state one to idle state; Expected: data_o = 0, valid_o = 0; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from state one to idle state.";
  wait for 4 ns;
  data_i <= '0';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '0';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '0' and valid_o = '1') report "Error: transition from idle state to state zero; Expected: data_o = 0, valid_o = 1; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from idle state to state zero.";
  wait for 4 ns;
  data_i <= '0';
  clk_i <= '0';
  wait for 5 ns;
  data_i <= '0';
  clk_i <= '1';
  wait for 1 ns;
  assert(data_o = '0' and valid_o = '0') report "Error: transition from state zero to idle state; Expected: data_o = 0, valid_o = 0; Actual: data_o: " & std_logic'image(data_o) & ", valid_o : " & std_logic'image(valid_o) severity failure;
  report "Assertion successful: transition from state zero to idle state.";
WAIT;                                                        
END PROCESS always;                                          
END manchester_decoder_arch;
