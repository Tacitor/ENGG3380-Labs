library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
        if(sel = "110") then -- Set on less than
            -- If negative(1) set output to 1 otherwise output is zero.
            Temp_Sig(0) <= Sig_in(7);
            Temp_Sig(7 downto 1) <= "0000000";
        else
            Temp_Sig <= Sig_in;
        end if;
    end process;

    Sig_out <= Temp_Sig;

end Behavioral;
