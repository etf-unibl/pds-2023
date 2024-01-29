-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     BINARY_TO_BCD
--
-- description:
--
--   This file implements convertor from 13-bit binary value to BCD 4-digits number.
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
--! @brief binary to bcd converter
-----------------------------------------------------------------------------

--! Use standard library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! Detailed description of converter design unit
--! 13bit data value to be converted
--! 4 4bit data outputs representing single BCD digit
--! status bit : ready_o
entity binary_to_bcd is
  port(
    clk_i    : in  std_logic;
    rst_i    : in  std_logic;
    start_i  : in  std_logic;
    binary_i : in  std_logic_vector(12 downto 0);
    bcd1_o   : out std_logic_vector(3 downto 0);
    bcd2_o   : out std_logic_vector(3 downto 0);
    bcd3_o   : out std_logic_vector(3 downto 0);
    bcd4_o   : out std_logic_vector(3 downto 0);
    ready_o  : out std_logic
  );
end binary_to_bcd;

--! @brief Architecture definition of the converter
architecture arch of binary_to_bcd is
  constant c_WIDTH : integer := 13;
  type t_state_type is (idle, load, op);
  signal state_reg, state_next                      : t_state_type;
  signal data_reg, data_next                        : unsigned(c_WIDTH-1 downto 0);
  signal bcd1_reg, bcd2_reg, bcd3_reg, bcd4_reg     : unsigned(3 downto 0);
  signal bcd1_next, bcd2_next, bcd3_next, bcd4_next : unsigned(3 downto 0);
  signal bcd1_temp, bcd2_temp, bcd3_temp, bcd4_temp : unsigned(3 downto 0);
begin
  --! control path: state register
  p1 : process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      state_reg <= idle;
    elsif rising_edge(clk_i) then
      state_reg <= state_next;
    end if;
  end process p1;

  --! control path: next-state
  p2 : process(state_reg, start_i)
  begin
    case state_reg is
      when idle =>
        if start_i = '1' then
          state_next <= load;
        else
          state_next <= idle;
        end if;
      when load =>
        state_next <= op;
      when op =>
        state_next <= idle;
    end case;
  end process p2;

  --! control path: output logic
  ready_o <= '1' when state_reg = idle else '0';

  --! data path: data register
  p3 : process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      data_reg <= (others => '0');
      bcd1_reg <= (others => '0');
      bcd2_reg <= (others => '0');
      bcd3_reg <= (others => '0');
      bcd4_reg <= (others => '0');
    elsif rising_edge(clk_i) then
      data_reg <= data_next;
      bcd1_reg <= bcd1_next;
      bcd2_reg <= bcd2_next;
      bcd3_reg <= bcd3_next;
      bcd4_reg <= bcd4_next;
    end if;
  end process p3;

  --! data path: routing multipexer
  p4 : process(state_reg, binary_i, start_i, data_reg, bcd1_reg, bcd2_reg, bcd3_reg, bcd4_reg,
  bcd1_temp, bcd2_temp, bcd3_temp, bcd4_temp)
  begin
    case state_reg is
      when idle =>
        if start_i = '1' then
          data_next <= unsigned(binary_i);
          bcd1_next <= bcd1_reg;
          bcd2_next <= bcd2_reg;
          bcd3_next <= bcd3_reg;
          bcd4_next <= bcd4_reg;
        else
          data_next <= data_reg; --! zadrzavanje starog stanja
          bcd1_next <= bcd1_reg; --! za sve registre
          bcd2_next <= bcd2_reg;
          bcd3_next <= bcd3_reg;
          bcd4_next <= bcd4_reg;
        end if;
      when load =>
        data_next <= data_reg;
        bcd1_next <= bcd1_temp;
        bcd2_next <= bcd2_temp;
        bcd3_next <= bcd3_temp;
        bcd4_next <= bcd4_temp;
      when op =>
        data_next <= data_reg;
        bcd1_next <= bcd1_reg;
        bcd2_next <= bcd2_reg;
        bcd3_next <= bcd3_reg;
        bcd4_next <= bcd4_reg;
    end case;
  end process p4;

  --! data path: functional units
  bcd4_temp <= to_unsigned(to_integer(data_next) mod 10,bcd1_temp'length);
  bcd3_temp <= to_unsigned((to_integer(data_next)/10) mod 10,bcd2_temp'length);
  bcd2_temp <= to_unsigned((to_integer(data_next)/100) mod 10,bcd3_temp'length);
  bcd1_temp <= to_unsigned(to_integer(data_next)/1000,bcd4_temp'length);

  --! data path: output
  bcd1_o <= std_logic_vector(bcd1_reg);
  bcd2_o <= std_logic_vector(bcd2_reg);
  bcd3_o <= std_logic_vector(bcd3_reg);
  bcd4_o <= std_logic_vector(bcd4_reg);
end arch;
