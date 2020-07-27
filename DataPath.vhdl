
library ieee;
use ieee.std_logic_1164.all;
entity DataPath is
	port(Instruction:	in std_logic_vector(7 downto 0);
	clock:				in std_logic;
	Disp:				out std_logic_vector(7 downto 0)
	);
end DataPath;

architecture behav of DataPath is
	component reg_file
	port(I_RS:			in std_logic_vector (1 downto 0); -- rs value
		I_RT:			in std_logic_vector(1 downto 0); -- rt value
		I_WS:			in std_logic_vector(1 downto 0); -- Write select
		clock:			in std_logic; -- positive level triggering in problem 3
		Wr:				in std_logic; -- 0: don't write anything; 1: reg_file can write
		rt:				out std_logic_vector(7 downto 0); -- rt out
		rs: 			out std_logic_vector(7 downto 0); --rs out
		WI:				in std_logic_vector(7 downto 0)	--in to d ports of reg
	);
	end component;
	
	component ALU
	port( 	rs : in STD_LOGIC_VECTOR (7 downto 0); -- rt
		rt : in STD_LOGIC_VECTOR (7 downto 0); -- rs
		op : in STD_LOGIC_VECTOR (1 downto 0); -- operation code
		Sum : out STD_LOGIC_VECTOR (7 downto 0); -- rs + rt or rs - rt
		beq : out STD_LOGIC -- Does rt == rs?
	);
	end component;
	
	component TwoToOneMuxOutside
	port(	Sel:		in std_logic;
			I1:			in std_logic_vector(3 downto 0);
			I2:			in std_logic_vector(7 downto 0);
			O:			out std_logic_vector(7 downto 0)
	);
	end component;
	
	component Controler_RegFile
	port(OP:			in std_logic_vector (1 downto 0); -- op value
		Con:			in std_logic; -- condition variable
		func:			in std_logic_vector(1 downto 0);	--func code
		W:				out std_logic;	--Write enable
		clock:			in std_logic
	);
	end component;
	
	component display
	port( 	opcode : in STD_LOGIC_VECTOR (1 downto 0); -- 10
		imm : in STD_LOGIC_VECTOR (3 downto 0); -- 00
		rs : in STD_LOGIC_VECTOR (7 downto 0); -- output or zero
		seven : out STD_LOGIC_VECTOR (7 downto 0) -- rs or zero
	);
	end component;
	
	component TwoToOneMuxOther
	port(	Sel:		in std_logic;
			I1:			in std_logic_vector(1 downto 0);
			I2:			in std_logic_vector(1 downto 0);
			O:			out std_logic_vector(1 downto 0)
	);
	end component;
	
	Signal rd:	std_logic_vector(1 downto 0);
	Signal wr, con, s:	std_logic;
	signal rs, rt, WI, sum:	std_logic_vector(7 downto 0);
	signal sig: std_logic;
begin
Reg0: reg_file port map (I_RS => Instruction(5 downto 4), I_RT => Instruction(3 downto 2), I_WS => rd, clock => clock, Wr => wr, rt => rt, rs => rs, WI => WI);
ALU0: ALU port map (rs => rs, rt => rt, op => Instruction(7 downto 6), Sum => sum, beq => con);
MUX0: TwoToOneMuxOutside port map (Sel => s, I1 => Instruction(3 downto 0), I2 => sum, O => WI);
MUX1: TwoToOneMuxOther port map (Sel => Instruction(7), I1 => Instruction(1 downto 0), I2 => Instruction(5 downto 4), O => rd);
Con0: Controler_RegFile port map (OP => Instruction(7 downto 6), Con => con, func => Instruction(1 downto 0), W => wr, clock => clock);
Dis0: display port map (opcode => Instruction(7 downto 6), imm => Instruction(3 downto 0), rs => rs, seven => Disp);
s <= Instruction(7) and Instruction(6);
end behav;

