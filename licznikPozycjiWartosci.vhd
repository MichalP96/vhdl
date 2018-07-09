
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity licznikPozycjiWartosci is
    Port ( x : in  STD_LOGIC_VECTOR (5 downto 0); --zmiana na 5
           CLK_CNT : in  STD_LOGIC;
           y0 : out  STD_LOGIC_VECTOR (5 downto 0); --zamiana
           y1 : out  STD_LOGIC_vector (2 downto 0) --zmiana 
			  );
end licznikPozycjiWartosci;

architecture Behavioral of licznikPozycjiWartosci is

signal y0_signal : STD_LOGIC_VECTOR (5 downto 0); --zamiana
signal y1_signal : STD_LOGIC_vector (2 downto 0); --zmiana

begin


	process(CLK_CNT, x)
	begin
		if rising_edge(CLK_CNT) then
		
			if(x >= "001010" and x < "010100") then			
				y0_signal <= x - "001010"; 
				y1_signal <= "001"; 
			elsif (x >= "010100" and x < "011110") then
				y0_signal <= x - "010100" ;
				y1_signal <= "010";
			elsif (x >= "011110" and x < "101000") then
				y0_signal <= x - "011110";
				y1_signal <= "011";
			elsif (x >= "101000" and x < "110010") then
				y0_signal <= x - "101000";
				y1_signal <= "100";
			elsif (x >= "110010" and x < "111100") then
				y0_signal <= x - "110010";
				y1_signal <= "101";	
			else 
				y0_signal <= x;
				y1_signal <= "000";
			end if;
		end if;
	end process;
	
	y0 <= y0_signal;
	y1 <= y1_signal;

end Behavioral;

