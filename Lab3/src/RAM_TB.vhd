LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RAM_TB IS
END RAM_TB;
 
ARCHITECTURE behavior OF RAM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	
	COMPONENT lab2mem is 
        generic ( Dwidth : integer := 16; -- Each location is 16 bits
                  Awidth : integer := 8); -- 8 Address lines (i.e., 64 locations)
        port ( we,clk: in std_logic;
               addr: in std_logic_vector(Awidth-1 downto 0);
               din: in std_logic_vector(Dwidth-1 downto 0);
               dout: out std_logic_vector(Dwidth-1 downto 0) );
    end COMPONENT;
    

   --Inputs
   signal we : std_logic := '0';
   signal clk : std_logic := '0';
   signal addr : std_logic_vector(7 downto 0) := "00000000";
   signal din : std_logic_vector(15 downto 0) := "1010101010101010";

 	--Outputs
   signal dout : std_logic_vector(15 downto 0) := "0101010101010101";
   
   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: lab2mem 
		generic map(16, 8)
		PORT MAP (
          we => we,
          clk => clk,
          addr => addr,
          din => din,
          dout => dout
        );
 

   -- Stimulus process
   stim_proc: process
   begin
   
		-- insert stimulus here 
		clk <= '0';
        --wait for clk_period; --don't need this is should be initialized to the correct values already
		addr <= "00000000";
		clk <= '1';
		wait for clk_period;
		
		clk <= '0';
		wait for clk_period;
		addr <= "00000001";
		clk <= '1';
		wait for clk_period;
		
		clk <= '0';
        wait for clk_period;
        addr <= "00000001";
        we <= '1';
        clk <= '1';
        wait for clk_period;
        
        clk <= '0';
        wait for clk_period;
        addr <= "00000001";
        we <= '0';
        clk <= '1';
        wait for clk_period;
		
		clk <= '0';
		wait for clk_period;
		addr <= "00000010";
		clk <= '1';
		wait for clk_period;

      wait;
   end process;

END;
