
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity licznik is
	Port(
			CLK_CNT : in std_logic;
			reset : in std_logic;
			x : out std_logic_vector(5 downto 0) --zmiana z 3
			--start_stop : in std_logic
			);
end licznik;

architecture Behavioral of licznik is

signal count : STD_LOGIC_VECTOR(5 downto 0):= "000000"; --ZMINA z 3

begin

	process (CLK_CNT, reset)
	begin 
		if(reset = '1') then
			count <= (others => '0');
		elsif (CLK_CNT'Event and CLK_CNT = '1') then
				if(start_stop = '0') then
					count <= count;
				elsif(start_stop = '1') then
					count <= count + 1;
				end if;

		end if;
	end process;
	
	x <= count;


end Behavioral;

