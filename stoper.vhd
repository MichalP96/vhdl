
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity stoper is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           dp : out  STD_LOGIC;
			  start_stop : in std_logic;
			  ----lcd
			   lcd_e  : out std_logic;
				lcd_rs : out std_logic;
				lcd_rw : out std_logic;
				lcd_db : out std_logic_vector(7 downto 4));
end stoper;

architecture Behavioral of stoper is

------------------------lcd
	signal timer : natural range 0 to 100000000 := 0;
  signal switch_lines : std_logic := '0';
  signal line1 : std_logic_vector(127 downto 0);
  signal line2 : std_logic_vector(127 downto 0);
  
    -- component generics
  constant CLK_PERIOD_NS : positive := 20;  -- 50 Mhz

  -- component ports
  signal rst          : std_logic;
  signal line1_buffer : std_logic_vector(127 downto 0);
  signal line2_buffer : std_logic_vector(127 downto 0);

	component zegary
	Port( 
			clk : in std_logic;  --zegar fpga
			CLK_CNT : out std_logic; -- zegar licznika
			CLK_DISP : out std_logic-- zegar wyswietlania bo odpowiednia czestotliwosc odswiezania
			);
	
	end component;
	
	
	component licznik
		Port(
			CLK_CNT : in std_logic;
			reset : in std_logic;
			x : out std_logic_vector(5 downto 0); --zmiana z 3
			start_stop : in std_logic
			);
	end component;
	
	component pozycja0wyswietlacza
	 Port ( y0 : in  STD_LOGIC_VECTOR (5 downto 0);
           seg0 : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;
	
	component pozycja1wyswietlacza
	    Port ( y1 : in  STD_LOGIC_vector(2 downto 0);
           seg1 : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;
	
	component kontolerWyswietlania
	 Port ( seg0 : in  STD_LOGIC_VECTOR (6 downto 0);
           seg1 : in  STD_LOGIC_VECTOR (6 downto 0);
           CLK_DISP : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           dp : out  STD_LOGIC);
	end component;
	
	component licznikPozycjiWartosci
	    Port ( x : in  STD_LOGIC_VECTOR (5 downto 0);
           CLK_CNT : in  STD_LOGIC;
           y0 : out  STD_LOGIC_VECTOR (5 downto 0);
           y1 : out  STD_LOGIC_vector(2 downto 0)
			  );
	end component;
	
		component lcd16x2
	    Port     (	rst          : in  std_logic;
						lcd_e        : out std_logic;
						lcd_rs       : out std_logic;
						lcd_rw       : out std_logic;
						lcd_db       : out std_logic_vector(7 downto 4);
						line1_buffer : in  std_logic_vector(127 downto 0);  -- 16x8bit
						line2_buffer : in  std_logic_vector(127 downto 0));
	end component;
	
	signal CLK_CNT_signal : STD_LOGIC;
	signal CLK_DISP_signal : std_logic;
	signal x_signal : STD_LOGIC_VECTOR (5 downto 0);
	signal y0_signal : STD_LOGIC_VECTOR (5 downto 0);
	signal y1_signal : std_logic_vector(2 downto 0);
	signal seg0_signal : STD_LOGIC_VECTOR (6 downto 0);
	signal seg1_signal : STD_LOGIC_VECTOR (6 downto 0);
begin

	CLK_CNT : zegary
	port map
	(
		clk => clk,
		CLK_CNT => CLK_CNT_signal,
		CLK_DISP => CLK_DISP_signal
		);
		
	CNT : licznik
	port map
	(	
			CLK_CNT => CLK_CNT_signal,
			reset => reset,
			x  => x_signal,
			start_stop => start_stop
	);
		
	licz_pozyc_wartosci : licznikPozycjiWartosci
	port map
	(
			  x => x_signal,
           CLK_CNT => CLK_CNT_signal,
           y0 => y0_signal,
           y1 => y1_signal
	);
	
	pozycja_1_wyswietlacza : pozycja1wyswietlacza
	port map
	(
		 y1 => y1_signal,
       seg1 => seg1_signal
		 );
		 
		pozycja_0_wyswietlacza : pozycja0wyswietlacza
	port map
	(
		 y0 => y0_signal,
       seg0 => seg0_signal
		 );
		

		kotroler_wyswietlania : kontolerWyswietlania
		port map
		(
			seg0 => seg0_signal,
           seg1 => seg1_signal,
           CLK_DISP => CLK_DISP_signal,
           seg => seg,
           an => an,
           dp => dp
			);
	------------------lcd		
			 -- component instantiation
  DUT : entity work.lcd16x2_ctrl
    generic map (
      CLK_PERIOD_NS => CLK_PERIOD_NS)
    port map (
      clk          => clk,
      rst          => rst,
      lcd_e        => lcd_e,
      lcd_rs       => lcd_rs,
      lcd_rw       => lcd_rw,
      lcd_db       => lcd_db,
      line1_buffer => line1_buffer,
      line2_buffer => line2_buffer);

  rst <= '0';

  -- see the display's datasheet for the character map
  line1(127 downto 120) <= "01001110";  -- N
  line1(119 downto 112) <= "00110001";  -- 1
  line1(111 downto 104) <= "00110111";  -- 7
  line1(103 downto 96)  <= "10110000";  -- -
  line1(95 downto 88)   <= "01010011";  -- S
  line1(87 downto 80)   <= "01010100";  -- T
  line1(79 downto 72)   <= "01000001";  -- A
  line1(71 downto 64)   <= "01010010";  -- R 
  line1(63 downto 56)   <= "01010100";  -- T
  line1(55 downto 48)   <= "00101111";  -- /
  line1(47 downto 40)   <= "01010011";  -- S
  line1(39 downto 32)   <= "01010100";  -- T
  line1(31 downto 24)   <= "01001111";  -- O
  line1(23 downto 16)   <= "01010000";  -- P
  line1(15 downto 8)    <= X"20";  -- 
  line1(7 downto 0)     <= X"20";  --

  line2(127 downto 120) <= "01001000";  -- H 
  line2(119 downto 112) <= "00110001";  -- 1
  line2(111 downto 104) <= "00111000";  -- 8
  line2(103 downto 96)  <= "10110000";  -- -
  line2(95 downto 88)   <= "01010010";  -- R
  line2(87 downto 80)   <= "01000101";  -- E
  line2(79 downto 72)   <= "01010011";  -- S
  line2(71 downto 64)   <= "01000101";  -- E
  line2(63 downto 56)   <= "01010100";  -- T
  line2(55 downto 48)   <= X"20";  -- 
  line2(47 downto 40)   <= X"20";  -- 
  line2(39 downto 32)   <= X"20";  -- 
  line2(31 downto 24)   <= X"20";  -- 
  line2(23 downto 16)   <= X"20";  -- 
  line2(15 downto 8)    <= X"20";  -- 
  line2(7 downto 0)     <= X"20";  -- 

  line1_buffer <= line2 when switch_lines = '1' else line1;
  line2_buffer <= line1 when switch_lines = '1' else line2;

  -- switch lines every second
 -- process(clk)
 -- begin
  --  if rising_edge(clk) then
   --   if timer = 0 then
     --   timer <= 100000000;
    --    switch_lines <= not switch_lines;
    --  else
     --   timer <= timer - 1;
    --  end if;
   -- end if;
      
 -- end process;
			
end Behavioral;

