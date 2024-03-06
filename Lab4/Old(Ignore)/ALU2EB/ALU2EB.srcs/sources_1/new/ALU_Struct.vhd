library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    generic ( Dwidth   : integer := 8);
    Port    (   IN1, IN2   :    IN  STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
                ALU_OUT    :    OUT STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
                SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
                Cin        :    IN  STD_LOGIC;
                Zero, OVF  :    OUT STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
    -- SIGNLS   
signal in2_inv, ALU_temp_Out, in2_comp, empty  :   STD_LOGIC_VECTOR(Dwidth-1 downto 0);
signal SubCheck, carry:   STD_LOGIC;

    -- COMPONENTS
    component B1ALU -- 1bit ALU
    port(
        IN1, IN2         :    IN  STD_LOGIC;
        ALU_OUT, Cout    :    OUT STD_LOGIC;
        SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
        Cin        :    IN  STD_LOGIC
        );
    end component;

    COMPONENT full_adder
	port(	
		A	:	in	std_logic;
		B	:	in	std_logic;
		Cin	:	in	std_logic;
		Sout	:	out std_logic;
		Cout:	out	std_logic
		);
    END COMPONENT;
    
    component and_gate
        port(    
            In1        :    in    std_logic;
            In2        :    in    std_logic;
            Sout    :    out    std_logic
            );
    end component;
begin

-- Check if subtraction is needed for operations: Subtraction, SLT, BEQ.
SubCheck <= sel(2);

-- Generate outputs for each bit
ALU0 : B1ALU port map(IN1 =>in1(0),     IN2 =>in2(0),   ALU_OUT => ALU_Temp_Out(0), SEL => sel, CIN => SubCheck,COUT => carry);     
ALU1 : B1ALU port map(IN1 =>in1(1),     IN2 =>in2(1),   ALU_OUT => ALU_Temp_Out(1), SEL => sel, CIN => carry,   COUT => carry);
ALU2 : B1ALU port map(IN1 =>in1(2),     IN2 =>in2(2),   ALU_OUT => ALU_Temp_Out(2), SEL => sel, CIN => carry,   COUT => carry);
ALU3 : B1ALU port map(IN1 =>in1(3),     IN2 =>in2(3),   ALU_OUT => ALU_Temp_Out(3), SEL => sel, CIN => carry,   COUT => carry);     
ALU4 : B1ALU port map(IN1 =>in1(4),     IN2 =>in2(4),   ALU_OUT => ALU_Temp_Out(4), SEL => sel, CIN => carry,   COUT => carry);         
ALU5 : B1ALU port map(IN1 =>in1(5),     IN2 =>in2(5),   ALU_OUT => ALU_Temp_Out(5), SEL => sel, CIN => carry,   COUT => carry);
ALU6 : B1ALU port map(IN1 =>in1(6),     IN2 =>in2(6),   ALU_OUT => ALU_Temp_Out(6), SEL => sel, CIN => carry,   COUT => carry);      
ALU7 : B1ALU port map(IN1 =>in1(7),     IN2 =>in2(7),   ALU_OUT => ALU_Temp_Out(7), SEL => sel, CIN => carry,   COUT => OVF);

process (sel) -- Output management.
begin
--    if sel = "111" then -- BEQ
--        if ALU_Temp_Out = "00000000" then
--            Zero <= '1';
--            ALU_Out <= ALU_Temp_Out;
--        end if;

--    elsif sel = "110" then -- SLT
--        if ALU_Temp_Out(7) = '1' then -- negative(Check MSB)
--            ALU_Out <= "00000001";
--        end if;

--    elsif (sel = ("100" or "101")) then -- Signed Add/Sub
--        if carry = '1' then
--            OVF <= carry;
--        end if;

--    else    -- No special conditions
--        ALU_Out <= ALU_Temp_Out;
--    end if;
    if(sel = "000") then -- AND
        ALU_OUT <= ALU_Temp_Out;
        
    elsif sel = "001" then -- OR
        ALU_OUT <= ALU_Temp_Out;
        
    elsif sel = "010" then -- Unsigned Add
        ALU_OUT <= ALU_Temp_Out;
        
    elsif(sel = "011") then -- Signed Add 
--        if carry = '1' then
--            OVF <= carry;
--        end if;
        
    elsif(sel = "100") then -- XOR
        ALU_OUT <= ALU_Temp_Out;
        
    elsif(sel = "101") then -- Signed Sub
--        if carry = '1' then
--            OVF <= carry;
--        end if;
        
    elsif(sel = "110") then -- SLT
--        if ALU_Temp_Out(7) = '1' then -- negative(Check MSB)
--            ALU_Out <= "00000001";
--        end if;
        
    elsif(sel = "111") then -- BEQ
--        if ALU_Temp_Out = "00000000" then
--            Zero <= '1';
--            ALU_Out <= ALU_Temp_Out;
--        end if;

    end if;
end process;

end Behavioral;
