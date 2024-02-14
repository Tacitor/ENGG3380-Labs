----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2024 07:12:26 PM
-- Design Name: 
-- Module Name: HW_Demo_Main - Structural
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

entity HW_Demo_Main is

    port ( hundo_meg_osc: in std_logic;
           addr_m: in std_logic_vector(2 downto 0);
           din_in: in std_logic_vector(3 downto 0);
           we_pin: in std_logic;
           dout_out: out std_logic_vector(3 downto 0);
           sev_seg_an: out std_logic_vector(7 downto 0);
           sev_seg_out: out std_logic_vector(7 downto 0) );

end HW_Demo_Main;

architecture Structural of HW_Demo_Main is

    COMPONENT lab2mem is 
        generic ( Dwidth : integer := 4; -- Each location is 4 bits
                  Awidth : integer := 3); -- 3 Address lines (i.e., 8 locations)
        port ( we,clk: in std_logic;
               addr: in std_logic_vector(Awidth-1 downto 0);
               din: in std_logic_vector(Dwidth-1 downto 0);
               dout: out std_logic_vector(Dwidth-1 downto 0) );
    end COMPONENT;
    
    COMPONENT sevseg_dec is
        Port ( int : in STD_LOGIC_VECTOR (3 downto 0);--same input vector here
               seg : out STD_LOGIC_VECTOR (7 downto 0));-- 7-1 bits are cathodes, 0 bit is dot. -- 0 is dot on, 1 is dot off
    end COMPONENT;
    
    --signals
    signal dout_m : std_logic_vector(3 downto 0);

begin

    sev_seg_an <= "11111110";

    my_ram: lab2mem 
        generic map(4,3) 
        port map(we_pin, hundo_meg_osc, addr_m, din_in, dout_m);
        
    dout_out <= dout_m;
        
    le_decoder: sevseg_dec
        port map(dout_m, sev_seg_out);


end Structural;
