library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fibonacci_tb is
end fibonacci_tb;

architecture arch of fibonacci_tb is

  constant c_T : time := 20 ns;
  constant c_NUM_OF_CLOCKS : integer := 64;

  signal clk_i   : STD_LOGIC := '0';  
  signal n_i     : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');  
  signal r_o     : STD_LOGIC_VECTOR(42 downto 0) := (others => '0');  
  signal ready_o : STD_LOGIC := '0';  
  signal reset_i : STD_LOGIC := '1';  
  signal start_i : STD_LOGIC := '1';

  signal i : integer := 0;  
  component fibonacci
    port (
      clk_i   : in  STD_LOGIC;
      n_i     : in  STD_LOGIC_VECTOR(5 downto 0);
      r_o     : out STD_LOGIC_VECTOR(42 downto 0);
      ready_o : out STD_LOGIC;
      rst_i   : in  STD_LOGIC;
      start_i : in  STD_LOGIC
    );
  end component;

begin
  i1 : fibonacci
    port map (
      clk_i   => clk_i,
      n_i     => n_i,
      r_o     => r_o,
      ready_o => ready_o,
      rst_i   => reset_i,
      start_i => start_i
    );

  reset_i <= '1', '0' after c_T/2 when i = 0 else '0';  
  start_i <= '1';

  process
  begin
    wait for 2 * c_T; 

    for i in 0 to c_NUM_OF_CLOCKS - 1 loop
      n_i <= std_logic_vector(to_unsigned(i, n_i'length));
      
      clk_i <= not clk_i;  
      wait for c_T/2;

      if i = c_NUM_OF_CLOCKS - 1 then
        assert ready_o = '1'
          report "Test Passed: ready_o is asserted."
          severity note;
        
        assert r_o = "10000000000000001010101010010011110011010100100010010"
          report "Test Passed: Correct Fibonacci number generated after 64 clocks."
          severity note;

        report "Test Successful";
        wait;
      end if;
    end loop;
  end process;

end arch;
