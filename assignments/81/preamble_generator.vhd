-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     PREAMBLE GENERATOR
--
-- description:
--
--   This file implements a simple PREAMBLE logic.
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

entity preamble_generator is
  port (
  clk_i   : in  std_logic;
  rst_i   : in  std_logic;
  start_i : in  std_logic;
  data_o  : out std_logic
);
end preamble_generator;

architecture arch of preamble_generator is
  type t_state_type is (idle, zero, one);
  signal state_reg, state_next : t_state_type;
  signal data_next, data_buff_reg : std_logic;
begin

  -- state register
  process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      state_reg <= idle;
    elsif rising_edge(clk_i) then
      state_reg <= state_next;
    end if;
  end process;

  -- output buffer
  process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      data_buff_reg <= '0';
    elsif rising_edge(clk_i) then
      data_buff_reg <= data_next;
    end if;
  end process;

  -- next-state logic
  process(state_reg, start_i)
    variable count : natural range 0 to 8 := 0;
  begin
    case state_reg is
      when idle =>
        if start_i = '1' then
          state_next <= zero;
          count := 0;
        else
          state_next <= idle;
        end if;
      when zero =>
        if start_i = '1' then
          state_next <= zero;
          count := 0;
        else
          state_next <= one;
        end if;
      when one =>
        if start_i = '1' then
          state_next <= zero;
          count := 0;
        else
          state_next <= zero;
        end if;
    end case;

    if count = 8 then
      state_next <= idle;
      count := 0;
    end if;
    if state_next /= idle then
      count := count + 1;
    end if;

  end process;

  -- look-ahead output
  data_next <= '1' when state_next = one else
               '0';

  -- output
  data_o <= data_buff_reg;


end arch;
