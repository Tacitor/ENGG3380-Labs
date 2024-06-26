library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity CPU_3380 is
	port(
		clk	: in std_logic;
		clear : in std_logic;
		mem_dump : in std_logic := '0'
 	);
end CPU_3380;

architecture Behavioral of CPU_3380 is
	COMPONENT ALU_16Bit
		port(
			A			:	in		std_logic_vector(15 downto 0);
			B			:	in		std_logic_vector(15 downto 0);
			S			:	in		std_logic_vector(1 downto 0);
			Sout		:	out 	std_logic_vector(15 downto 0);
			Cout		:	out	std_logic
		);
	END COMPONENT;

	COMPONENT Registers
		port(
			clk			:	in	 std_logic;
			clear		:	in  std_logic;

			a_addr		:	in	 std_logic_vector( 3 downto 0);
			a_data		:	in	 std_logic_vector(15 downto 0);
			load		:	in	 std_logic;

			b_addr		:	in	 std_logic_vector( 3 downto 0);
			c_addr		:	in	 std_logic_vector( 3 downto 0);

			b_data		:	out std_logic_vector(15 downto 0);
			c_data		:	out std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT Control
		port(
			op			:	in	std_logic_vector( 3 downto 0);
			alu_op		:	out	std_logic_vector( 1 downto 0);
			alu_src		:	out	std_logic;
			reg_dest	:	out	std_logic;
			reg_load	:	out	std_logic;
			reg_src		:	out	std_logic_vector( 1 downto 0);
			mem_read	:	out	std_logic;
			mem_write	:	out	std_logic
		);
	end component;

	component Signextend
		port(
			immIn		:	in	std_logic_vector( 3 downto 0);
			immOut		:	out	std_logic_vector(15 downto 0)
		);
	end component;

	component mux3_1
   generic (WIDTH : positive:=16);
	port(
		Input1		:	in		std_logic_vector(WIDTH-1 	downto 0);
		Input2		:	in		std_logic_vector(WIDTH-1 	downto 0);
		Input3		:	in		std_logic_vector(WIDTH-1 	downto 0);
		S			:	in		std_logic_vector(1 			downto 0);
		Sout		:	out	std_logic_vector(WIDTH-1 	downto 0));
	end component;

	component mux2_1
   generic (WIDTH : positive:=16);
	port(
		Input1		:	in		std_logic_vector(WIDTH-1 	downto 0);
		Input2		:	in		std_logic_vector(WIDTH-1 	downto 0);
		S			:	in		std_logic;
		Sout		:	out	std_logic_vector(WIDTH-1 	downto 0));
	end component;


    component Memory
       generic (
           INPUT  : string := "in.txt";
           OUTPUT : string := "out_data.txt"
       );
        port (
        -- TODO 1: Finish implementing the memory component
        clk      : in std_logic;  
        read_en  : in std_logic;
        write_en : in std_logic;
        addr     : in std_logic_vector(15 downto 0);
        data_in  : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0);
        mem_dump : in std_logic := '0'
        );
	end component;

	-- TODO 2: Finish implementing the program counter component
	component PC_REG
	port(
        clk    : in std_logic;
        reset  : in std_logic;
        Input  : in std_logic_vector(15 downto 0);
        Output : out std_logic_vector(15 downto 0)
	);
	end component;
	
	component Jump_Concat
	port(
	   Address      : in STD_LOGIC_VECTOR(11 DOWNTO 0);
       PC           : in STD_LOGIC_VECTOR(15 DOWNTO 0);
       PC_Jump      : out STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
	end component;

	-- Signals
	signal	instruction			:	std_logic_vector(15 downto 0);
	signal  op				    :	std_logic_vector( 3 downto 0);
	signal	rd					:	std_logic_vector( 3 downto 0);
	signal	rs					:	std_logic_vector( 3 downto 0);
	signal	rt					:	std_logic_vector( 3 downto 0);

	signal	alu_result			:	std_logic_vector(15 downto 0);
	signal	alu_src_mux_out	    :	std_logic_vector(15 downto 0);
	signal 	sign_ex_out			:	std_logic_vector(15 downto 0);
	signal	rs_data				:	std_logic_vector(15 downto 0);
	signal	rt_data				:	std_logic_vector(15 downto 0);
	signal	cout				:	std_logic;
	signal  cout_PC_Plus_2_Adder:   std_logic;
	signal	reg_dest_mux_out	:	std_logic_vector( 3 downto 0);
	signal	reg_src_mux_out	    :	std_logic_vector(15 downto 0);
	signal	mem_dataout			:	std_logic_vector(15 downto 0);

	signal	ctrl_alu_src		:	std_logic;
	signal	ctrl_alu_op			:	std_logic_vector( 1 downto 0);
	signal	ctrl_reg_dest		:	std_logic;
	signal	ctrl_reg_src		:	std_logic_vector( 1 downto 0);
	signal	ctrl_reg_load		:	std_logic;
	signal	ctrl_mem_read		:	std_logic;
	signal	ctrl_mem_write		:	std_logic;

	signal	slt_input			:	std_logic_vector(15 downto 0);

	signal	reg_src_mux_input3  :	std_logic_vector(15 downto 0);
	signal	pc_plus_2			:	std_logic_vector(15 downto 0);
	signal	pc_reg_output		:	std_logic_vector(15 downto 0);
	
	signal pc_mux_sel           :   std_logic_vector(1 downto 0);
	signal pc_Mux_out     :   std_logic_vector(15 downto 0);
	signal pc_Jump_address      :   std_logic_vector(15 downto 0);
	signal pc_BNE               :   std_logic_vector(15 downto 0);
	
begin
	--------------------------------------------------------------------------
	-- Instruction Fetch
	--------------------------------------------------------------------------
  -- TODO 3: Finish implementing the program counter port map
    CPU_PC           :	 PC_REG port map(
		clk 			=>		clk,
		reset			=>		clear,
		input			=>		pc_Mux_out, -- PC input selected from the PC mux
		output		    =>      pc_reg_output
	);
	
	-- ALU Locked to add for PC+2
	PC_Plus_2_Adder  :   ALU_16Bit port map(
            A               =>        pc_reg_output,
            B               =>        "0000000000000010",
            S               =>        "00",
            Sout            =>        pc_plus_2,
            Cout            =>        cout_PC_Plus_2_Adder
     );
     
     -- Another ALU Locked to add for PC+Offset
     PC_BNE_Adder  :   ALU_16Bit port map(
                 A               =>        pc_plus_2,
                 B               =>        sign_ex_out,
                 S               =>        "00",
                 Sout            =>        PC_BNE,
                 Cout            =>        cout_PC_Plus_2_Adder
     );
     
     PC_Jump    :   Jump_Concat port map(
         Address => instruction(11 downto 0),
         PC => pc_reg_output,
         PC_Jump => pc_Jump_address
     );
      
     -- Select line which Value to assign to PC for next inst
     pc_mux_sel <= "10" when op = "1011" else -- Jump
                   "01" when (op = "1001" and not(alu_result = x"0000")) else -- BNE
                   "00"; -- Anything else
     
     
     -- Selects next PC value
     PC_Input_mux   :   mux3_1 port map(
            input1 => pc_plus_2,
            input2 => PC_BNE,
            input3 => PC_Jump_address,
            s => pc_mux_sel,
            Sout => pc_Mux_out -- Next PC input   
     );
     
     

    -- TODO 4: Finish implementing the instruction memory
	CPU_Instr_MEM  :  Memory generic map(
			INPUT => "Instr2.txt"
			-- OUTPUT => "Instr2.txt"
			) 
		port map(
		clk			    =>		clk,
		read_en		    =>		'1',
		write_en		=>		'0',
		addr			=>		pc_reg_output,
		data_in		    =>		x"0000",
		data_out	 	=>		instruction,
		mem_dump 	    =>		'0'
	);

	op		<=	instruction(15 downto 12);
	rd		<= instruction(11 downto  8);
	rs		<= instruction(7  downto  4);
	rt		<= instruction(3  downto  0);
	--------------------------------------------------------------------------
	-- Instruction Decode
	--------------------------------------------------------------------------

  -- TODO 5: Finish implementing the control port map
	CPU_Control_0:			Control port map(
		op			=>		op,
		alu_op		=>		ctrl_alu_op,
		alu_src		=>		ctrl_alu_src,
		reg_dest	=>		ctrl_reg_dest,
		reg_load	=>		ctrl_reg_load,
		reg_src		=>		ctrl_reg_src,
		mem_read	=>		ctrl_mem_read,
		mem_write	=>      ctrl_mem_write
	);

	CPU_Registers_0:		Registers port map(
		clk			=>		clk,
		clear		=>		clear,
		a_addr		=>		rd,
		a_data		=>		reg_src_mux_out,
		load		=>		ctrl_reg_load,
		b_addr		=>		rs,
		c_addr		=>		reg_dest_mux_out,
		b_data		=>		rs_data,
		c_data		=>		rt_data
	);

	CPU_signextend_0:		Signextend port map(
		immIn		=>		rt,
		immOut		=>		sign_ex_out
	);

	CPU_reg_dest_mux:		mux2_1 generic map(4) port map(
		Input1		=>		rt,
		Input2		=>		rd,
		S			=>		ctrl_reg_dest,
		Sout		=>		reg_dest_mux_out
	);

	--------------------------------------------------------------------------
	-- Execute
	--------------------------------------------------------------------------
	CPU_alu_src_mux:		mux2_1 port map(
		Input1		=>		rt_data,
		Input2		=>		sign_ex_out,
		S			=>		ctrl_alu_src,
		Sout		=>		alu_src_mux_out
	);

	CPU_ALU_0:				ALU_16Bit port map(
		A				=>		rs_data,
		B				=>		alu_src_mux_out,
		S				=>		ctrl_alu_op,
		Sout			=>		alu_result,
		Cout			=>		cout
	);

	--------------------------------------------------------------------------
	-- Memory
	--------------------------------------------------------------------------

	-- TODO 6: Finish implementing the data memory
	CPU_MEM_0:Memory generic map( 
		INPUT => "in.txt",
		OUTPUT => "out_data.txt")
		port map(
		clk			=>		clk,
		read_en		=>		ctrl_mem_read,
		write_en	=>		ctrl_mem_write,
		addr		=>		alu_result,
		data_in		=>		rt_data,
		data_out	=>		mem_dataout,
		mem_dump 	=>		'0'
	);

	--------------------------------------------------------------------------
	-- Write Back
	--------------------------------------------------------------------------

	-- TODO 7: Finish implementing the 3-1 MUX
	slt_input	<=	"000000000000000"&alu_result(15);
	CPU_reg_src_mux:		mux3_1 generic map(16) port map(
		Input1		=>	mem_dataout,
		Input2		=>	alu_result,
		Input3		=>	slt_input,
		S			=>	ctrl_reg_src,
		Sout		=>  reg_src_mux_out
	);

end Behavioral;
