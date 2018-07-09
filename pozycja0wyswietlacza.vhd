
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;




entity pozycja0wyswietlacza is
    Port ( y0 : in  STD_LOGIC_VECTOR (5 downto 0);
           seg0 : out  STD_LOGIC_VECTOR (6 downto 0));
end pozycja0wyswietlacza;

architecture Behavioral of pozycja0wyswietlacza is

constant c0 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
constant c1 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000001";
constant c2 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
constant c3 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";
constant c4 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";
constant c5 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";
constant c6 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000110";
constant c7 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "000111";
constant c8 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
constant c9 : STD_LOGIC_VECTOR(5 DOWNTO 0) := "001001";

begin

process (y0)
begin
	case y0 is
		when c0 => seg0 <= "1111110";
		when c1 => seg0 <= "0110000";
		when c2 => seg0 <= "1101101";
		when c3 => seg0 <= "1111001";
		when c4 => seg0 <= "0110011";
		when c5 => seg0 <= "1011011";
		when c6 => seg0 <= "1011111";
		when c7 => seg0 <= "1110000";
		when c8 => seg0 <= "1111111";
		when c9 => seg0 <= "1111011";
		when others => seg0 <= "0000000";
	end case;
end process;




end Behavioral;

