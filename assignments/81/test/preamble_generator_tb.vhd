library ieee;
use ieee.std_logic_1164.all;

entity preamble_generator_tb is
end preamble_generator_tb;

architecture arch of preamble_generator_tb is

  component preamble_generator
    port(
      clk_i : in std_logic;
      rst_i : in std_logic;
      start_i : in std_logic;
      data_out_o : out std_logic
    );
  end component;
  constant T : time := 20 ns;
  constant preamble : std_logic_vector(7 downto 0) := "10101010";
  signal test_clk : std_logic;
  signal test_rst : std_logic;
  signal test_start : std_logic;
  signal test_data : std_logic;
begin

  -- uut instantiation
  uut : preamble_generator port map(
    clk_i      => test_clk,
    rst_i      => test_rst,
    start_i    => test_start,
    data_out_o => test_data);

  test_rst <= '1', '0' after T/2;

  -- clock generator
  process
  begin
    test_clk <= '0';
    wait for T/2;
    test_clk <= '1';
    wait for T/2;
  end process;

  -- start generator
  process
  begin
    test_start <= '0';
    wait for T;
    test_start <= '1';
    wait for T;
    test_start <= '0';
    wait for T*10;
    test_start <= '1', '0' after T;
    wait for T*4;
    test_start <= '1', '0' after T;
  end process;
  -- tb process
  process
    variable count : natural range 0 to 8 := 0;
    variable enbl : std_logic := '0';
  begin
    wait until rising_edge(test_clk);
    wait for T/5;

    if test_start = '1' then
      enbl := '1';
      count := 0;
    end if;

    if enbl = '1' then
      assert(test_data = PREAMBLE(count))
        report "Output bit " & std_logic'image(test_data) & " Not equal to preambel bit " &
               std_logic'image(PREAMBLE(count))
               severity error;

      if count /= 7 then
        count := count + 1;
      else
        enbl := '0';
        count := 0;
      end if;
    end if;
  end process;

  -- stop simulation process
  process
  begin
    wait for T*30;
    assert false
      report "Test completed."
      severity failure;
  end process;
end arch;