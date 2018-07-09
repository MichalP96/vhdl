
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY stoper_tb IS
END stoper_tb;
 
ARCHITECTURE behavior OF stoper_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT stoper
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         seg : OUT  std_logic_vector(6 downto 0);
         an : OUT  std_logic_vector(3 downto 0);
         dp : OUT  std_logic
        );
    END COMPONENT;
    


   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal seg : std_logic_vector(6 downto 0);
   signal an : std_logic_vector(3 downto 0);
   signal dp : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: stoper PORT MAP (
          clk => clk,
          reset => reset,
          seg => seg,
          an => an,
          dp => dp
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
      
		reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
