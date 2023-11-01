library ieee;
use ieee.std_logic_1164.all;

entity nand2 is
   port ( A_i, B_i: in std_logic;
          Y_o: out std_logic
        );
end nand2;

architecture beh_nand2 of nand2 is
begin
   Y_o <= A_i nand B_i;
end beh_nand2;
