
library ieee;
use ieee.std_logic_1164.all;
entity Controler_RegFile is
	port(OP:			in std_logic_vector (1 downto 0); -- op value
		Con:			in std_logic; -- condition variable
		func:			in std_logic_vector(1 downto 0);	--func code
		W:				out std_logic;	--Write enable
		clock:			in std_logic
	);
end Controler_RegFile;

architecture behav of Controler_RegFile is
	component SkipSelect
	port(	O:			out std_logic_vector(2 downto 0);
			con:		in std_logic;
			op:			in std_logic_vector(1 downto 0);
			sc:			in std_logic_vector(1 downto 0)
	);
	end component;
	
	component ThreeToOneMuxCon
	port( 	Sel:		in std_logic_vector(2 downto 0);
			Scout:		out std_logic_vector(1 downto 0)
	);
	end component;
	
	component WES
	port(	op:			in std_logic_vector(1 downto 0);
			we:			out std_logic;
			sc:			in std_logic_vector(1 downto 0)
	);
	end component;
	
	component FlipFlop
	port(	D:			in std_logic_vector(1 downto 0);
			Q:			out std_logic_vector(1 downto 0);
			clk:		in std_logic
	);
	end component;
	
	Signal O: std_logic_vector(2 downto 0);
	Signal Scout: std_logic_vector(1 downto 0);
	Signal ss: std_logic_vector(1 downto 0);
begin
S0:	SkipSelect port map (O => O, con => Con, op => func, sc => ss);
M0:	ThreeToOneMuxCon port map (Sel => O, Scout => Scout);
W0: WES port map (op => OP, we => W, sc => ss);
F0: FlipFlop port map(D => Scout, Q => ss, clk => clock);
end behav;

