----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 08:58:44 AM
-- Design Name: 
-- Module Name: ALU_Out_1Bit_Mux - Behavioral
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

entity ALU_Out_1Bit_Mux is
    Port ( And_Out : in STD_LOGIC;
           Or_Out : in STD_LOGIC;
           AddU_Out : in STD_LOGIC;
           Add_Out : in STD_LOGIC;
           Xor_Out : in STD_LOGIC;
           Sub_Out : in STD_LOGIC;
           SLT_Out : in STD_LOGIC;
           BEQ_Out : in STD_LOGIC;
           Sel     : in STD_LOGIC_VECTOR(2 DOWNTO 0);
           ALU_Out : out STD_LOGIC);
end ALU_Out_1Bit_Mux;

architecture Behavioral of ALU_Out_1Bit_Mux is

begin

ALU_OUT <= And_Out when sel="000" else -- And
            Or_Out when sel="001" else -- Or
            AddU_Out when sel="010" else -- Unsigned Add
            Add_Out when sel="011" else -- Signed Add
           Xor_Out when sel="100" else -- Xor
            Sub_Out when sel="101" else -- Signed Sub
            SLT_Out when sel="110" else -- SLT
            BEQ_Out when sel="111"; -- BEQ

end Behavioral;
