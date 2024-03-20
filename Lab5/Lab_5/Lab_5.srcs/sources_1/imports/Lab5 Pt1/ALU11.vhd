LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
PORT(
		A			:	IN	STD_LOGIC;
		B			:	IN	STD_LOGIC;
		Cin		:	IN	STD_LOGIC;
		S			:	IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		Sout	:	OUT STD_LOGIC;
		Cout	:	OUT	STD_LOGIC
);
End;

ARCHITECTURE behavior OF ALU IS
    COMPONENT full_adder
	PORT(
			A			:	IN	STD_LOGIC;
			B			:	IN	STD_LOGIC;
			Cin		:	IN	STD_LOGIC;
			Sout	:	OUT STD_LOGIC;
			Cout	:	OUT	STD_LOGIC
		);
    END COMPONENT;

	COMPONENT MUX31
	PORT(
			Input1		:	IN	STD_LOGIC;
			Input2		:	IN	STD_LOGIC;
			Input3		:	IN	STD_LOGIC;
			S			:	IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
			Sout		:	OUT	STD_LOGIC
		);
	END COMPONENT;

	COMPONENT and_gate
	PORT(
			In1		:	IN	STD_LOGIC;
			In2		:	IN	STD_LOGIC;
			Sout	:	OUT	STD_LOGIC
		);
	END COMPONENT;

	COMPONENT or_gate
	PORT(
			In1		:	IN	STD_LOGIC;
			In2		:	IN	STD_LOGIC;
			Sout	:	OUT	STD_LOGIC
		);
	END COMPONENT;

--Signals Defination
SIGNAL NB 							: STD_LOGIC;
SIGNAL Sout_full_adder 	: STD_LOGIC;
SIGNAL Sout_and_gate		: STD_LOGIC;
SIGNAL Sout_or_gate 		: STD_LOGIC;

BEGIN
	NB <= B XOR S(0);
	C1:full_adder	port map(
		A			=> A,
		B			=> NB,
		Cin		=> Cin,
		Sout	=> Sout_full_adder,
		Cout	=> Cout
	);

	C2:and_gate	port map(
		In1		=>	A,
		In2		=> B,
		Sout	=> Sout_and_gate
	);

	C3:or_gate port map(
		In1		=>	A,
		In2		=>	B,
		Sout	=>	Sout_or_gate
	);

	C4:MUX31 port map(
		Input1	=> Sout_full_adder,
		Input2	=>	Sout_and_gate,
		Input3	=> Sout_or_gate,
		S				=> S,
		Sout		=> Sout
	);

END;
