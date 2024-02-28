----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2024 08:16:32 PM
-- Design Name: 
-- Module Name: SLT_Mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SLT_Mux is
  generic(Dwidth    :   integer := 8);
  Port (
        Sel : in  STD_LOGIC_VECTOR(2 downto 0);
        Sig_in   :  in  STD_LOGIC_VECTOR(Dwidth-1 downto 0);
        Sig_out  :  out STD_LOGIC_VECTOR(Dwidth-1 downto 0)
        );
end SLT_Mux;



architecture Behavioral of SLT_Mux is

signal Temp_Sig  :   STD_LOGIC_VECTOR(Dwidth-1 downto 0);

begin

process(Sig_in)
begin
    if(sel = "110") then
        if(Sig_in(7) = '1') then
            Temp_Sig <= "00000001";
        else
            Temp_Sig <= "00000000";
        end if;
    else
        Temp_Sig <= Sig_in;
    end if;
end process;

Sig_out <= Temp_Sig;

end Behavioral;
