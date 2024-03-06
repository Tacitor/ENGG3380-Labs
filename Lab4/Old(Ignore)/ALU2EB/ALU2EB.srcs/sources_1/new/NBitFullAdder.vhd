library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NBitFullAdder is
    generic ( nbits   : integer := 8);
    Port ( A, B : in STD_LOGIC_VECTOR(nbits-1 downto 0);
           Cin : in STD_LOGIC;
           Sout : out STD_LOGIC_VECTOR(nbits-1 downto 0);
           Cout : out STD_LOGIC);
end NBitFullAdder;

architecture Behavioral of NBitFullAdder is

signal carry : STD_LOGIC_vector(nbits downto 0);

begin

    process is
    begin
    carry(0) <= Cin;
        for i in (nbits - 1) downto 0 loop
            wait for 1 ps;
            Sout(i) <= A(i) xor B(i) xor carry(i);
            carry(i+1) <= (A(i) and B(i)) or ((A(i) Xor B(i)) and carry(i));
            
        end loop;
    end process;
    Cout <= Carry(nbits);
end Behavioral;