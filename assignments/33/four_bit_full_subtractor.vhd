-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023
-----------------------------------------------------------------------------
--
-- unit name:     four_bit_full_subtractor
--
-- description:
--
--   This file implements a full subtractor logic with 2 4-bit inputs.
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

entity four_bit_full_subtractor is
    port (
		i_A : in std_logic_vector(3 downto 0);
      i_B : in std_logic_vector(3 downto 0);
      i_C : in std_logic;
      o_SUB : out std_logic_vector(3 downto 0);
      o_C : out std_logic
	);
end four_bit_full_subtractor;

architecture four_bit_full_subtractor_arch of four_bit_full_subtractor is

component one_bit_full_subtractor is
port(
	a : in std_logic;
	b : in std_logic;
	b_in : in std_logic;
	d : out std_logic;
	b_out : out std_logic
);
end component;

signal c: std_logic_vector(3 downto 0);
begin
u1 : one_bit_full_subtractor port map(a => i_A(0), b => i_B(0), b_in => i_C, d => o_SUB(0), b_out => c(0));
u2 : one_bit_full_subtractor port map(a => i_A(1), b => i_B(1), b_in => c(0), d => o_SUB(1), b_out => c(1));
u3 : one_bit_full_subtractor port map(a => i_A(2), b => i_B(2), b_in => c(1), d => o_SUB(2), b_out => c(2));
u4 : one_bit_full_subtractor port map(a => i_A(3), b => i_B(3), b_in => c(2), d => o_SUB(3), b_out => o_C);

end four_bit_full_subtractor_arch;