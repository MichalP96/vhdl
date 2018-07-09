
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity zegary is
	Port( 
			
			clk : in std_logic;  --zegar fpga
			CLK_CNT : out std_logic; -- zegar licznika
			CLK_DISP : out std_logic-- zegar wyswietlania bo odpowiednia czestotliwosc odswiezania
			);
end zegary;

architecture Behavioral of zegary is

signal count : std_logic_vector (25 downto 0):= "00000000000000000000000000" ;
signal count2 : std_logic_vector (14 downto 0) := "000000000000000";


begin

	process(clk)
	begin
		if rising_edge(clk) then
				count <= count + '1';
		end if;
	end process;
	

	
	process(clk)
	begin
		if(clk'Event and clk = '1') then
			if(count = "10000101100000111011000000") then
				CLK_CNT <= '1';
			else
				CLK_CNT <= '0';
			end if;
		end if;
		end process;
		
	--wygenerowac osobny licznik dla clk_disp
	
	CLK_DISP <= count(17);

	
end Behavioral;

