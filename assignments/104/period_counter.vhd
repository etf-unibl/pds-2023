library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity period_counter is
    port (
        clk_i    : in  std_logic;
        rst_i    : in  std_logic;
        signal_i : in  std_logic;
        period_o : out std_logic_vector(9 downto 0)
    );
end period_counter;

architecture arch of period_counter is
    signal current_count, prev_count : unsigned(9 downto 0) := (others => '0');
begin
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            current_count <= (others => '0');
        elsif rising_edge(clk_i) then
            current_count <= current_count + 1;
        end if;
    end process;

    process (signal_i, rst_i)
    begin
        if rst_i = '1' then
            prev_count  <= (others => '0');
            period_o    <= (others => '0');
        elsif rising_edge(signal_i) then
            if prev_count < current_count then
                period_o <= std_logic_vector(current_count - prev_count);
            elsif prev_count > current_count then
                period_o <= std_logic_vector(to_unsigned(1024, 10) - prev_count + current_count);
            else
                period_o <= (others => '0');
            end if;
            prev_count <= current_count;
        end if;
    end process;
end arch;
