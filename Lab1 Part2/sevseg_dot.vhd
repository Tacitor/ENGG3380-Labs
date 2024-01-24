library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevseg_dot is
    Port ( int : in STD_LOGIC_VECTOR (4 downto 1);--same input vector here
			dot : in std_logic;		--as here when using component. 4-1 bits are character in hex, 0 bit is dot
           seg : out STD_LOGIC_VECTOR (7 downto 0));-- 7-1 bits are cathodes, 0 bit is dot. -- 0 is dot on, 1 is dot off
end sevseg_dot;

architecture Behavioral of sevseg_dot is
begin
    decode: process(int, dot)
    begin
        case (int) is
            when "0000" => seg <= "0000001" & dot; 	--0   
            when "0001" => seg <= "1001111" & dot; 	--1
            when "0010" => seg <= "0010010" & dot; 	--2
            when "0011" => seg <= "0000110" & dot; 	--3
            when "0100" => seg <= "1001100" & dot; 	--4
            when "0101" => seg <= "0100100" & dot; 	--5
            when "0110" => seg <= "0100000" & dot; 	--6
            when "0111" => seg <= "0001111" & dot; 	--7
            when "1000" => seg <= "0000000" & dot;  --8
            when "1001" => seg <= "0000100" & dot; 	--9
            when "1010" => seg <= "0000010" & dot;	--A
            when "1011" => seg <= "1100000" & dot;	--b
            when "1100" => seg <= "0110001" & dot;	--C
            when "1101" => seg <= "1000010" & dot;	--d
            when "1110" => seg <= "0110000" & dot;	--E
            when "1111" => seg <= "0111000" & dot;	--F
            when others => seg <= "1111110" & dot;	---
        end case;
    end process;

end Behavioral;
