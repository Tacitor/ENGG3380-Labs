library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Pattern Encoder

entity PatCoder is
    Port (code : in STD_LOGIC_VECTOR (2 downto 0);	--input coded button push maybe better to just input the button?		
			pat_0 : out STD_LOGIC_VECTOR (4 downto 0);-- 4-1 bits 7seg character in hex, 0 bit for dot
			pat_1 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_2 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_3 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_4 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_5 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_6 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_7 : out STD_LOGIC_VECTOR (4 downto 0)
			);
end PatCoder;
			
architecture Behavioral of PatCoder is
begin
    process(code)--only need to respond to changes in button. Patterns fixed and declared within
    begin
        case (code) is
			--Pattern 1. 8.8.8.8.8.8.8.8.
            when "000" =>  pat_0 <= "10000" ; --8.
                           pat_1 <= "10000" ;
                           pat_2 <= "10000" ;
                           pat_3 <= "10000" ;
                           pat_4 <= "10000" ;
                           pat_5 <= "10000" ;
                           pat_6 <= "10000" ;
                           pat_7 <= "10000" ;
						   
			--Pattern 2. AB.CD.EF.12
            when "001" =>  pat_0 <= "10101" ; --A
                           pat_1 <= "10110" ; --B.
                           pat_2 <= "10111" ; --C
                           pat_3 <= "11010" ; --D.
                           pat_4 <= "11101" ; --E
                           pat_5 <= "11110" ; --F.
                           pat_6 <= "00011" ; --1
                           pat_7 <= "00101" ; --2
						   
			--Pattern 3. 87.654321
            when "010" => pat_0 <= "10001" ; --8
                           pat_1 <= "01110" ; --7.
                           pat_2 <= "01101" ; --6
                           pat_3 <= "01011" ; --5
                           pat_4 <= "01001" ; --4
                           pat_5 <= "00111" ; --3
                           pat_6 <= "00101" ; --2
                           pat_7 <= "00011" ; --1
						   
			--Pattern 4. 20192020
            when "011" => pat_0 <= "00101" ; --2
                           pat_1 <= "00001" ; --0
                           pat_2 <= "00011" ; --1
                           pat_3 <= "10011" ; --9
                           pat_4 <= "00101" ; --2
                           pat_5 <= "00001" ; --0
                           pat_6 <= "00101" ; --2
                           pat_7 <= "00001" ; --0
						   
			--Pattern 5. 0.BAD.C0DE
            when "100" => pat_0 <= "00000" ; --0.
                           pat_1 <= "10111" ; --B
                           pat_2 <= "10101" ; --A
                           pat_3 <= "11010" ; --D.
                           pat_4 <= "11001" ; --C
                           pat_5 <= "00001" ; --0
                           pat_6 <= "11011" ; --D
                           pat_7 <= "11101" ; --E
						   
            when others => pat_0 <= "" ; --not sure what if leaving this blank
                           pat_1 <= "" ; --will get the - on the display, but 
                           pat_2 <= "" ; --that's the idea	
                           pat_3 <= "" ;
                           pat_4 <= "" ;
                           pat_5 <= "" ;
                           pat_6 <= "" ;
                           pat_7 <= "" ;
        end case;
    end process;
end Behavioral;
	

--		when "0000" => seg <= "0000001" & dot; 	--0   
--        when "0001" => seg <= "1001111" & dot; 	--1
--        when "0010" => seg <= "0010010" & dot; 	--2
--        when "0011" => seg <= "0000110" & dot; 	--3
--        when "0100" => seg <= "1001100" & dot; 	--4
--        when "0101" => seg <= "0100100" & dot; 	--5
--        when "0110" => seg <= "0100000" & dot; 	--6
--        when "0111" => seg <= "0001111" & dot; 	--7
--        when "1000" => seg <= "0000000" & dot;  --8
--        when "1001" => seg <= "0000100" & dot; 	--9
--        when "1010" => seg <= "0000010" & dot;	--A
--        when "1011" => seg <= "1100000" & dot;	--b
--        when "1100" => seg <= "0110001" & dot;	--C
--        when "1101" => seg <= "1000010" & dot;	--d
--        when "1110" => seg <= "0110000" & dot;	--E
--        when "1111" => seg <= "0111000" & dot;	--F
--        when others => seg <= "1111110" & dot;	---
		 
--		0 is dot on, 1 is dot off 


