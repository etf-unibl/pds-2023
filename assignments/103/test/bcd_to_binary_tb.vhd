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
-- Generated on "12/24/2023 20:36:15"
                                                            
-- Vhdl Test Bench template for design  :  bcd_to_binary
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;    
USE ieee.numeric_std.all;                            

ENTITY bcd_to_binary_vhd_tst IS
END bcd_to_binary_vhd_tst;
ARCHITECTURE bcd_to_binary_arch OF bcd_to_binary_vhd_tst IS
-- constants     
constant T : time := 20 ns;                                            
-- signals                                                   
SIGNAL bcd1_i : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL bcd2_i : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL binary_o : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL clk_i : STD_LOGIC;
SIGNAL ready_o : STD_LOGIC;
SIGNAL rst_i : STD_LOGIC;
SIGNAL start_i : STD_LOGIC;
COMPONENT bcd_to_binary
	PORT (
	bcd1_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	bcd2_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	binary_o : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	clk_i : IN STD_LOGIC;
	ready_o : OUT STD_LOGIC;
	rst_i : IN STD_LOGIC;
	start_i : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : bcd_to_binary
	PORT MAP (
-- list connections between master ports and signals
	bcd1_i => bcd1_i,
	bcd2_i => bcd2_i,
	binary_o => binary_o,
	clk_i => clk_i,
	ready_o => ready_o,
	rst_i => rst_i,
	start_i => start_i
	);
                                          
process
begin
	for i in 1 to 400 loop
		clk_i <= '1';
		wait for T/2;
		clk_i <= '0';
		wait for T/2;
	end loop;
	wait;
end process;
                                 
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list 
  rst_i <= '0';
  bcd1_i <= "0000";
  bcd2_i <= "0000";
  start_i <= '1'; 
  for i in 0 to 9 loop
    for j in 0 to 9 loop
      start_i <= '1';
      bcd1_i <= std_logic_vector(to_unsigned(i, 4));
		bcd2_i <= std_logic_vector(to_unsigned(j, 4));
		wait for 3*T;
      start_i<= '0';
      wait for T;
      assert(binary_o = std_logic_vector(to_unsigned(i * 10 + j, 7))) report "Error; Expected: " & integer'image(to_integer(to_unsigned(i * 10 + j, 7))) & "; Actual: " & integer'image(to_integer(unsigned(binary_o))) severity error;
	 end loop;
  end loop;
WAIT;                                                        
END PROCESS always; 
END bcd_to_binary_arch;