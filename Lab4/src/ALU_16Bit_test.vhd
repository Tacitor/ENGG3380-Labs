LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY ALU_16Bit_test IS
END ALU_16Bit_test;
 
ARCHITECTURE behavior OF ALU_16Bit_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT ALU_16Bit
		port(	
			A		:	in		std_logic_vector(15 downto 0);
			B		:	in		std_logic_vector(15 downto 0);
--			Cin	    :	in		std_logic;
			S		:	in		std_logic_vector(1 downto 0);			
			Sout	:	out	std_logic_vector(15 downto 0);
			Cout	:	out	std_logic
			);
	END COMPONENT;

   --Inputs
   signal A 	: std_logic_vector(15 downto 0) := x"0000";
   signal B 	: std_logic_vector(15 downto 0) := x"0000";
   signal Cin 	: std_logic := '0';
   signal S		: std_logic_vector(1 downto 0);
   
 	--Outputs
   signal Sout	: std_logic_vector(15 downto 0);
   signal Cout	: std_logic;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_16Bit PORT MAP (
			A		=>	A,
			B		=>	B,
--			Cin	=>	Cin,
			S		=> S,
			Sout	=>	Sout,
			Cout	=>	Cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
		A		<=	x"0064";	-- 100
		B		<=	x"00E6";	-- 230
		Cin	    <=	'0';
		S		<=	"00";		-- Add
		wait for 100 ns;
		
        A		 <=	    x"FFEC";	-- -20
        B        <=     x"003C";    -- 60
        Cin      <=     '0';
        S        <=     "00";        -- Add
        wait for 100 ns;
		
        A        <=     x"0001";    -- 1
        B        <=     x"0001";    -- 1
        Cin      <=     '0';
        S        <=     "00";        -- Add
        wait for 100 ns;
        
        A        <=     x"01F4";      -- 500
        B        <=     x"0154";      -- 340
        Cin      <=     '0';
        S        <=     "01";        -- Sub
        wait for 100 ns;
        
		A		<=	    x"0037";	-- 55
        B        <=     x"0046";    -- 70
        Cin        <=   '0';
        S        <=     "01";        -- Sub
        wait for 100 ns;
        
        A         <=    x"FFFF";    -- -1
        B        <=     x"000E";    -- 14
        Cin      <=     '0';
        S        <=     "01";        -- Sub
        wait for 100 ns;
        
        A        <=     x"0080";    -- 128
        B        <=     x"0200";    -- 512
        Cin      <=     '0';
        S        <=     "10";        -- And
        wait for 100 ns;
        
        A        <=     x"0BB8";    -- 3000
        B        <=     x"0002";    -- 2
        Cin      <=     '0';
        S        <=     "10";        -- And
        wait for 100 ns;        

		A		<=	x"14DE";	-- 5342
		B		<=	x"03D2";	-- 978
		Cin	    <=	'0';
		S		<=	"10";		-- And
		wait for 100 ns;
		
        A		 <=	    x"0010";	-- 16
        B        <=     x"0008";    -- 8
        Cin      <=     '0';
        S        <=     "11";        -- Or
        wait for 100 ns;
		
        A        <=     x"0000";    -- 0
        B        <=     x"0929";    -- 2345
        Cin      <=     '0';
        S        <=     "11";        -- Or
        wait for 100 ns;
        
        A        <=     x"FFFF";    -- -1
        B        <=     x"0005";    -- 5
        Cin      <=     '0';
        S        <=     "11";        -- Or
        wait for 100 ns;		

		wait;
   end process;

END;
