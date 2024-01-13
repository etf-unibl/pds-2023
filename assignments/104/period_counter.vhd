-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     period_counter
--
-- description:
--
--   This file implements a simple period_counter.
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

 --! brief Entity for the period counter.
 --!details This entity represents a simple period counter that counts clock cycles.
entity period_counter is
  port(
    clk_i    : in  std_logic;          --! Clock input
    rst_i    : in  std_logic;          --! Reset input
    period_i : in  std_logic;           --! Period input signal
    period_o : out unsigned (9 downto 0)  --! Output period count
  );
end period_counter;

 --! brief Architecture for the period counter.
 --! This architecture implements a period counter that counts clock cycles between rising edges
 --! of the period input signal. It outputs the count in the 'period_o' signal.
architecture arch of period_counter is
  --! Counters for current and previous values.
  signal current_count, prev_count : unsigned (9 downto 0) := (others => '0');
begin

   --! brief Clock counting process.
   --! This process increments the 'current_count' on each rising edge of the clock.
   --! It resets the count to zero on a reset signal.
  process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      current_count <= (others => '0');
    elsif rising_edge (clk_i) then
      current_count <= current_count + 1;
    end if;
  end process;

  --! brief Period counting process.
  --! This process calculates the period by comparing the current and previous counts.
  --! It updates 'period_o' on each rising edge of the 'period_i' input signal.
  process (period_i, rst_i)
  begin
    if rst_i = '1' then
      prev_count <= (others => '0');
    elsif rising_edge (period_i) then
      if prev_count < current_count then
        period_o <= current_count - prev_count;
      elsif prev_count > current_count then
        period_o <= "1111111111" - prev_count + current_count;
      else
        period_o <= (others => '0');
      end if;
      prev_count <= current_count;
    end if;
  end process;
end arch;
