-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     manchester_decoder
--
-- description:
--
--   This file implements logic that decodes manchester code at it's output.
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

-------------------------------------------------------
--! @manchester_decoder.vhd
--! @brief Decoder of manchester code
-------------------------------------------------------

--! Use standard library
library ieee;
--! Use logic elements
use ieee.std_logic_1164.all;

--! Ports of manchester_decoder entity:
--! clk_i - input clock signal
--! data_i - input port for coded data
--! data_o - output port for decoded data
--! valid_o - port that displays 0 if there is no coded data at the input
entity manchester_decoder is
  port (
  clk_i   : in  std_logic;
  data_i  : in  std_logic;
  data_o  : out std_logic;
  valid_o : out std_logic
);
end manchester_decoder;

--! @brief Architecture definition of the Manchester decoder
--! @details Architecture consists of 3 processes: 
--! One for the sequential part, i.e. the current state updates
--! when there is a rising edge of the clock signal;
--! One for the next state logic, where the input is the data_i pin,
--! and the output goes into the state register;
--! The last process is for the state register;
architecture arch of manchester_decoder is
  type t_state is
    (idle, a1, a0, b1, b0);
  signal state_reg : t_state;
  signal next_reg : t_state := a0;
begin
  -- sequential part
  process(clk_i)
  begin
    if rising_edge(clk_i) then
      state_reg <= next_reg;
    end if;
  end process;
  -- next state logic
  process(data_i, clk_i, state_reg)
  begin
    if rising_edge(clk_i) then
      case state_reg is
        when idle => 
          if  data_i = '0' then
            next_reg <= a0;
          else
            next_reg <= a1;
          end if;
        when a0 =>
          if data_i = '0' then
            next_reg <= idle;
          else
            next_reg <= b1;
          end if;
        when a1 =>
          if data_i = '0' then
            next_reg <= b0;
          else
            next_reg <= idle;
          end if;
        when others =>
          if  data_i = '0' then
            next_reg <= a0;
          else
            next_reg <= a1;
          end if;
      end case;
    end if;
  end process;
  -- output logic
  process(state_reg)
  begin
    case state_reg is
      when idle =>
        data_o <= '0';
        valid_o <= '0';
      when a0 =>
      when a1 =>
      when b1 =>
        data_o <= '1';
        valid_o <= '1';
      when b0 =>
        data_o <= '0';
        valid_o <= '1';
    end case;
  end process;
end arch;
