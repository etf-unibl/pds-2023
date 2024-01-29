library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequential_multiplier_tb is
end sequential_multiplier_tb;

architecture arch of sequential_multiplier_tb is
   component sequential_multiplier 
   port(
      clk_i   : in  std_logic;                     --! Standard clock pulse input
      rst_i   : in  std_logic;                     --! Asynchronous reset input
      start_i : in  std_logic;                     --! Input which sets circuit into operation
      a_i     : in  std_logic_vector(7 downto 0);  --! Input 8-bit operand
      b_i     : in  std_logic_vector(7 downto 0);  --! Input 8-bit operand
      c_o     : out std_logic_vector(15 downto 0); --! Output which has the result of multiply operation
      ready_o : out std_logic                      --! One bit output that signals when is possible to take input
   );
   end component;

   signal clk_i : std_logic := '0'; 
   signal rst_i : std_logic := '0'; 
   signal start_i : std_logic := '0'; 
   signal a_i : std_logic_vector(7 downto 0) := "00000000";
   signal b_i : std_logic_vector(7 downto 0) := "00000000";
   signal c_o : std_logic_vector(15 downto 0); 
   signal ready_o : std_logic; 

   constant T : time := 5 ns;
   constant num_of_clocks : integer := 600;

begin 

   uut: sequential_multiplier port map
   (
      clk_i => clk_i,
      rst_i => rst_i, 
      start_i => start_i, 
      a_i => a_i, 
      b_i => b_i, 
      c_o => c_o, 
      ready_o => ready_o
   );

   rst_i <= '1', '0' after T/2;

   process
   begin
      for i in 1 to num_of_clocks loop
         clk_i <= not clk_i;
         wait for T/2;
      end loop;
      wait;
   end process;

   stimulus_process: process
   begin 
      wait for 10 ns;
      
      for i in 0 to 255 loop
         
         for j in 0 to 255 loop
            a_i <= std_logic_vector(to_unsigned(i, 8));
            b_i <= std_logic_vector(to_unsigned(j, 8));

            start_i <= '1'; -- Start multiplication
            wait until ready_o = '1'; -- Wait for the result to be ready
            wait for 10 ns;
            start_i <= '0'; -- Stop multiplication

            -- check the value of c_o
            assert to_integer(unsigned(c_o)) = i * j
               report "Error, product incorrect! Expected product of " &
                  integer'image(i * j) & " for a = " &
                  integer'image(i) & " and b = " &
                  integer'image(j) & ", but was " &
                  integer'image(to_integer(unsigned(c_o)))
               severity error;
         end loop;
      end loop;

      -- echo to the user that the test is completed
      report "Test completed.";
      wait;   
   end process;

end arch;
