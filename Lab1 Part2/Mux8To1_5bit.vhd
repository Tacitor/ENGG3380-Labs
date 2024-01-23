library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux8To1_5bit is
    Port (	I_0 : in std_logic_vector(4 downto 0); --4-1 bits are character, 0 bit is dot
			I_1 : in std_logic_vector(4 downto 0); -- 0 is dot on, 1 is dot off
			I_2 : in std_logic_vector(4 downto 0);
			I_3 : in std_logic_vector(4 downto 0);
			I_4 : in std_logic_vector(4 downto 0);
			I_5 : in std_logic_vector(4 downto 0);
			I_6 : in std_logic_vector(4 downto 0);
			I_7 : in std_logic_vector(4 downto 0);
			S : in  std_logic_vector(2 downto 0); --selection by clk div
			Z : out  std_logic_vector(4 downto 0); --out
			);  
end Mux8To1_5bit;

architecture Behavioral of Mux8To1_5bit is

begin
	process(S, I_0, I_1, I_2, I_3, I_4, I_5, I_6, I_7)
		case S is
            when "000" => Z <= I_0;
            when "001" => Z <= I_1;  
			when "010" => Z <= I_2;
			when "011" => Z <= I_3;
            when "100" => Z <= I_4;  
			when "101" => Z <= I_5;
            when "110" => Z <= I_6;  
			when "111" => Z <= I_7;
        end case;
	end process
end Behavioral;
