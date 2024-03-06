library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestFile is
    generic ( Dwidth   : integer := 8);
end TestFile;

architecture Behavioral of TestFile is

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
   signal in1_TB 	: std_logic_vector(Dwidth-1 downto 0) := "00000000";
   signal in2_TB 	: std_logic_vector(Dwidth-1 downto 0) := "00000000";
   signal Cin_TB 	: std_logic := '0';
   signal Sel_TB	: std_logic_vector(2 downto 0) := "000";
   
 	--Outputs
   signal ALU_Out_TB	: std_logic_vector(Dwidth-1 downto 0);
   signal Zero_TB	: std_logic;
   signal OVF_TB	: std_logic;
   
   --Wait time
   signal period    :   time := 100 ns;

begin

uut:    ALU port map(
              In1 => In1_TB,
              In2 => In2_TB,
              ALU_Out => ALU_Out_TB,
              Sel => Sel_TB,
              Cin => Cin_TB,
              Zero => Zero_TB,
              OVF => OVF_TB
              );

stim_proc:  process
begin
    -- And Tests
    in1_TB <= "10000011";
    in2_TB <= "10000011";
    sel_TB <= "000";
    wait for period;
    
    in1_TB <= "10100011";
    in2_TB <= "10010010";
    sel_TB <= "000";
    wait for period;
    
    -- Or Test
    in1_TB <= "10000011";
    in2_TB <= "10000101";
    sel_TB <= "001";
    wait for period;
    
    in1_TB <= "10101010";
    in2_TB <= "01010101";
    sel_TB <= "001";
    wait for period;
    
    -- Unsigned Addition Test
    in1_TB <= x"20"; -- 32
    in2_TB <= x"30"; -- 48
    sel_TB <= "010";
    wait for period;
    
    in1_TB <= x"33"; -- 51
    in2_TB <= x"FF"; -- 255
    sel_TB <= "010";
    wait for period;
    
    -- Signed Addition Test
    in1_TB <= x"33"; --  51
    in2_TB <= x"80"; -- -128
    sel_TB <= "010";
    wait for period;
    
    in1_TB <= x"86"; -- -122 
    in2_TB <= x"7F"; -- 127
    sel_TB <= "010";
    wait for period;
    
    -- Xor Test
    in1_TB <= "10101010";
    in2_TB <= "01010101";
    sel_TB <= "011";
    wait for period;
    
    in1_TB <= "11010111";
    in2_TB <= "10101011";
    sel_TB <= "100";
    wait for period;
    
    -- Signed Subtraction Test
    in1_TB <= "10000011";
    in2_TB <= "10000011";
    sel_TB <= "101";
    wait for period;
    
    in1_TB <= "10000011";
    in2_TB <= "10000011";
    sel_TB <= "101";
    wait for period;
    
    -- Set on less than Test
    in1_TB <= "00000011";
    in2_TB <= "10000011";
    sel_TB <= "110";
    wait for period;
    
    in1_TB <= "00000011";
    in2_TB <= "10000011";
    sel_TB <= "110";
    wait for period;
    
    -- Branch if Equal Test
    in1_TB <= "10000011";
    in2_TB <= "10000011";
    sel_TB <= "111";
    wait for period;
    
    in1_TB <= "10000011";
    in2_TB <= "10000011";
    sel_TB <= "111";
    wait for period;
    
    wait;

end process;

end Behavioral;
