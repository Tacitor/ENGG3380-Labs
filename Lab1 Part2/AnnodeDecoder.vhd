-- Lab Group 37

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AnnodeDecoder is
    port (
		CLK_DIV: in std_logic_vector(2 downto 0); -- b bits "000"
		AN_o: out std_logic_vector(7 downto 0); --8 bits to select the annode to display on 
end AnnodeDecoder;

architecture dataflow of AnnodeDecoder is

begin

	AN <= "00000001" when X <= "000" else
		  "00000010" when X <= "001" else
		  "00000100" when X <= "010" else
		  "00001000" when X <= "011" else
		  "00010000" when X <= "100" else
		  "00100000" when X <= "101" else
		  "01000000" when X <= "110" else
		  "10000000" when X <= "111";

end dataflow;