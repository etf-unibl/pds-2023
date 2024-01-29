-----------------------------------------------------------------------------
-- Faculty of Electrical Engineering
-- PDS 2023
-- https://github.com/etf-unibl/pds-2023/
-----------------------------------------------------------------------------
--
-- unit name:     BINARY_TO_BCD_TB
--
-- description:
--
--   This file represents test bench for BINARY_TO_BCD design unit.
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
--! @brief test bench for binary to bcd converter
-----------------------------------------------------------------------------

--! Use standard library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! @brief empty entity definition
entity binary_to_bcd_tb is
end binary_to_bcd_tb;

--! @brief Testing functionality of binary_to_bcd design entity
architecture arch of binary_to_bcd_tb is
  signal clk_in     : std_logic := '0';
  signal rst_in     : std_logic := '0';
  signal start_in   : std_logic := '1';
  signal binary_in  : std_logic_vector(12 downto 0) := "0000000000000";
  signal bcd1_out   : std_logic_vector(3 downto 0);
  signal bcd2_out   : std_logic_vector(3 downto 0);
  signal bcd3_out   : std_logic_vector(3 downto 0);
  signal bcd4_out   : std_logic_vector(3 downto 0);
  signal ready_out  : std_logic;

  component binary_to_bcd is
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
  end component;
begin
  i1 : binary_to_bcd port map(
    clk_i    => clk_in,
    rst_i    => rst_in,
    start_i  => start_in,
    binary_i => binary_in,
    bcd1_o   => bcd1_out,
    bcd2_o   => bcd2_out,
    bcd3_o   => bcd3_out,
    bcd4_o   => bcd4_out,
    ready_o  => ready_out
  );
  l : process
  begin
    rst_in <= '1';
    wait for 200 ns;
    if bcd4_out = "0000" and bcd3_out = "0000" and bcd2_out = "0000" and bcd1_out = "0000" then
      report "OK : rst_i = 0 , ALL OUTPUTS=0 " severity note;
    else
      report "ERROR : rst_i = 0 , EXPECTED ALL OUTPUTS = 0 BUT GOT : " &
      "bcd1_o = " & std_logic'image(bcd1_out(3)) & std_logic'image(bcd1_out(2)) &
      std_logic'image(bcd1_out(1)) & std_logic'image(bcd1_out(0)) &
      "bcd2_o = " & std_logic'image(bcd2_out(3)) & std_logic'image(bcd2_out(2)) &
      std_logic'image(bcd2_out(1)) & std_logic'image(bcd2_out(0)) &
      "bcd3_o = " & std_logic'image(bcd3_out(3)) & std_logic'image(bcd3_out(2)) &
      std_logic'image(bcd3_out(1)) & std_logic'image(bcd3_out(0)) &
      "bcd4_o = " & std_logic'image(bcd4_out(3)) & std_logic'image(bcd4_out(2)) &
      std_logic'image(bcd4_out(1)) & std_logic'image(bcd4_out(0))
      severity error;
    end if;
    rst_in <= '0';
    wait for 200 ns;

    for i in 1 to 150 loop --! idle
      binary_in <= std_logic_vector(to_unsigned(i,binary_in'length));

      clk_in <= '0';
      wait for 200 ns;

      clk_in <= '1'; --! load
      wait for 200 ns;

      clk_in <= '0';
      wait for 200 ns;

      clk_in <= '1'; --! op
      wait for 200 ns;

      clk_in <= '0';
      wait for 200 ns;

      if(bcd1_out = std_logic_vector(to_unsigned((i)/1000,bcd1_out'length)) and
      bcd2_out = std_logic_vector(to_unsigned((i)/100 mod 10,bcd2_out'length)) and
      bcd3_out = std_logic_vector(to_unsigned((i)/10 mod 10,bcd3_out'length)) and
      bcd4_out = std_logic_vector(to_unsigned((i) mod 10,bcd4_out'length)))
      then
        report "SUCCESSFUL #" & integer'image(i) & " GOT : " &
        "bcd1_o = " & std_logic'image(bcd1_out(3)) & std_logic'image(bcd1_out(2)) &
        std_logic'image(bcd1_out(1)) & std_logic'image(bcd1_out(0)) &
        " bcd2_o = " & std_logic'image(bcd2_out(3)) & std_logic'image(bcd2_out(2)) &
        std_logic'image(bcd2_out(1)) & std_logic'image(bcd2_out(0)) &
        " bcd3_o = " & std_logic'image(bcd3_out(3)) & std_logic'image(bcd3_out(2)) &
        std_logic'image(bcd3_out(1)) & std_logic'image(bcd3_out(0)) &
        " bcd4_o = " & std_logic'image(bcd4_out(3)) & std_logic'image(bcd4_out(2)) &
        std_logic'image(bcd4_out(1)) & std_logic'image(bcd4_out(0))
        severity note;
      else
        report "ERROR #" & integer'image(i) & " GOT : " &
        "bcd1_o = " & std_logic'image(bcd1_out(3)) & std_logic'image(bcd1_out(2)) &
        std_logic'image(bcd1_out(1)) & std_logic'image(bcd1_out(0)) &
        " bcd2_o = " & std_logic'image(bcd2_out(3)) & std_logic'image(bcd2_out(2)) &
        std_logic'image(bcd2_out(1)) & std_logic'image(bcd2_out(0)) &
        " bcd3_o = " & std_logic'image(bcd3_out(3)) & std_logic'image(bcd3_out(2)) &
        std_logic'image(bcd3_out(1)) & std_logic'image(bcd3_out(0)) &
        " bcd4_o = " & std_logic'image(bcd4_out(3)) & std_logic'image(bcd4_out(2)) &
        std_logic'image(bcd4_out(1)) & std_logic'image(bcd4_out(0))
        severity error;
      end if;

      clk_in <= '1'; --! idle
      wait for 200 ns;
      clk_in <= '0';
      wait for 200 ns;
    end loop;
    wait;
  end process l;
end arch;