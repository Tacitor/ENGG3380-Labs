library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Test is
    generic ( Dwidth   : integer := 8);
end ALU_Test;

architecture Behavioral of ALU_Test is

component ALU
    port(
        IN1, IN2   :    IN  STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
        ALU_OUT    :    OUT STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
        SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
        Cin        :    IN  STD_LOGIC;
        Zero, OVF  :    OUT STD_LOGIC
        );
end component;

   --Inputs
    Signal   IN1, IN2   :    STD_LOGIC_VECTOR    (Dwidth-1 downto 0)    := "00000000";
    Signal   SEL        :    STD_LOGIC_VECTOR    (2 downto 0)           := "000";
    Signal   Cin        :    STD_LOGIC      := '0';
   
 	--Outputs
    signal   ALU_Out	:    STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
    signal   Zero, OVF  :    STD_LOGIC;
    
    --Wait time
    signal period   : time := 100ns;

begin

	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
			In1		=>	In1,
			In2		=>	In2,
			Cin	    =>	Cin,
			Sel		=>  Sel,
			ALU_Out	=>	ALU_Out,
			Zero	=>	Zero,
			OVF     =>  OVF
        );

test_process :   process
    begin
    
    In1 <= "11111111";
    In2 <= "11111111";
    Sel <= "000";
    wait for period;
    
    In1 <= "00000000";
    In2 <= "11111111";
    Sel <= "000";
    wait for period;
    
    end process;
end Behavioral;