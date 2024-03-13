LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CPU_3380 IS
	PORT(
		clk					: IN STD_LOGIC;
		clear 			: IN STD_LOGIC;
		instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
 	);
END CPU_3380;

architecture Behavioral OF CPU_3380 IS
	COMPONENT ALU_16Bit
		PORT(
			A			:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
			B			:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
			S			:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
			Sout	:	OUT 	STD_LOGIC_VECTOR(15 DOWNTO 0);
			Cout	:	OUT		STD_LOGIC
		);
	END COMPONENT;

	COMPONENT Registers  --changed from RegisterFile
		PORT(
			clk			:	IN	 STD_LOGIC;													-- positive edge triggered clock
			clear		:	IN   STD_LOGIC;													-- asynchronous reset

			a_addr	:	IN	 STD_LOGIC_VECTOR( 3 DOWNTO 0);			-- register select for input a
			a_data	:	IN	 STD_LOGIC_VECTOR(15 DOWNTO 0);			-- input data port
			load		:	IN	 STD_LOGIC;													-- load enable/enable signal for "loading"

			b_addr	:	IN	 STD_LOGIC_VECTOR( 3 DOWNTO 0); 		-- register select for output b
			c_addr	:	IN	 STD_LOGIC_VECTOR( 3 DOWNTO 0); 		-- register select for output c

			b_data	:	OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);			-- first output data port
			c_data	:	OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)				-- second output data port
		);
	End COMPONENT;

	-- Signals
	SIGNAL cout			: STD_LOGIC;
	SIGNAL op 			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rs			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rt			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rd			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Sout_ALU	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL rs_data	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL rt_data	: STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	--------------------------------------------------------------------------
	-- Instruction Fetch
	--------------------------------------------------------------------------
	-- TODO: Map the following to their corresponding instruction bits: op, rd, rs, rt
	op <= instruction(15 DOWNTO 12);
	rd <= instruction(11 DOWNTO 8);
	rs <= instruction(7 DOWNTO 4);
	rt <= instruction(3 DOWNTO 0);

	--------------------------------------------------------------------------
	-- Instruction Decode
	--------------------------------------------------------------------------
	-- TODO: Map the following register file signals to their corresponding ALU signals: clk, clear, rd, Sout_ALU,, rs, rt, rs_data, rt_data, '1'
	
	CPU_Registers_0:	Registers port map(clk, clear, rd, Sout_ALU, '1', rs, rt, rs_data, rt_data);
		
	--------------------------------------------------------------------------
	-- Execute
	--------------------------------------------------------------------------
	-- TODO: Map the following signals to the ALUs signals: rs_data, rt_data, op, Sout_ALU, cout
	
	CPU_ALU_0:	ALU_16Bit port map(rs_data, rt_data, op(1 downto 0), Sout_ALU, cout);
	

END Behavioral;
