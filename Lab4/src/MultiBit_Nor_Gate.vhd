library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MultiBit_Nor is
    generic(Dwidth  :   integer := 8);
    Port ( Input : in STD_LOGIC_VECTOR (dwidth-1 downto 0);
           Output : out STD_LOGIC);
end MultiBit_Nor;

architecture Behavioral of MultiBit_Nor is

begin

Output <= Not(Input(0) or Input(1) or Input(2) or Input(3) or Input(4) or Input(5) or Input(6) or Input(7));

end Behavioral;
