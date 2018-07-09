
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity pozycja1wyswietlacza is
    Port ( y1 : in  STD_LOGIC_vector(2 downto 0); --zmiana
           seg1 : out  STD_LOGIC_VECTOR (6 downto 0));
end pozycja1wyswietlacza;

architecture Behavioral of pozycja1wyswietlacza is

constant c0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
constant c1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
constant c3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
constant c4 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
constant c5 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
constant c6 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";

begin


process (y1)
begin
	case y1 is
		when "000" => seg1 <= "1111110";
		when "001" => seg1 <= "0110000";
		when "010" => seg1 <= "1101101";
		when "011" => seg1 <= "1111001";
		when "100" => seg1 <= "0110011";
		when "101" => seg1 <= "1011011";
		when "110" => seg1 <= "1011111";
		
		when others  => seg1 <= "0000000";

	end case;
end process;


end Behavioral;

