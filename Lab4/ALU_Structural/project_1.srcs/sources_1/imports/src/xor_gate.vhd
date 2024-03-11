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

entity xor_gate is
    Port ( In1 : in STD_LOGIC;
           In2 : in STD_LOGIC;
           Sout : out STD_LOGIC);
end xor_gate;

architecture Behavioral of xor_gate is

begin

Sout <= in1 xor in2;

end Behavioral;
