
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity kontolerWyswietlania is
    Port ( seg0 : in  STD_LOGIC_VECTOR (6 downto 0);
           seg1 : in  STD_LOGIC_VECTOR (6 downto 0);
           CLK_DISP : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           dp : out  STD_LOGIC);
end kontolerWyswietlania;

architecture Behavioral of kontolerWyswietlania is

signal seg_signal :  STD_LOGIC_VECTOR (6 downto 0);

begin
	
	process (CLK_DISP, seg0, seg1)
		begin	
			if CLK_DISP = '0' then
				seg_signal <= seg0;
				an <= "0001";
			else
				seg_signal <= seg1;
				an <= "0010";
			end if;
		end process;
	
	seg <= seg_signal;
	dp <= '1'; --odpowiada czy wyswietlane sa kropki
end Behavioral;

