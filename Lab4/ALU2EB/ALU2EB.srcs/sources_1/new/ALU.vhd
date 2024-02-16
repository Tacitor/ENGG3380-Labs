library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

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
signal compcheck, carry:   STD_LOGIC;
    
    -- COMPONENTS
    component B1ALU -- 1bit ALU
    port(
        IN1, IN2, IN2_COMP :    IN  STD_LOGIC;
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


-- Check if a 2's compliment is needed
compCheck <= sel(2) and (sel(1) or sel(0));
process(compCheck)
    begin
        if compCheck = '1' then
            -- One's compliment
            in2_inv <= not in2;
        end if;
end process;
    
    -- The add 1 part of 2's compliment
    in2CompGenerate1 :   full_adder  port map(  A => in2_inv(0),
                                                B => '1', 
                                                Cin => '0', 
                                                Cout => carry, 
                                                Sout => in2_Comp(0));
                                                
    in2CompGenerate2 :   full_adder  port map(  A => in2_inv(1),
                                                B => '0', 
                                                Cin => carry, 
                                                Cout => carry, 
                                                Sout => in2_Comp(1));
                                                
    in2CompGenerate3 :   full_adder  port map(  A => in2_inv(2),
                                                B => '0', 
                                                Cin => carry, 
                                                Cout => carry, 
                                                Sout => in2_Comp(2));
                                                
    in2CompGenerate4 :   full_adder  port map(  A => in2_inv(3),
                                                B => '0', 
                                                Cin => carry, 
                                                Cout => carry, 
                                                Sout => in2_Comp(3));
                                                
    in2CompGenerate5 :   full_adder  port map(  A => in2_inv(4),
                                                B => '0', 
                                                Cin => carry, 
                                                Cout => carry, 
                                                Sout => in2_Comp(4));
                                                
    in2CompGenerate6 :   full_adder  port map(  A => in2_inv(5),
                                                B => '0', 
                                                Cin => carry, 
                                                Cout => carry, 
                                                Sout => in2_Comp(5));
                                                
    in2CompGenerate7 :   full_adder  port map(  A => in2_inv(6),
                                                B => '0', 
                                                Cin => carry, 
                                                Cout => carry, 
                                                Sout => in2_Comp(6));
                                                
    in2CompGenerate8 :   full_adder  port map(  A => in2_inv(7),
                                                B => '0', 
                                                Cin => carry, 
                                                Cout => carry, 
                                                Sout => in2_Comp(7));


-- Generate outputs for each bit
ALU0 : B1ALU port map(IN1 =>in1(0),
                      IN2 =>in2(0),
                      IN2_COMP => in2_comp(0), 
                      ALU_OUT => ALU_temp_Out(0),
                      SEL => sel,
                      CIN => cin,
                      COUT => carry);     
                                      
ALU1 : B1ALU port map(IN1 =>in1(1),
                      IN2 =>in2(1), 
                      IN2_COMP => in2_comp(1), 
                      ALU_OUT => ALU_temp_Out(1),
                      SEL => sel,
                      CIN => carry,
                      COUT => carry);
                      
ALU2 : B1ALU port map(IN1 =>in1(2),
                      IN2 =>in2(2), 
                      IN2_COMP => in2_comp(2), 
                      ALU_OUT => ALU_temp_Out(2),
                      SEL => sel,
                      CIN => carry,
                      COUT => carry);
                      
ALU3 : B1ALU port map(IN1 =>in1(3),
                      IN2 =>in2(3), 
                      IN2_COMP => in2_comp(3), 
                      ALU_OUT => ALU_temp_Out(3),
                      SEL => sel,
                      CIN => cin,
                      COUT => carry);     
                                        
ALU4 : B1ALU port map(IN1 =>in1(4),
                      IN2 =>in2(4), 
                      IN2_COMP => in2_comp(4), 
                      ALU_OUT => ALU_temp_Out(4),
                      SEL => sel,
                      CIN => carry,
                      COUT => carry);         
                                     
ALU5 : B1ALU port map(IN1 =>in1(5),
                      IN2 =>in2(5), 
                      IN2_COMP => in2_comp(5), 
                      ALU_OUT => ALU_temp_Out(5),
                      SEL => sel,
                      CIN => carry,
                      COUT => carry);
                      
ALU6 : B1ALU port map(IN1 =>in1(6),
                      IN2 =>in2(6), 
                      IN2_COMP => in2_comp(6), 
                      ALU_OUT => ALU_temp_Out(6),
                      SEL => sel,
                      CIN => carry,
                      COUT => carry);      
                                       
ALU7 : B1ALU port map(IN1 =>in1(7),
                      IN2 =>in2(7), 
                      IN2_COMP => in2_comp(7), 
                      ALU_OUT => ALU_temp_Out(7),
                      SEL => sel,
                      CIN => carry,
                      COUT => carry);

OVF <= carry;

process (sel) -- Check for Branch if Equal and Set if Less Than
begin
    if sel = "111" then -- BEQ
        if ALU_Temp_Out = "00000000" then
            Zero <= '1';
            ALU_Out <= ALU_Temp_Out;
        end if;
    
    elsif sel = "110" then -- SLT
        if ALU_Temp_Out(7) = '1' then -- negative(Check MSB)
            ALU_Out <= "00000001";
        end if;
    elsif (sel = ("100" or "101")) then -- Signed Add/Sub
        if carry = '1' then
            OVF <= carry;
        end if;
    else    -- No special conditions
        ALU_Out <= ALU_Temp_Out;
    end if;
    
end process;

end Behavioral;
