-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2022
-- https://github.com/knezicm/pds-2022/
-----------------------------------------------------------------------------
--
-- unit name:     four_bit_full_adder
--
-- description:
--
--   This file implements a full adder logic with 2 4-bit inputs.
--
-----------------------------------------------------------------------------
-- Copyright (c) 2022 Faculty of Electrical Engineering
-----------------------------------------------------------------------------
-- The MIT License
-----------------------------------------------------------------------------
-- Copyright 2022 Faculty of Electrical Engineering
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom
-- the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
-- THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE
-----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_full_adder is
    port (
			 i_A : in std_logic_vector(3 downto 0);
          i_B : in std_logic_vector(3 downto 0);
          i_C : in std_logic;
          o_SUM : out std_logic_vector(3 downto 0);
          o_C : out std_logic);
end four_bit_full_adder;

architecture four_bit_full_adder_arch of four_bit_full_adder is
signal sum : std_logic_vector(4 downto 0) := "00000";
signal in_A, in_B, in_C : std_logic_vector(4 downto 0);
begin
	in_A(3 downto 0) <= i_A;
	in_A(4) <= '0';
	in_B(3 downto 0) <= i_B;
	in_B(4) <= '0';
	in_C(0) <= i_C;
	in_C(4 downto 1) <= "0000";
	sum <= std_logic_vector(unsigned(in_A) + unsigned(in_B) + unsigned(in_C)); 
	with sum(4) select
	o_C <= '0' when '0',
			 '1' when others;
	o_SUM <= sum(3 downto 0);
end four_bit_full_adder_arch;
