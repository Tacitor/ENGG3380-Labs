Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity ALU is
generic (Dwidth : integer := 8);
port(	
		In1, In2	:	in	std_logic_vector (Dwidth-1 downto 0);
		ALU_OUT : out std_logic_vector (Dwidth-1 downto 0);
		Sel	:	in	std_logic_vector(2 downto 0);
		Cin	:	in	std_logic;
		Zero, OVF : out std_logic);
End;


Architecture behavior of ALU is

Begin
	Process (In1, In2, Sel, Cin)
	Begin
		Case Sel is
			--AND
			When "000" =>  ALU_OUT <= In1 and In2;
			--OR
			When "001" =>  ALU_OUT <= In1 or In2;
			--unsinged ADD
			When "010" =>  ALU_OUT <= unsigned(In1) + unsigned(In2) + unsigned(Cin);
				--does this check overflow?		
			--signed ADD
			When "011" =>  ALU_OUT <= signed(In1) + signed(In)2 + signed(Cin);			
			OVF <= '1' when (to_ineger(In1) + to_integer(In2) + to_integer(Cin) > 2**Dwidth) else "0";
			--XOR
			When "100" =>  ALU_OUT <= In1 xor In2;
			--signed SUB
			When "101" =>  ALU_OUT <= signed(In1) - signed(In2);
			OVF <= '1' when (to_ineger(In1) - to_integer(In2) + to_integer(Cin) < 2**Dwidth) else "0";
			--SLT
			--checkif most significant bit is 1
			When "110" =>  ALU_OUT <= '1' when In1 < In2 else '0';
			--BEQ
			--use zero output
			When "111" =>  ALU_OUT <= (others => '0');
			When Others => ALU_OUT <= '0';
		End Case;
	End Process;
	

End behavior;
