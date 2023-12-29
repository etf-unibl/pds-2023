library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dual_edge_detector_tb is
end dual_edge_detector_tb;

architecture arch of dual_edge_detector_tb is

  component dual_edge_detector is
    port (
      clk_i    : in  std_logic;
      rst_i    : in  std_logic;  
      strobe_i : in  std_logic;
      p_o     : out std_logic
    );
  end component;

  signal clk_tb    : std_logic;
  signal rst_tb    : std_logic;  
  signal strobe_tb : std_logic;
  signal p1_tb     : std_logic;
  signal p1_comp   : std_logic;
  signal i         : integer := 0;

  type t_moore_test_vector is record
    strobe_v : std_logic;
    p1_v     : std_logic;
  end record t_moore_test_vector;

  type t_moore_test_vector_array is array (natural range <>) of t_moore_test_vector;

  constant c_MOORE_TEST_VECTORS : t_moore_test_vector_array := (
    ('0', '0'),
    ('1', '1'),
    ('1', '0'),
    ('1', '0'),
    ('0', '0'),
    ('1', '1'),
    ('0', '0')
  );

begin

  uut : dual_edge_detector
    port map(
      clk_i     => clk_tb,
      rst_i     => rst_tb,  
      strobe_i  => strobe_tb,
      p_o      => p1_tb
    );
  
  process
  begin

    clk_tb <= '0';
	 rst_tb <= '0';
    wait for 10 ns;
    clk_tb <= '1';
	 rst_tb <= '0';
    wait for 10 ns;

    if i = c_MOORE_TEST_VECTORS'length then
      wait;
    end if;

  end process;

  -- value assgination
  process
  begin

    strobe_tb <= c_MOORE_TEST_VECTORS(i).strobe_v;
    p1_comp   <= c_MOORE_TEST_VECTORS(i).p1_v;
	 wait for 15 ns;

    if i < c_MOORE_TEST_VECTORS'length then
      i <= i + 1;
    else
      wait;
    end if;

  end process;

  -- output compare
  process
    variable error_status : boolean;
  begin

    wait until clk_tb'event;
    wait for 5 ns;

    if p1_tb = p1_comp then
      error_status := false;
    else
      error_status := true;
    end if;

    assert not error_status
      report "Test Failed!"
      severity note;

    if i = c_MOORE_TEST_VECTORS'length then
      report "Test Finished.";
    end if;
  end process;
end arch;
