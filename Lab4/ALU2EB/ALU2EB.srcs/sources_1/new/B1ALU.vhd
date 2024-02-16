----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2024 08:22:16 PM
-- Design Name: 
-- Module Name: B1ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity B1ALU is
    Port    (   IN1, IN2, IN2_COMP :    IN  STD_LOGIC;
                ALU_OUT    :    OUT STD_LOGIC;
                SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
                Cin        :    IN  STD_LOGIC;
                Cout       :    OUT STD_LOGIC);
end B1ALU;

architecture Behavioral of B1ALU is

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
    
	component or_gate
    port(    
        In1        :    in    std_logic;
        In2        :    in    std_logic;
        Sout    :    out    std_logic
        );
    end component;
    
    component xor_gate
    port(
        In1         :   in std_logic;
        In2         :   in std_logic;
        Sout        :   out std_logic
        );
    end component;
    
    component  signed_Adder
    port(
        In1         :   in std_logic;
        In2         :   in std_logic;
        Cin         :   in std_logic;
        Sout        :   out std_logic;
        Cout        :   out std_logic
        );        
    end component;
    
signal andOut, orOut, FAOut, FACout, xorOut, sltOut, beqOut : STD_LOGIC;

begin


OutAnd  :   and_gate	port map(
                In1    => In1,
                In2    => In2,
                Sout   => andOut
                );
                
OutOr   :   or_gate     port map(
                In1 => In1,
                In2 => In2,
                Sout => orOut
                );
                
OutFA   :   full_adder port map(    
                A => In1,
                B => In2,
                Cin => Cin,
                Sout => FAOut,
                Cout => FACout
                );
                
OutXor  :       xor_gate port map(
                In1 => in1,
                In2 => in2,
                Sout => xorOut
                );

ALU_outSelect : process(sel)
    begin
        if(sel = "000") then -- AND
            ALU_OUT <= andOut;
            Cout <= '0';
            
        elsif sel = "001" then -- OR
            ALU_OUT <= orOut;
            Cout <= '0';
            
        elsif sel = "010" then -- Unsigned Add
            ALU_OUT <= FAOut;
            
        elsif(sel = "011") then -- XOR
            ALU_OUT <= xorOut;
            Cout <= '0';
            
        elsif(sel = "100") then -- Signed Add
            ALU_OUT <= FAOut;
            Cout <= FACOut;
            
        elsif(sel = "101") then -- Signed Sub
            ALU_OUT <= FAOut;
            Cout <= FACOut;
            
        elsif(sel = "110") then -- SLT
            ALU_OUT <= sltOut;
            Cout <= '0';
            
        elsif(sel = "111") then -- BEQ
            ALU_OUT <= beqOut;
            Cout <= '0';

        end if;
    end process;
end Behavioral;
