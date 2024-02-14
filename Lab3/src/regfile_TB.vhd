library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity regfile_TB is
end regfile_TB;

architecture behavior of regfile_TB is

component regfile is
	generic (
		Dwidth : integer := 16; -- Each register is 16 bits
		Awidth : integer := 4 -- 16 registers
	);
	port (
		ReadA1, ReadA2, WriteA: in std_logic_vector(Awidth-1 downto 0);
		Data01, Data02 : out std_logic_vector(Dwidth-1 downto 0);
		DataIn: in std_logic_vector(Dwidth-1 downto 0);
		WE, CLK: in std_logic);
end component;

constant tick : time := 5 ns;

--Declare signals

signal ReadA1, ReadA2, WriteA: std_logic_vector(3 downto 0);
signal Data01, Data02, DataIn: std_logic_vector(15 downto 0);
signal WE, CLK: std_logic;

BEGIN

uut:regfile 
generic map(16,4)
port map(   
    ReadA1 => ReadA1,
    ReadA2 => ReadA2,
    WriteA => WriteA,
    Data01 => Data01,
    Data02 => Data02,
    DataIn => DataIn,
    WE => WE,
    CLK => CLK
);
 

test : process
begin
    
    CLK <= '0';
    wait for tick;
    WE <= '0';
    DataIn <= "0000000000000000";
    --ReadA1 <= "0000";
    --ReadA2 <= "0000";
    WriteA <= "0000";
    CLK <= '1';
    wait for tick;

    --write 1 in address 1
    CLK <= '0';
    wait for tick;
    WE <= '1';
    DataIn <= "0000000000000001";
    WriteA <= "0001";
    CLK <= '1';
    wait for tick;

    --read from address 1 at Data01 port
    CLK <= '0';
    wait for tick;
    ReadA1 <= "0001";
    WE <= '0';
    CLK <= '1';
    wait for tick;

    --write 2 in address 2
    CLK <= '0';
    wait for tick;
    WE <= '1';
    DataIn <= "0000000000000010";
    WriteA <= "0010";
    CLK <= '1';
    wait for tick;

    --read from address 2 at Data02 port
    CLK <= '0';
    wait for tick;
    ReadA2 <= "0010";
    WE <= '0';
    CLK <= '1';
    wait for tick;

    --write 3 in address 3
    CLK <= '0';
    wait for tick;
    WE <= '1';
    DataIn <= "0000000000000011";
    WriteA <= "0011";
    CLK <= '1';
    wait for tick;

    --read from address3 at Data01 port
    CLK <= '0';
    wait for tick;
    ReadA1 <= "0011";
    WE <= '0';
    CLK <= '1';
    wait for tick;

    
    end process;

END;     
