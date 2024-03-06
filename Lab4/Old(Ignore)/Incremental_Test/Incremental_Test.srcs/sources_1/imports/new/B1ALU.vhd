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
    Port    (   IN1, IN2   :    IN  STD_LOGIC;
                ALU_OUT    :    OUT STD_LOGIC;
                SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
                Cin,Sub    :    IN  STD_LOGIC;
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


signal andOut, orOut, FAOut, xorOut, NB, output_sig: STD_LOGIC;

begin

NB <= IN2 xor Sub;

OutAnd  :   and_gate	port map(In1 => In1,    In2 => In2,  Sout => AndOut);
OutOr   :   or_gate     port map(In1 => In1,    In2 => In2,  Sout => orOut);                
OutFA   :   full_adder  port map(A   => In1,    B => NB,     Cin  => Cin,   Sout => FAOut,  Cout => Cout);                
OutXor  :   xor_gate    port map(In1 => in1,    In2 => in2,  Sout => XorOut);

ALU_OUT <= AndOut when sel="000" else -- And
            OrOut when sel="001" else -- Or
            FAOut when sel="010" else -- Unsigned Add
           XorOut when sel="011" else -- Xor
            FAOut when sel="100" else -- Signed Add
            FAOut when sel="101" else -- Signed Sub
            FAOut when sel="110" else -- SLT
            FAOut when sel="111"; -- BEQ

end Behavioral;
