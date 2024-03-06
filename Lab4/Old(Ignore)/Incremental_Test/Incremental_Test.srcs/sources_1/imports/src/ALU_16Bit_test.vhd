LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY ALU_test IS
    generic ( Dwidth   : integer := 8);
END ALU_test;

ARCHITECTURE behavior OF ALU_test IS 

-- Component Declaration for the Unit Under Test (UUT)
component   ALU
    Port(   
            IN1, IN2   :    IN  STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
            ALU_OUT    :    OUT STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
            SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
            Cin        :    IN  STD_LOGIC;
            Zero, OVF  :    OUT STD_LOGIC 
        );
end component;

    --Inputs
   signal IN1 	: std_logic_vector(Dwidth-1 downto 0) := "00000000";
   signal in2_TB 	: std_logic_vector(Dwidth-1 downto 0) := "00000000";
   signal Cin_TB 	: std_logic := '0';
   signal Sel_TB	: std_logic_vector(2 downto 0);
   
 	--Outputs
   signal ALU_Out_TB	: std_logic_vector(Dwidth-1 downto 0);
   signal Zero_TB	: std_logic;
   signal OVF_TB	: std_logic;
   
   --Wait time
   signal period    :   time := 100 ns;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
uut:    ALU port map(
                  In1 => IN1,
                  In2 => In2_TB,
                  ALU_Out => ALU_Out_TB,
                  Sel => Sel_TB,
                  Cin => Cin_TB,
                  Zero => Zero_TB,
                  OVF => OVF_TB
                  );

   -- Stimulus process
   stim_proc: process
   begin		
    -- And Tests
   IN1 <= x"64";
   in2_TB <= x"E6";
   sel_TB <= "000";
   wait for period;
   
   IN1 <= "10100011";
   in2_TB <= "10010010";
   sel_TB <= "000";
   wait for period;
   
   -- Or Test
   IN1 <= "10000011";
   in2_TB <= "10000101";
   sel_TB <= "001";
   wait for period;
   
   IN1 <= "10101010";
   in2_TB <= "01010101";
   sel_TB <= "001";
   wait for period;
   
   -- Unsigned Addition Test
   IN1 <= x"20"; -- 32
   in2_TB <= x"30"; -- 48
   sel_TB <= "010";
   wait for period;
   
   IN1 <= x"33"; -- 51
   in2_TB <= x"FF"; -- 255
   sel_TB <= "010";
   wait for period;
   
   -- Signed Addition Test
   IN1 <= x"33"; --  51
   in2_TB <= x"80"; -- -128
   sel_TB <= "010";
   wait for period;
   
   IN1 <= x"86"; -- -122 
   in2_TB <= x"7F"; -- 127
   sel_TB <= "010";
   wait for period;
   
   -- Xor Test
   IN1 <= "10101010";
   in2_TB <= "01010101";
   sel_TB <= "011";
   wait for period;
   
   IN1 <= "11010111";
   in2_TB <= "10101011";
   sel_TB <= "100";
   wait for period;
   
   -- Signed Subtraction Test
   IN1 <= "10000011";
   in2_TB <= "10000011";
   sel_TB <= "101";
   wait for period;
   
   IN1 <= "10000011";
   in2_TB <= "10000011";
   sel_TB <= "101";
   wait for period;
   
   -- Set on less than Test
   IN1 <= "00000011";
   in2_TB <= "10000011";
   sel_TB <= "110";
   wait for period;
   
   IN1 <= "00000011";
   in2_TB <= "10000011";
   sel_TB <= "110";
   wait for period;
   
   -- Branch if Equal Test
   IN1 <= "10000011";
   in2_TB <= "10000011";
   sel_TB <= "111";
   wait for period;
   
   IN1 <= "10000011";
   in2_TB <= "10000011";
   sel_TB <= "111";
   wait for period;		

    wait;
   end process;

END;
