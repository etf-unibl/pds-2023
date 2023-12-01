-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name: eight_bit_divider
--
-- description:
--
--   This file implements a simple EIGHT BIT DIVIDER logic.
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

entity eight_bit_divider is
  port (
  A_i : in  std_logic_vector(7 downto 0);
  B_i : in  std_logic_vector(7 downto 0);
  Q_o : out std_logic_vector(7 downto 0);
  R_o : out std_logic_vector(7 downto 0)
);
end eight_bit_divider;

architecture arch of eight_bit_divider is
begin

  calculate_division : process(A_i, B_i)
    variable a_temp, tmp, pom1, r_temp : std_logic_vector(7 downto 0);
  begin
    if B_i = "00000000" then
    Q_o <= "11111111";
    R_o <= "11111111";
  else
    a_temp := "00000000";
    r_temp := "00000000";
    tmp := "10000000";
    for i in 0 to 7 loop
      pom1 := "0000000" & A_i((7-i) downto (7-i));
      a_temp := std_logic_vector(unsigned(a_temp) or unsigned(pom1));
      if a_temp < B_i then
		  r_temp := a_temp;
		  a_temp := "00000000";
      else
        a_temp := std_logic_vector(unsigned(a_temp) - unsigned(B_i));
        r_temp := std_logic_vector(unsigned(r_temp) or unsigned(tmp));
		  a_temp := std_logic_vector(unsigned(r_temp) or unsigned(tmp));
      end if;
      tmp := '0' & tmp(7 downto 1);
      a_temp := a_temp(6 downto 0) & '0';
    end loop;
    a_temp := '0' & a_temp(7 downto 1);
    Q_o <= a_temp;
    R_o <= r_temp;
	 end if;
  end process calculate_division;

end architecture arch;
