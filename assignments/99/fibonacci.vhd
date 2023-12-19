-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     FIBONACCI SEQUENCE GENERATOR
--
-- description:
--
--   This file implements fibonacci sequence generator circuit.
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

entity fibonacci is
  port(
    clk_i   : in  std_logic;
    rst_i   : in  std_logic;
    start_i : in  std_logic;
    n_i     : in  std_logic_vector(5 downto 0);
    r_o     : out std_logic_vector(42 downto 0);
    ready_o : out std_logic
);
end fibonacci;

architecture arch of fibonacci is
  type t_state is (idle, load, first_op, op);

  signal state_reg  : t_state;
  signal state_next : t_state;
  signal count_0    : std_logic;
  signal n_reg      : unsigned(5 downto 0);
  signal n_next     : unsigned(5 downto 0);
  signal r_reg      : unsigned(42 downto 0);
  signal r_next     : unsigned(42 downto 0);
  signal prev1_reg  : unsigned(42 downto 0);
  signal prev1_next : unsigned(42 downto 0);
  signal prev2_reg  : unsigned(42 downto 0);
  signal prev2_next : unsigned(42 downto 0);
  signal res_out    : unsigned(42 downto 0);
  signal sub_out    : unsigned(5 downto 0);
begin
  -- control path: state register
  process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      state_reg <= idle;
    elsif rising_edge(clk_i) then
      state_reg <= state_next;
    end if;
  end process;

  -- control path: next-state
  process(state_reg, start_i, count_0)
  begin
    case state_reg is
      when idle =>
        if start_i = '1' then
          state_next <= load;
        else
          state_next <= idle;
        end if;
      when load =>
        if count_0 = '1' then
          state_next <= idle;
        else
          state_next <= first_op;
        end if;
      when first_op =>
        if count_0 = '1' then
          state_next <= idle;
        else
          state_next <= op;
        end if;
      when op =>
        if count_0 = '1' then
          state_next <= idle;
        else
          state_next <= op;
        end if;
    end case;
  end process;

  -- control path: output logic
  ready_o <= '1' when state_reg = idle else '0';
  -- data path: data register
  process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      prev1_reg <= (others => '0');
      prev2_reg <= (others => '0');
      n_reg     <= (others => '0');
      r_reg     <= (others => '0');
    elsif rising_edge(clk_i) then
      prev1_reg <= prev1_next;
      prev2_reg <= prev2_next;
      n_reg     <= n_next;
      r_reg     <= r_next;
    end if;
  end process;

  -- data path: routing multipexer
  process(state_reg, prev1_reg, n_reg, r_reg, prev2_reg, n_i, res_out, sub_out, start_i)
  begin
    case state_reg is
      when idle =>
        prev1_next <= prev1_reg;
        prev2_next <= prev2_reg;
        n_next     <= n_reg;
        if start_i = '1' then
          r_next <= (others => '0');
        else
          r_next <= r_reg;
        end if;
      when load =>
        prev1_next <= "0000000000000000000000000000000000000000001";
        prev2_next <= (others => '0');
        if n_i = "000000" then
          n_next <= (others => '0');
          r_next <= (others => '0');
        else
          n_next <= unsigned(n_i) - 1;
          r_next <= "0000000000000000000000000000000000000000001";
        end if;
      when first_op =>
        prev1_next <= "0000000000000000000000000000000000000000001";
        prev2_next <= "0000000000000000000000000000000000000000001";
        n_next     <= sub_out;
        r_next     <= "0000000000000000000000000000000000000000001";
      when op =>
        prev2_next <= prev1_reg;
        prev1_next <= r_reg;
        n_next     <= sub_out;
        r_next     <= res_out;
    end case;
  end process;

  -- data path: functional units
  res_out <= prev1_next + prev2_next;
  sub_out <= n_reg - 1;
  -- data path: status
  count_0 <= '1' when n_next = "000000" else '0';
  -- data path: output
  r_o <= std_logic_vector(r_reg);
end arch;
