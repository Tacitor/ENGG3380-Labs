library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity regfile is
	generic (
		Dwidth : integer := 16; -- Each register is 16 bits
		Awidth : integer := 4 -- 16 registers
	);
	port (
		ReadA1, ReadA2, WriteA: in std_logic_vector(Awidth-1 downto 0);
		Data01, Data02 : out std_logic_vector(Dwidth-1 downto 0);
		DataIn: in std_logic_vector(Dwidth-1 downto 0);
		WE, CLK: in std_logic);
end regfile;

architecture Behavioral of regfile is
	type regType is array(0 to 2**Awidth-1) of std_logic_vector(Dwidth-1 downto 0);
	signal registers: regType := (others => (others => '0'));

begin
	process(CLK)
	begin
		if (clk'event and clk='1') then
			if WE = '1' then
				registers(conv_integer(WriteA)) <= DataIn;
			end if;
			
			Data01 <= registers(conv_integer(ReadA1));
			Data02 <= registers(conv_integer(ReadA2));
			
		end if;
	end process;
end Behavioral;
