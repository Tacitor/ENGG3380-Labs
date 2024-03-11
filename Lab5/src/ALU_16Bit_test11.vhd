LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU_16Bit_test IS
END ALU_16Bit_test;

ARCHITECTURE behavior OF ALU_16Bit_test IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ALU_16Bit
		PORT(
  			A		  : IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
  			B		  :	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
  			Cin	  :	IN		STD_LOGIC;
  			S		  :	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
  			Sout	:	OUT	  STD_LOGIC_VECTOR(15 DOWNTO 0);
  			Cout	:	OUT	  STD_LOGIC
			);
	END COMPONENT;

   --Inputs
   SIGNAL A 	 : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
   SIGNAL B 	 : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
   SIGNAL Cin  : STD_LOGIC := '0';
   SIGNAL S		 : STD_LOGIC_VECTOR(1 DOWNTO 0);

 	--Outputs
   SIGNAL Sout	: STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL Cout	: STD_LOGIC;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_16Bit PORT MAP (
			A		  =>	A,
			B		  =>	B,
			Cin	  =>	Cin,
			S		  =>  S,
			Sout	=>	Sout,
			Cout	=>	Cout
    );

   -- Stimulus process
   stim_proc: PROCESS
   BEGIN
		A		<=	x"0064"; 	-- 100
		B		<=	x"00E6";		-- 230
		Cin	<=	'0';
		S		<=	"00";			-- Add
		WAIT FOR 100 ns;
    
		A		<=	x"FFEC"; 	-- -20
		B		<=	x"003C";		-- 60
		Cin	<=	'0';
		S		<=	"00";			-- Add
		WAIT FOR 100 ns;

		A		<=	x"0001"; 	-- 1
		B		<=	x"0001";		-- 1
		Cin	<=	'0';
		S		<=	"00";			-- Add
		WAIT FOR 100 ns;

		A		<=	x"01F4"; 	-- 500
		B		<=	x"0154";		-- 340
		Cin	<=	'0';
		S		<=	"01";			-- Sub
		WAIT FOR 100 ns;

		A		<=	x"0037"; 	-- 55
		B		<=	x"0046";		-- 70
		Cin	<=	'0';
		S		<=	"01";			-- Sub
		WAIT FOR 100 ns;

		A		<=	x"FFFF"; 	-- -1
		B		<=	x"000E";		-- 14
		Cin	<=	'0';
		S		<=	"01";			-- Sub
		WAIT FOR 100 ns;

		A		<=	x"0080"; 	-- 128
		B		<=	x"0200";		-- 512
		Cin	<=	'0';
		S		<=	"10";			-- And
		WAIT FOR 100 ns;

		A		<=	x"0BB8"; 	-- 3000
		B		<=	x"0002";		-- 2
		Cin	<=	'0';
		S		<=	"10";			-- And
		WAIT FOR 100 ns;

		A		<=	x"14DE"; 	-- 5342
		B		<=	x"03D2";		-- 978
		Cin	<=	'0';
		S		<=	"10";			-- And
		WAIT FOR 100 ns;

		A		<=	x"0010"; 	-- 16
		B		<=	x"0008";		-- 8
		Cin	<=	'0';
		S		<=	"11";			-- Or
		WAIT FOR 100 ns;

		A		<=	x"0000"; 	-- 0
		B		<=	x"0929";		-- 2345
		Cin	<=	'0';
		S		<=	"11";			-- Or
		WAIT FOR 100 ns;

		A		<=	x"FFFF"; 	-- -1
		B		<=	x"0005";		-- 5
		Cin	<=	'0';
		S		<=	"11";			-- Or
		WAIT FOR 100 ns;

      WAIT;
   END PROCESS;

END;
