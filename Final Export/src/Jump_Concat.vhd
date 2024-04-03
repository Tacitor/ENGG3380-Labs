----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 10:38:41 AM
-- Design Name: 
-- Module Name: Jump_Concat - Behavioral
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

entity Jump_Concat is
    Port ( Address : in STD_LOGIC_VECTOR(11 DOWNTO 0);
           PC : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           PC_Jump : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end Jump_Concat;

architecture Behavioral of Jump_Concat is

begin

    PC_Jump <= PC(15 DOWNTO 12) & Address;

end Behavioral;
