library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
/*	
	In-Datapath-Out: Button endocoder and debounce => Pattern Encoder => 7seg Cathode Mux => 7seg endoder
	
	Control: clock divider => Anode Sequencer & 7seg Cathode Mux == match anode and cathode to same digit

	!!!!! USE SAME NAMES AS master_Lab1_Pt2.xdc for port IO !!!!!
*/
entity Lab2_main is
    Port (	CLK100MHz in std_logic;
			BTNU : in std_logic; BTNL : in std_logic; BTNC : in std_logic;
			BTNR : in std_logic; BTND : in std_logic;
			AN : out std_logic_vector(7 downto 0); --7 seg ANODES
			C : out std_logic_vector(7 downto 0); --7 seg Cathodes   order might be backward?
	);
end Lab2_main;

architecture Structural of Lab2_main is

	--Component Declarations:
	
	--CLOCK DIVIDER & ENCODER
	
		--does not exist yet
	
	--ANDODE SEQUENCER
	
		--maybe build into clock divider? 
		--does not exist
	
	--BUTTON ENCODER & DEBOUNCE
	
		--also doesn't exist yet
	
	--PATTERN ENCODER
	component PatCoder is
	Port (code : in STD_LOGIC_VECTOR (2 downto 0);	--input coded button push maybe better to just input the button?		
			pat_0 : out STD_LOGIC_VECTOR (4 downto 0);-- 4-1 bits 7seg character in hex, 0 bit for dot
			pat_1 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_2 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_3 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_4 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_5 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_6 : out STD_LOGIC_VECTOR (4 downto 0);
			pat_7 : out STD_LOGIC_VECTOR (4 downto 0);
			);
	end component;
	
	--7SEG CATHODE MUX
	component Mux8to1_5bit is
	Port (	I_0 : in std_logic_vector(4 downto 0); --4-1 bits are character, 0 bit is dot
			I_1 : in std_logic_vector(4 downto 0); -- 0 is dot on, 1 is dot off
			I_2 : in std_logic_vector(4 downto 0);
			I_3 : in std_logic_vector(4 downto 0);
			I_4 : in std_logic_vector(4 downto 0);
			I_5 : in std_logic_vector(4 downto 0);
			I_6 : in std_logic_vector(4 downto 0);
			I_7 : in std_logic_vector(4 downto 0);
			S : in  std_logic_vector(2 downto 0); --selection by clk div
			Z : out  std_logic_vector(4 downto 0); --out
			);  
	end component
	
	--7SEG ENCODER
	component sevseg_dot is
	Port ( int : in std_logic_vector (4 downto 1);--same input vector here
			dot : in std_logic_vector(0);		--as here when using component. 4-1 bits are character in hex, 0 bit is dot
           seg : out std_logic_vector (7 downto 0));-- 7-1 bits are cathodes, 0 bit is dot. -- 0 is dot on, 1 is dot off	
	end component;

--signals for the interal wires connecting
signal digCode : std_logic_vector (2 downto 0); --signal from clock division for anode and cathode selection
signal btnCode : std_logic_vector (2 downto 0); --signal from buttons to pattern encoder to select the pattern
signal muxSegSig: std_logic_vector(4 downto 0); --signal from cathode mux to 7 seg encoder


begin

--process (clk)?

	PatCoder: PatCoder port map(btnCode,pat_0,pat_1,pat_2,pat_3,pat_4,pat_5,pat_6,pat_7);
	--order of pat digits probably needs to flip, use anode selection. that's what enables the number anyway, or do it here
	CathMux: Mux8to1_5bit port map(pat_0,pat_1,pat_2,pat_3,pat_4,pat_5,pat_6,pat_7,digcode,muxSegSig);--flip 7,6,5,4,3,2,1,0
	CathCoder: sevseg_dot port map(muxSegSig,muxSegSig,C);
	
	

end Structural;
