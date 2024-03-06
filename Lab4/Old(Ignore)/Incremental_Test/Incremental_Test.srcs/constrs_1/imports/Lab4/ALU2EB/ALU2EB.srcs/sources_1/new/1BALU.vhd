library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity B1ALU is
    Port    (   IN1, IN2   :    IN  STD_LOGIC;
            ALU_OUT    :    OUT STD_LOGIC;
            SEL        :    IN  STD_LOGIC;
            Cin        :    IN  STD_LOGIC;
            Zero, OVF  :    OUT STD_LOGIC);
end B1ALU;


architecture Behavioral of B1ALU is

signal andOut, orOut, usaddOut, xorOut, saddOut, ssubOut, sltOut, beqOut : STD_LOGIC;

component and_gate
    port(
		In1		    :	in	std_logic;
        In2         :    in    std_logic;
        Sout        :    out    std_logic
        );
end component;

component full_adder
    port(
		A	:	in	std_logic;
        B    :    in    std_logic;
        Cin    :    in    std_logic;
        Sout    :    out std_logic;
        Cout:    out    std_logic
        );
end component;

component or_gate
    port(
		In1		:	in	std_logic;
        In2        :    in    std_logic;
        Sout    :    out    std_logic
        );
end component

component xor_gate
    port(
        In1 : in STD_LOGIC;
        In2 : in STD_LOGIC;
        Sout : out STD_LOGIC);
        );
begin

OutAnd  :   and_gate
    port map(
            In1 => In1;
            
            );

ALU_outSelect : process(sel)
    begin
        if sel = "000" then
            
        end if;
end pocess;

end Behavioral;
