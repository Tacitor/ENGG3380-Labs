library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity Control is
	port(
		op			:	in	std_logic_vector( 3 downto 0);
		alu_op		:	out	std_logic_vector( 1 downto 0);
		alu_src		:	out	std_logic;
		reg_dest	:	out	std_logic;
		reg_load	:	out	std_logic;
		reg_src		:	out	std_logic_vector(1 downto 0);
		mem_read	:	out	std_logic;
		mem_write	:	out	std_logic
		);
End Control;

architecture syn of Control is

begin
	process (op) is
	begin
		case op is

			-- op=0, ADD
			when x"0" =>
				alu_op		<=	"00";
				alu_src		<=	'0';
				reg_dest    <=	'0'; --get the 3:0 to go to C rt
				reg_load	<=	'1';
				reg_src		<=	"01";
				mem_read	<=	'0';
				mem_write	<=	'0';

				-- =-=-=-=-=-=  TODO 1: Implement the subtraction =-=-=-=-=-= 
			-- op=1, SUB
			when x"1" =>
				alu_op	    <=	  "01";     --need ALU op 1 for SUB
                alu_src     <=    '0';      --get ALU src from the c_data output  
                reg_dest    <=    '0';      --get the c_addr from 3:0 from the operation
                reg_load    <=    '1';      --load the result of the ALU back into the a_data
                reg_src     <=    "01";     --send the data from the ALU to the register
                mem_read    <=    '0';      --disable mem read
                mem_write   <=    '0';      --disable mem write

				-- =-=-=-=-=-=  TODO 2: Implement the AND =-=-=-=-=-= 
			-- op=2, AND
			when x"2" =>
				alu_op	    <=	  "10";     --need ALU op 2 for AND
                alu_src     <=    '0';      --get ALU src from the c_data output  
                reg_dest    <=    '0';      --get the c_addr from 3:0 from the operation
                reg_load    <=    '1';      --load the result of the ALU back into the a_data
                reg_src     <=    "01";     --send the data from the ALU to the register
                mem_read    <=    '0';      --disable mem read
                mem_write   <=    '0';      --disable mem write

				-- =-=-=-=-=-=  TODO 3: Implement the OR =-=-=-=-=-= 
			-- op=3, OR
			when x"3" =>
				alu_op	    <=	"11";       --need ALU op 2 for OR
                alu_src     <=    '0';      --get ALU src from the c_data output  
                reg_dest    <=    '0';      --get the c_addr from 3:0 from the operation
                reg_load    <=    '1';      --load the result of the ALU back into the a_data
                reg_src     <=    "01";     --send the data from the ALU to the register
                mem_read    <=    '0';      --disable mem read
                mem_write   <=    '0';      --disable mem write

		  	-- =-=-=-=-=-=  TODO 4: Implement the addition immeadiate =-=-=-=-=-= 
			-- op=4, ADDi
			when x"4" =>
				alu_op	    <=	"00";     --need ALU op 0 for ADD
                alu_src     <=    '1';      --get ALU src from the sign extender output  
                reg_dest    <=    '0';      --get the c_addr from 3:0 from the operation BUT THIS IS A DON'T CARE
                reg_load    <=    '1';      --load the result of the ALU back into the a_data
                reg_src     <=    "01";     --send the data from the ALU to the register
                mem_read    <=    '0';      --disable mem read
                mem_write   <=    '0';      --disable mem write

				-- =-=-=-=-=-=  TODO 5: Implement the subtraction immeadiate =-=-=-=-=-= 
			-- op=5, SUBi
			when x"5" =>
				alu_op	    <=	"01";     --need ALU op 1 for SUB
                alu_src     <=    '1';      --get ALU src from the sign extender output  
                reg_dest    <=    '0';      --get the c_addr from 3:0 from the operation BUT THIS IS A DON'T CARE
                reg_load    <=    '1';      --load the result of the ALU back into the a_data
                reg_src     <=    "01";     --send the data from the ALU to the register
                mem_read    <=    '0';      --disable mem read
                mem_write   <=    '0';      --disable mem write

			-- op=8, LW
			when x"8" =>
				alu_op		<=	"00";       --add the base to the offset
				alu_src		<=	'1';        --set the ALU src to the immidate value
				reg_dest	<=	'0';        --set the register dest to 0 so it pulls from Rt not that it matters to LW
				reg_load	<=	'1';        --set the load on the resister so the value can be loaded into it from memory
				reg_src		<=	"00";
				mem_read	<=	'1';
				mem_write	<=	'0';

				-- =-=-=-=-=-= TODO 6: Implement the store word =-=-=-=-=-= 
			-- op=C, SW
			when x"C" =>
				alu_op	    <=	"00";     --add the base to the offset
                alu_src     <=    '1';    --set the ALU src to the immidate value
                reg_dest    <=    '0';    --set the register dest to 0 so it pulls from Rt not that it matters to SW
                reg_load    <=    '0';    --keep the load off on the residter so nothing get written to it since we are writting out to memory
                reg_src     <=    "00";
                mem_read    <=    '0';
                mem_write   <=    '1';

			-- op=7, SLT
			when x"7" =>
				alu_op		<= "01";    --we want a SUB operation
				alu_src		<= '0';     --get ALU src from the c_data output 
				reg_dest	<= '0';     --get the c_addr from 3:0 from the operation
				reg_load	<= '1';     --load the result of the ALU back into the a_data
				reg_src		<= "10";    --send the data from the SLT operation (probably the LESS THAN flag from the CPU) to the register
				mem_read	<= '0';     --disable mem read
				mem_write	<= '0';     --disable mem write

			when others =>
				alu_op	    <=	"00";
				alu_src     <=	'0';
				reg_dest	<=	'0';
				reg_load	<=	'0';
				reg_src	    <=	"01";
				mem_read	<=	'0';
				mem_write   <=	'0';

		end case;
	end process;
end syn;
