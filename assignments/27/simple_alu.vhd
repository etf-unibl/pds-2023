library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity simple_alu is
    port (i_A : in std_logic_vector(3 downto 0);
          i_B : in std_logic_vector(3 downto 0);
          i_SEL : in std_logic_vector(1 downto 0);
          o_RES : out std_logic_vector(3 downto 0);
          o_C : out std_logic);
end simple_alu;

architecture beh_arch of simple_alu is
signal sum, diff, sarA, shlB : std_logic_vector(3 downto 0); 
signal carry1, carry2 : std_logic; 

begin
		sum <= std_logic_vector(unsigned(i_A) + unsigned(i_B));
		diff <= std_logic_vector(unsigned(i_A) - unsigned(i_B));
		sarA <= "11"&i_A(3 downto 2);
		shlB <= (others=>'0');
		
		
		o_RES <= sum when i_SEL(1 downto 0) ="00" else
					diff when i_SEL(1 downto 0) ="01" else
					sarA when i_SEL(1 downto 0) ="10" else
					shlB;
					
		carry1 <= '1' when (unsigned(i_A) + unsigned(i_B) > 15) else
					 '0';
					
		carry2 <= '1' when (unsigned(i_A) - unsigned(i_B) < 0 ) else
					 '0';
					
		o_C <= carry1 when i_SEL(1 downto 0) ="00" else
				 carry2 when i_SEL(1 downto 0) ="01" else
				 '0'; 
		
		
end beh_arch;

