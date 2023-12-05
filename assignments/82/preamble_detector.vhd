-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     preamble_detector
--
-- description:
--
--   This file implements a logic for detecting sequence of bits "101010010"
--   (known as Ethernet II preamble)
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

-----------------------------------------------------------------------------
--! @file
--! @brief Preamble detector circuit for sequence "10101010"
-----------------------------------------------------------------------------

--! Use standard library
library ieee;
--! Use logic elements
use ieee.std_logic_1164.all;

--! Preamble detector design element. The task of this element is to recognize bit pattern at the
--! serial input port ant acknowledge it by setting output port to logic one.
entity preamble_detector is
  port(
      clk_i   : in  std_logic;  --! Standard clock pulse input
      rst_i   : in  std_logic;  --! Asynchronous reset input
      data_i  : in  std_logic;  --! Serial one-bit input for data sequence
      match_o : out std_logic   --! One-bit output, set to logic one when correct sequence of bits is at the serial input
   );
end preamble_detector;

--! @brief Architecture definition of preamble detector.
--! @details Architecture designed using Moore FSM as requested in the task. It has usual logic divided in three segments
--! (register, next-state and output segment. FSM has 9 states, which is entered based on current register state.
architecture arch of preamble_detector is
  type t_sequence_states is (O, I, IO, IOI, IOIO, IOIOI, IOIOIO, IOIOIOI, IOIOIOIO);
  signal state_reg, state_next : t_sequence_states;
begin
  -- state register
  process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      state_reg <= O;
    elsif rising_edge(clk_i) then
      state_reg <= state_next;
    end if;
  end process;
  -- next-state logic
  process(data_i, state_reg)
  begin
    case state_reg is
      when O =>
        if data_i = '1' then
          state_next <= I;
        else
          state_next <= O;
        end if;
      when I =>
        if data_i = '0' then
          state_next <= IO;
        else
          state_next <= I;
        end if;
      when IO =>
        if data_i = '1' then
          state_next <= IOI;
        else
          state_next <= O;
        end if;
      when IOI =>
        if data_i = '0' then
          state_next <= IOIO;
        else
          state_next <= I;
        end if;
      when IOIO =>
        if data_i = '1' then
          state_next <= IOIOI;
        else
          state_next <= O;
        end if;
      when IOIOI =>
        if data_i = '0' then
          state_next <= IOIOIO;
        else
          state_next <= I;
        end if;
      when IOIOIO =>
        if data_i = '1' then
          state_next <= IOIOIOI;
        else
          state_next <= O;
        end if;
      when IOIOIOI =>
        if data_i = '0' then
          state_next <= IOIOIOIO;
        else
          state_next <= I;
        end if;
      when IOIOIOIO =>
        if data_i = '1' then
          state_next <= I;
        else
          state_next <= O;
        end if;
    end case;
  end process;
   --  output logic (Moore)
  match_o <= '1' when state_reg = IOIOIOIO else
             '0';
end arch;
