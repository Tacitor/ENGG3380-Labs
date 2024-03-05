library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lab2mem is 
    generic ( Dwidth : integer := 4; -- Each location is 4 bits
              Awidth : integer := 3); -- 3 Address lines (i.e., 8 locations)
    port ( we,clk: in std_logic;
           addr: in std_logic_vector(Awidth-1 downto 0);
           din: in std_logic_vector(Dwidth-1 downto 0);
           dout: out std_logic_vector(Dwidth-1 downto 0) );
end lab2mem;

architecture Behavioural of lab2mem is
type memType is array(0 to 2**Awidth-1) of std_logic_vector(Dwidth-1 downto 0);

-- The first 8 locations are initialized, the rest set to 0.
signal memory: memType:= ( "0001", --0
                           "0010", --1
                           "0100", --2
                           "1000", --3
                           "0111", --4
                           "1011", --5
                           "1101", --6
                           "1110", --7
                        others=> "1111" ); 

attribute ram_style: string;
attribute ram_style of memory : signal is "block"; --Valid attributes include block, distributed and auto

begin
    process(clk)
    begin
        if(clk'event and clk='1') then
            if(we='1') then
                memory(conv_integer(addr)) <= din;
                dout <= din;
            else
                dout <= memory(conv_integer(addr));
            end if;
        end if;
        
    end process;
end Behavioural;      