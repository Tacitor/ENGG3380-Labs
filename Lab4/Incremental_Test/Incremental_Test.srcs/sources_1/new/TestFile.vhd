library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
   signal in1 	: std_logic_vector(Dwidth-1 downto 0) := "00000000";
   signal in2 	: std_logic_vector(Dwidth-1 downto 0) := "00000000";
   signal Cin 	: std_logic := '0';
   signal Sel	: std_logic_vector(2 downto 0) := "000";
   
 	--Outputs
   signal ALU_Out	: std_logic_vector(Dwidth-1 downto 0);
   signal Zero	: std_logic;
   signal OVF	: std_logic;
   
   --Wait time
   signal period    :   time := 100 ns;

begin

uut:    ALU port map(
              In1 => In1,
              In2 => In2,
              ALU_Out => ALU_Out,
              Sel => Sel,
              Cin => Cin,
              Zero => Zero,
              OVF => OVF
              );

stim_proc:  process
begin
--    -- And Test
--    in1 <= "10000011";
--    in2 <= "10000011";
--    sel <= "000";
--    wait for period;
    
--    -- Or Test
--    in1 <= "10000011";
--    in2 <= "10000101";
--    sel <= "001";
--    wait for period;
    
--    -- Unsigned Addition Test
--    in1 <= "00000000";
--    in2 <= "00000000";
--    sel <= "010";
--    wait for period;
    
--    -- Xor Test
--    in1 <= "10000011";
--    in2 <= "10000101";
--    sel <= "011";
--    wait for period;
    
    -- Signed Addition Test
    in1 <= "10000011";
    in2 <= "10000011";
    sel <= "100";
    wait for period;
    
    -- Signed Subtraction Test
    in1 <= "10000011";
    in2 <= "10000011";
    sel <= "101";
    wait for period;
    
    -- Set on less than Test
    in1 <= "00000011";
    in2 <= "10000011";
    sel <= "110";
    wait for period;
    
    -- Branch if Equal Test
    in1 <= "10000011";
    in2 <= "10000011";
    sel <= "111";
    wait for period;
    
    wait;

end process;

end Behavioral;
