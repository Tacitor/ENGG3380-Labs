library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Test is
  generic (Dwidth   :   integer := 8);
end ALU_Test;

architecture Behavioral of ALU_Test is
    --Unit Under Test
    component ALU 
        Port    (   IN1, IN2   :    IN  STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
                    ALU_OUT    :    OUT STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
                    SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
                    Cin        :    IN  STD_LOGIC;
                    Zero, OVF  :    OUT STD_LOGIC);
    end component;
    
    --Signals
    --Inputs
    signal IN1  :   STD_LOGIC_VECTOR    (Dwidth-1 downto 0) := x"00";
    signal IN2  :   STD_LOGIC_VECTOR    (Dwidth-1 downto 0) := x"00";
    signal SEL  :   STD_LOGIC_VECTOR    (2 downto 0) := "000";
    signal Cin  :   STD_LOGIC := '0';
    
    --Outputs
    Signal ALU_OUT  :   STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
    Signal Zero :   STD_LOGIC;
    Signal OVF  :   STD_LOGIC;
    
    --wait time
    signal period : time := 100ns;
begin

uut :   ALU port map(
            IN1 => IN1,
            IN2 => IN2,
            SEL => SEL,
            CIN => CIN,
            ALU_OUT => ALU_OUT ,
            ZERO => ZERO,
            OVF => OVF
            );

stim_proc   :   process
    begin
    
-- And Tests
    -- Check for Zero Flag
    IN1     <=	"00000000"; -- 0
    IN2     <=  "11111111"; -- 255
    SEL     <=  "000"; -- AND
    wait for period;
    
    -- Demonstrates transfer of bits by anding with 1s.
    IN1		<=	"11110000"; -- 240
    IN2     <=  "11010000"; -- 208
    SEL     <=  "000"; -- AND
    wait for period;
    
    
-- Or Tests
    -- Check for zero flag
    IN1     <=  "00000000"; -- 0
    IN2     <=  "00000000"; -- 0
    SEL     <=  "001"; -- OR
    wait for period;
    
    -- Demonstrates alternate transfer method,
    -- Oring with 0s allows for a transfer of bits.
    IN1     <=  "10110000"; -- 240
    IN2     <=  "00001101"; -- 0
    SEL     <=  "001"; -- OR
    wait for period;
    
    
-- Unsigned Add Tests
    -- Check for zero flag
    IN1     <=  "01000000"; -- 64
    IN2     <=  "11000000"; -- -64
    SEL     <=  "010"; -- Unsigned Add
    wait for period;
    
    -- Check if OVF flags
    IN1     <=  "10110000"; -- 176
    IN2     <=  "10000000"; -- 128
    SEL     <=  "010"; -- Unsigned Add
    wait for period;
    
    
-- Signed Add Tests
    -- Check for zero flag
    IN1     <=  "01000000"; -- 64
    IN2     <=  "11000000"; -- -64
    SEL     <=  "011"; -- Signed Add
    wait for period;
    
    -- Test for OVF
    IN1     <=  "10110000"; -- -80
    IN2     <=  "10000000"; -- -128
    SEL     <=  "011"; -- Signed Add
    wait for period;
    
    
-- Xor Tests
    IN1     <=  "11111111"; -- 255
    IN2     <=  "11111111"; -- 255
    SEL     <=  "100"; -- Xor
    wait for period;
    
    -- Shows being used for 1s compliment
    IN1     <=  "11111111"; -- 255
    IN2     <=  "00000000"; -- 0
    SEL     <=  "100"; -- Xor
    wait for period;


-- Signed Sub Tests
    -- Check for zero flag
    IN1     <=  "01000000"; -- 64
    IN2     <=  "01000000"; -- 64
    SEL     <=  "101"; -- Signed Sub
    wait for period;
    
    -- Test for OVF
    IN1     <=  "01000000"; -- 64
    IN2     <=  "11000000"; -- -64
    SEL     <=  "101"; -- Signed Sub
    wait for period;


-- Set on Less Than Tests
    -- check for zero flag
    IN1     <=  "01000000"; -- 64
    IN2     <=  "01000000"; -- 64
    SEL     <=  "110"; -- SLT
    wait for period;
    
    -- expected normal 1 output
    IN1     <=  "00000010"; -- 2
    IN2     <=  "00000100"; -- 4
    SEL     <=  "110"; -- SLT
    wait for period;    
    
    -- Test for OVF
    IN1     <=  "01000000"; -- 64
    IN2     <=  "11000000"; -- -64
    SEL     <=  "110"; -- SLT
    wait for period;  


-- Branch if Equal Tests
    -- Check for zero flag
    IN1     <=  "00000000"; -- 0
    IN2     <=  "00000000"; -- 0
    SEL     <=  "111"; -- SLT
    wait for period;
    
    -- Test for OVF
    IN1     <=  "01000000"; -- 64
    IN2     <=  "11000000"; -- -64
    SEL     <=  "111"; -- SLT
    wait for period;  
        
    wait;
end process;
end;
