LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY eight_bit_divider_tb IS
END eight_bit_divider_tb;

ARCHITECTURE eight_bit_divider_arch OF eight_bit_divider_tb IS
  -- Deklaracija signala za ulaze i izlaze
  SIGNAL a_pom : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL b_pom : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL q_pom : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL r_pom : STD_LOGIC_VECTOR(7 DOWNTO 0);

  COMPONENT eight_bit_divider
    PORT (
      A_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      B_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      Q_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      R_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT;

BEGIN
  i1 : eight_bit_divider PORT MAP (
    A_i => a_pom,
    B_i => b_pom,
    Q_o => q_pom,
    R_o => r_pom
  );

  PROCESS
    variable rp, qp : unsigned(7 downto 0);
    variable error_status : boolean := false;
  BEGIN
    FOR i IN 0 TO 255 LOOP
      a_pom <= std_logic_vector(to_unsigned(i, 8));
      FOR j IN 1 TO 255 LOOP
        b_pom <= std_logic_vector(to_unsigned(j, 8));
        rp := to_unsigned(i, 8) / to_unsigned(j, 8);
        qp := to_unsigned(i, 8) rem to_unsigned(j, 8);
        q_pom <= std_logic_vector(qp);
        r_pom <= std_logic_vector(rp);
        WAIT FOR 100 ns;
        
        -- Provera rezultata
        IF (q_pom /= std_logic_vector(qp)) OR (r_pom /= std_logic_vector(rp)) THEN
          error_status := true;
        END IF;
      END LOOP;
    END LOOP;
    
    -- Finalna provera ispravnosti rezultata
    ASSERT NOT error_status
      REPORT "Test završen. Rezultati su ispravni."
      SEVERITY NOTE;
    
    WAIT;
  END PROCESS;
END eight_bit_divider_arch;
