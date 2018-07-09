
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY clk_cnt_tb IS
END clk_cnt_tb;
 
ARCHITECTURE behavior OF clk_cnt_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT zegary
    PORT(
         clk : IN  std_logic;
         CLK_CNT : OUT  std_logic;
         CLK_DISP : OUT  std_logic
        );
    END COMPONENT;
    
	 
	 


   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal CLK_CNT : std_logic;
   signal CLK_DISP : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 ns;
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: zegary PORT MAP (
          clk => clk,
          CLK_CNT => CLK_CNT,
          CLK_DISP => CLK_DISP
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
 

 

   -- Stimulus process
   stim_proc: process
   begin		
    
		
      wait for clk_period*100000000;

      -- insert stimulus here 

      wait;
   end process;

END;
