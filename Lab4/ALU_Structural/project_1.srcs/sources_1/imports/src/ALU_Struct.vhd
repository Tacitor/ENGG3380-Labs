library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    generic ( Dwidth   : integer := 8);
    Port    (   IN1, IN2   :    IN  STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
                ALU_OUT    :    OUT STD_LOGIC_VECTOR    (Dwidth-1 downto 0);
                SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
                Cin        :    IN  STD_LOGIC;
                Zero, OVF  :    OUT STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

    -- SIGNALS   
    signal ALU_Out_Sig, carry  :   STD_LOGIC_VECTOR(Dwidth-1 downto 0);
    signal SubCheck, signage :   STD_LOGIC;
    
    -- COMPONENTS
    component B1ALU -- 1bit ALU
    port(
        IN1, IN2         :    IN  STD_LOGIC;
        ALU_OUT, Cout    :    OUT STD_LOGIC;
        SEL        :    IN  STD_LOGIC_VECTOR    (2 downto 0);
        Cin, Sub   :    IN  STD_LOGIC
        );
    end component;
    
    component SLT_Mux
    port(
        Sel : in  STD_LOGIC_VECTOR(2 downto 0);
        Sig_in   :  in  STD_LOGIC_VECTOR(Dwidth-1 downto 0);
        Sig_out  :  out STD_LOGIC_VECTOR(Dwidth-1 downto 0)
        );
    end component;
    
    component MultiBit_Nor
    port(
        Input   :   in STD_LOGIC_VECTOR(Dwidth-1 downto 0);
        Output  :   out STD_LOGIC
        );
    end component;

begin

-- Check if subtraction is needed for operations: Subtraction(101), SLT(110), BEQ(111), XOR does not use carry in.
subcheck <= sel(2);

-- Check for signed operations (011, 101, 110, 111).
signage <= (Sel(2) or (not Sel(2) and Sel(1) and Sel(0))) and not (Sel(2) and not Sel(1) and not Sel(0));

-- Generate outputs for each bit
ALU0 : B1ALU port map(IN1 =>in1(0),     IN2 =>in2(0),   ALU_OUT => ALU_Out_Sig(0), SEL => sel, CIN => subcheck,   COUT => carry(0),   Sub => subcheck);     
ALU1 : B1ALU port map(IN1 =>in1(1),     IN2 =>in2(1),   ALU_OUT => ALU_Out_Sig(1), SEL => sel, CIN => carry(0),   COUT => carry(1),   Sub => subcheck);
ALU2 : B1ALU port map(IN1 =>in1(2),     IN2 =>in2(2),   ALU_OUT => ALU_Out_Sig(2), SEL => sel, CIN => carry(1),   COUT => carry(2),   Sub => subcheck);
ALU3 : B1ALU port map(IN1 =>in1(3),     IN2 =>in2(3),   ALU_OUT => ALU_Out_Sig(3), SEL => sel, CIN => carry(2),   COUT => carry(3),   Sub => subcheck);     
ALU4 : B1ALU port map(IN1 =>in1(4),     IN2 =>in2(4),   ALU_OUT => ALU_Out_Sig(4), SEL => sel, CIN => carry(3),   COUT => carry(4),   Sub => subcheck);         
ALU5 : B1ALU port map(IN1 =>in1(5),     IN2 =>in2(5),   ALU_OUT => ALU_Out_Sig(5), SEL => sel, CIN => carry(4),   COUT => carry(5),   Sub => subcheck);
ALU6 : B1ALU port map(IN1 =>in1(6),     IN2 =>in2(6),   ALU_OUT => ALU_Out_Sig(6), SEL => sel, CIN => carry(5),   COUT => carry(6),   Sub => subcheck);      
ALU7 : B1ALU port map(IN1 =>in1(7),     IN2 =>in2(7),   ALU_OUT => ALU_Out_Sig(7), SEL => sel, CIN => carry(6),   COUT => carry(7),   Sub => subcheck);

-- Check for Zero Value: BEQ
zero_check : MultiBit_Nor port map(Input => ALU_Out_Sig, Output => Zero);

-- OVF Check: (MSB_Cin xor MSB_Cout) and (signed add(011) or sub(101))
OVF <= (carry(6) xor carry(7))and (signage);

Alu_Out_Mux : SLT_MUX port map(Sel => Sel, Sig_In => ALU_Out_Sig, Sig_Out => ALU_OUT);

end Behavioral;