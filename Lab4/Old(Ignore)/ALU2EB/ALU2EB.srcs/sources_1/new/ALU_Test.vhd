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
    Signal   IN1_TB, IN2_TB   :    STD_LOGIC_VECTOR    (Dwidth-1 downto 0)    := "00000000";
    Signal   SEL_TB        :    STD_LOGIC_VECTOR    (2 downto 0)           := "000";
    Signal   Cin_TB        :    STD_LOGIC      := '0';
   
 	--Outputs
    signal   ALU_Out_TB	:    STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
    signal   Zero_TB, OVF_TB  :    STD_LOGIC;
    
    --Wait time
    signal period   : time := 100ns;

begin

	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
			In1		=>	IN1_TB,
			In2		=>	In2_TB,
			Cin	    =>	Cin_TB,
			Sel		=>  Sel_TB,
			ALU_Out	=>	ALU_Out_TB,
			Zero	=>	Zero_TB,
			OVF     =>  OVF_TB
        );

test_process :   process
    begin
    
    IN1_TB <= "11111111";
    In2_TB <= "11111111";
    Sel_TB <= "000";
    wait for period;
    
    IN1_TB <= "00000000";
    In2_TB <= "11111111";
    Sel_TB <= "000";
    wait for period;
    
    end process;
end Behavioral;