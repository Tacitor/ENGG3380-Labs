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

    component ALU_Out_1Bit_Mux
    port(
           And_Out : in STD_LOGIC;
           Or_Out : in STD_LOGIC;
           AddU_Out : in STD_LOGIC;
           Add_Out : in STD_LOGIC;
           Xor_Out : in STD_LOGIC;
           Sub_Out : in STD_LOGIC;
           SLT_Out : in STD_LOGIC;
           BEQ_Out : in STD_LOGIC;
           Sel     : in STD_LOGIC_VECTOR(2 DOWNTO 0);
           ALU_Out : out STD_LOGIC
        );
    end component;
signal andOut, orOut, FAOut, xorOut, NB, output_sig: STD_LOGIC;

begin

NB <= IN2 xor Sub;

OutAnd  :   and_gate	port map(In1 => In1,    In2 => In2,  Sout => AndOut);
OutOr   :   or_gate     port map(In1 => In1,    In2 => In2,  Sout => orOut);                
OutFA   :   full_adder  port map(A   => In1,    B => NB,     Cin  => Cin,   Sout => FAOut,  Cout => Cout);                
OutXor  :   xor_gate    port map(In1 => in1,    In2 => in2,  Sout => XorOut);

Out_Mux :   ALU_Out_1Bit_Mux port map(
           And_Out  => AndOut,
           Or_Out   => OrOut,
           AddU_Out => FAOut,
           Add_Out  => FAOut,
           Xor_Out  => XorOut,
           Sub_Out  => FAOut,
           SLT_Out  => FAOut,
           BEQ_Out  => FAOut,
           Sel      => Sel,
           ALU_Out  =>ALU_Out);

end Behavioral;
