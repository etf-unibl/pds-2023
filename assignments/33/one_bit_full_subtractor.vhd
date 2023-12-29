library ieee;
use ieee.std_logic_1164.all;

entity one_bit_full_subtractor is
	port
	(
		a, b, b_in	: in  std_logic;
		d, b_out	: out std_logic
		
	);
end one_bit_full_subtractor;


architecture one_bit_full_subtractor_arch of one_bit_full_subtractor is

	signal input : std_logic_vector(2 downto 0);
	signal output : std_logic_vector(1 downto 0);

begin
	input(0) <= a;
	input(1) <= b;
	input(2) <= b_in;
	
	with input select
	
	output <= "00" when "000" | "101" | "110",
				 "01" when "011",
				 "10" when "100",
				 "11" when others; --"001" "010" "111"
	
	d <= output(0);
	b_out <= output(1);
	
end one_bit_full_subtractor_arch;

