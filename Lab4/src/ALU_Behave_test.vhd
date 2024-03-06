LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY ALU_8Bit_test IS
END ALU_8Bit_test;
 
ARCHITECTURE behavior OF ALU_8Bit_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT ALU_8Bit
	generic (Dwidth : integer := 8);
	port(	
			In1, In2	:	in	std_logic_vector (Dwidth-1 downto 0);
			ALU_OUT : out std_logic_vector (Dwidth-1 downto 0);
			Sel	:	in	std_logic_vector(2 downto 0);
			Cin	:	in	std_logic;
			Zero, OVF : out std_logic);
	END COMPONENT;

   --Inputs
   signal A 	: std_logic_vector(7 downto 0) := x"00";
   signal B 	: std_logic_vector(7 downto 0) := x"00";
   signal Cin 	: std_logic := '0';
   signal S		: std_logic_vector(2 downto 0);
   
   
 	--Outputs
   signal Sout	: std_logic_vector(7 downto 0);
   --signal Cout	: std_logic;
  signal OVF   : std_logic ;
   signal zero  : std_logic ;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_8Bit PORT MAP (
			In1		=>	A,
			In2		=>	B,
			ALU_OUT	=>	Sout,
			Cin	=>	Cin,
			Sel		=> S,
			OVF 	=> OVF,
			Zero	=> Zero 
			);

   -- Stimulus process
   stim_proc: process
   begin		
		A		<=	x"01";	-- 1
		B		<=	x"01";	-- 1
		Cin	    <=	'0';
		S		<=	"000";		-- AND
		wait for 100 ns;

		A		<=	x"01";	-- 1
		B		<=	x"00";	-- 0
		Cin	    <=	'0';
		S		<=	"001";		-- OR
		wait for 100 ns;

		A		<=	x"01";	-- 1
		B		<=	x"FF";	-- 1
		Cin	    <=	'0';
		S		<=	"010";		-- Unsigned Add
		wait for 100 ns;
		
		A		<=	x"02";	-- 2
		B		<=	x"FF";	-- 1
		Cin	    <=	'0';
		S		<=	"010";		-- Unsigned Add
		wait for 100 ns;	

		A		<=	x"01";	-- 2
		B		<=	x"FF";	-- 1
		Cin	    <=	'0';
		S		<=	"011";		-- signed Add
		wait for 100 ns;	




		wait;
   end process;

END;
