----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2024 01:25:39 PM
-- Design Name: 
-- Module Name: Nand_Gate - Behavioral
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

entity Nand_Gate is
    Port ( In1 : in STD_LOGIC;
           In2 : in STD_LOGIC;
           Sout : out STD_LOGIC);
end Nand_Gate;

architecture Behavioral of Nand_Gate is

begin

    Sout <= in1 nand in2;

end Behavioral;
