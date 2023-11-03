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
signal r : std_logic_vector(3 downto 0);
signal tmp : std_logic_vector(4 downto 0);

begin
	process(i_A, i_B, i_SEL)
begin
		case i_sel is 
		when "00" => 
			r <= std_logic_vector(unsigned(i_A)+unsigned(i_B));
		when "01" => 
			r <= std_logic_vector(unsigned(i_A)-unsigned(i_B));
		when "10" => 
			r <= "00" & i_A(3 downto 2);
		when "11" => 
			r <= (others=>'0'); 
		end case; 
		
		o_RES <= r; 
		tmp <= std_logic_vector(unsigned('0' & i_A) + unsigned('0' & i_B));
		o_C <=tmp(4);
		
	end process;
end beh_arch;

