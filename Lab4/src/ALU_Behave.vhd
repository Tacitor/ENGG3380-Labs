Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity ALU_8Bit is
generic (Dwidth : integer := 8);
port(	
		In1, In2	:	in	std_logic_vector (Dwidth-1 downto 0);
		ALU_OUT : out std_logic_vector (Dwidth-1 downto 0);
		Sel	:	in	std_logic_vector(2 downto 0);
		Cin	:	in	std_logic;
		Zero, OVF : out std_logic);
End;


Architecture behavior of ALU_8Bit is

	Begin
	Process (In1, In2, Sel, Cin)
	--variable sum : signed(Dwidth downto 0); -- variable to hold sum with extra bit for overflow
	variable sum : integer := 0;
	--variable signedIn1 : signed(Dwidth-1 downto 0);
	--variable signedIn2 : signed(Dwidth-1 downto 0); --turns out don't need
	
	Begin
	    --signedIn1 := signed(In1); --turns out don't need
	    --signedIn2 := signed(In2);
		Case Sel is
			--AND
			When "000" => ALU_OUT <= In1 and In2;

			--OR
			When "001" => ALU_OUT <= In1 or In2;

			--unsinged ADD
			When "010" => ALU_OUT <= In1 + In2;
			--Does not check overflow	

			--signed ADD
			When "011" => ALU_OUT <= In1 + In2;	
			--check for overflow
			--sum := '0'& signed(In1) + '0' & signed(In2); -- extend to extra bit length to match sum size THIS IS NOT WORKING
			sum := to_integer(unsigned(In1)) + to_integer(unsigned(In2));
			if (sum > (2**(Dwidth-1)-1)) or (sum < -(2**(Dwidth-1))) then --extra bit of negative
				OVF <= '1';
			else
				OVF <= '0';
			end if;

			--example in 4 bit. highest signed positive number is 0111 = 7 => 2^3-1 = 7
			--lowest signed negative number is 1000 = -8 => -2^3 = -8
			
			--XOR
			When "100" => ALU_OUT <= In1 xor In2;

			--signed SUB
			When "101" => ALU_OUT <= In1 - In2;
			--check for overflow
			--sum :='0'& signed(In1) + '0' & signed(In2); -- extend to extra bit length to match sum size
			sum := to_integer(unsigned(In1)) + to_integer(unsigned(In2));
			if (sum > (2**(Dwidth-1))-1) or (sum < -(2**(Dwidth-1))) then --extra bit of negative
				OVF <= '1';
			else
				OVF <= '0';
			end if;
				
			--SLT
			--checkif most significant bit is 1
			When "110" => ALU_OUT <= "00000001" when (In1 < In2) else "00000000";

			--BEQ
			--Comment in document about making this independent of the selection input?
			When "111" =>  Zero <= '1' when In1 = In2 else '0';

			--Catch all if void selection line output all ZEROS
			When Others => ALU_OUT <= (7 downto 0 => '0');
		End Case;
	End Process;
	

End behavior;
