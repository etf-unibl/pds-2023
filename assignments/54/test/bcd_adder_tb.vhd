LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;                                

ENTITY bcd_adder_tb IS
END bcd_adder_tb;
ARCHITECTURE arch OF bcd_adder_tb IS                                                   
SIGNAL SUM_o : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL A_i : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL B_i : STD_LOGIC_VECTOR(11 DOWNTO 0);

COMPONENT bcd_adder
	PORT (
	
	A_i : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	B_i : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	SUM_o: BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0)
	
	);
END COMPONENT;

BEGIN
	i1 : bcd_adder
	PORT MAP (
	A_i => A_i,
	B_i => B_i,
	SUM_o => SUM_o
	);
init : PROCESS                                               
variable ai_h : unsigned (3 downto 0);
variable ai_dec : unsigned (3 downto 0);
variable ai_u : unsigned (3 downto 0);
variable bi_h : unsigned (3 downto 0);
variable bi_dec : unsigned (3 downto 0);
variable bi_u : unsigned (3 downto 0); 
                                    
BEGIN
A_i <= (others => '0');
B_i <= (others => '0');                                                        
for a in 0 to 999 loop
	for b in 0 to 999 loop
		ai_h := to_unsigned(a/100, ai_h'length);
		ai_dec := to_unsigned((a/10) mod 10, ai_dec'length);
		ai_u := to_unsigned(a mod 10, ai_u'length);
		bi_h := to_unsigned(b/100, bi_h'length);
		bi_dec := to_unsigned((b/10) mod 10, bi_dec'length);
		bi_u := to_unsigned(b mod 10, bi_u'length);
		
		A_i <= (std_logic_vector(ai_h) & std_logic_vector(ai_dec) & std_logic_vector(ai_u));
		B_i <= (std_logic_vector(bi_h) & std_logic_vector(bi_dec) & std_logic_vector(bi_u));
		wait for 100 ns;
	end loop;
end loop;
WAIT;                                                       
END PROCESS init;                                           

PROCESS
variable error_status : boolean;
variable ai_h : unsigned (3 downto 0);
variable ai_dec : unsigned (3 downto 0);
variable ai_u : unsigned (3 downto 0);
variable bi_h : unsigned (3 downto 0);
variable bi_dec : unsigned (3 downto 0);
variable bi_u : unsigned (3 downto 0);
variable s_t : unsigned (3 downto 0);
variable s_h : unsigned (3 downto 0);
variable s_dec : unsigned (3 downto 0);
variable s_u : unsigned (3 downto 0);
variable counter : integer := 0;
BEGIN                                                         
for a in 0 to 999 loop
	for b in 0 to 999 loop
		ai_h := to_unsigned(a/100, ai_h'length);
		ai_dec := to_unsigned((a/10) mod 10, ai_dec'length);
		ai_u := to_unsigned(a mod 10, ai_u'length);
		bi_h := to_unsigned(b/100, bi_h'length);
		bi_dec := to_unsigned((b/10) mod 10, bi_dec'length);
		bi_u := to_unsigned(b mod 10, bi_u'length);
		s_t := to_unsigned((a + b)/1000, s_t'length);
		s_h := to_unsigned(((a + b) mod 1000) / 100, s_h'length);
		s_dec := to_unsigned(((a + b) / 10) mod 10, s_dec'length);
		s_u := to_unsigned((a + b) mod 10, s_u'length);
	   if not ((A_i = (std_logic_vector(ai_h) & std_logic_vector(ai_dec) & std_logic_vector(ai_u))) and
        (B_i = (std_logic_vector(bi_h) & std_logic_vector(bi_dec) & std_logic_vector(bi_u))) and
        (to_integer(unsigned(SUM_o)) = to_integer(unsigned(s_t & s_h & s_dec & s_u))))
		then
			counter := counter + 1;
		end if;
	end loop;
end loop;

	if(counter = 0) then
		error_status := false;
	else
		error_status := true;
	end if;
	assert not error_status
		report "Test complited !"
		severity note;
WAIT;                                                        
END PROCESS;                                          
END arch;
