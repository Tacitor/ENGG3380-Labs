----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2024 05:29:05 PM
-- Design Name: 
-- Module Name: 1BALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity B1ALU is
    Port    (   IN1, IN2   :    IN  STD_LOGIC;
            ALU_OUT    :    OUT STD_LOGIC;
            SEL        :    IN  STD_LOGIC;
            Cin        :    IN  STD_LOGIC;
            Zero, OVF  :    OUT STD_LOGIC);
end B1ALU;


architecture Behavioral of B1ALU is

signal andOut, orOut, usaddOut, xorOut, saddOut, ssubOut, sltOut, beqOut : STD_LOGIC;

begin

ALU_outSelect : process(sel)
    begin
        if sel = "000" then
            
        end if;
end pocess;

end Behavioral;
