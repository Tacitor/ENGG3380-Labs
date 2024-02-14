library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevseg_dec is
    Port ( int : in STD_LOGIC_VECTOR (3 downto 0);--same input vector here
           seg : out STD_LOGIC_VECTOR (7 downto 0));-- 7-1 bits are cathodes, 0 bit is dot. -- 0 is dot on, 1 is dot off
end sevseg_dec;

architecture Behavioral of sevseg_dec is
begin
    decode: process(int)
    begin
        case (int) is
            when "0000" => seg <= "11000000" ; 	--0
            when "0001" => seg <= "11111001" ; 	--1
            when "0010" => seg <= "10100100" ; 	--2
            when "0011" => seg <= "10110000" ; 	--3
            when "0100" => seg <= "10011001" ; 	--4
            when "0101" => seg <= "10001001" ; 	--5
            when "0110" => seg <= "10000010" ; 	--6
            when "0111" => seg <= "11111000" ; 	--7
            when "1000" => seg <= "10000000" ;  --8
            when "1001" => seg <= "10011000" ; 	--9
            when "1010" => seg <= "10001000" ;		--A
            when "1011" => seg <= "10000011" ;		--b
            when "1100" => seg <= "11100110" ;		--C
            when "1101" => seg <= "10100001" ;		--d
            when "1110" => seg <= "10000110" ;		--E
            when "1111" => seg <= "10001110" ;		--F
            when others => seg <= "11111110" ;		---
        end case;
    end process;

end Behavioral;
