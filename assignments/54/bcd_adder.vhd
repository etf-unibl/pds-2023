-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     BCD_ADDER
--
-- description:
--
--   This file implements a simple BCD ADDER logic.
--
-----------------------------------------------------------------------------
-- Copyright (c) 2023 Faculty of Electrical Engineering
-----------------------------------------------------------------------------
-- The MIT License
-----------------------------------------------------------------------------
-- Copyright 2023 Faculty of Electrical Engineering
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

entity bcd_adder is
  port (
  A_i   : in  std_logic_vector(11 downto 0);
  B_i   : in  std_logic_vector(11 downto 0);
  SUM_o : out std_logic_vector(15 downto 0)
);
end bcd_adder;

architecture arch of bcd_adder is
  signal temp_SUM : unsigned(std_logic_vector(15 downto 0));
begin
  -- Proces
  process(A_i, B_i)
  begin
    temp_SUM <= (others => '0');
    temp_SUM(3 downto 0) <= unsigned(A_i(3 downto 0)) + unsigned(B_i(3 downto 0));
    temp_SUM(7 downto 4) <= unsigned(A_i(7 downto 4)) + unsigned(B_i(7 downto 4));
    temp_SUM(11 downto 8) <= unsigned(A_i(11 downto 8)) + unsigned(B_i(11 downto 8));
    for i in 0 to 2 loop
      if unsigned(temp_SUM(i * 4 + 3 downto i * 4)) > "1001" then
        temp_SUM(i * 4 + 3 downto i * 4) <= unsigned(temp_SUM(i * 4 + 3 downto i * 4)) + "0110";
      end if;
    end loop;
  end process;
  SUM_o <= std_logic_vector(temp_SUM);
end arch;
