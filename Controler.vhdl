
library ieee;
use ieee.std_logic_1164.all;
entity Controler_RegFile is
	port(I_RS:			in std_logic_vector (1 downto 0); -- rs value
		I_RT:			in std_logic_vector(1 downto 0); -- rt value
		I_WS:			in std_logic_vector(1 downto 0); -- Write select
		clock:			in std_logic; -- positive level triggering in problem 3
		Wr:				in std_logic; -- 0: don't write anything; 1: reg_file can write
		rt:				out std_logic_vector(7 downto 0); -- rt out
		rs: 			out std_logic_vector(7 downto 0); --rs out
		WI:				in std_logic_vector(7 downto 0)	--in to d ports of reg
	);
end Controler_RegFile;

architecture behav of Controler_RegFile is
	component OneToFourDemux
	port(	O:			out std_logic_vector(3 downto 0);
			I:			in std_logic;
			Sel:		in std_logic_vector(1 downto 0)
	);
	end component;
	
	component reg
	port( 	WE:			in std_logic;
			D:			in std_logic_vector(7 downto 0);
			Q:			out std_logic_vector(7 downto 0);
			clk:		in std_logic
	);
	end component;
	
	component FourToOneMux
	port(I1,I2,I3,I4:	in std_logic_vector(7 downto 0);
			O:			out std_logic_vector(7 downto 0);
			Sel:		in std_logic_vector(1 downto 0)
	);
	end component;
	Signal S: std_logic_vector(3 downto 0);
	Signal Q1, Q2, Q3, Q4: std_logic_vector(7 downto 0);
begin
d1: OneToFourDemux port map ( O => S, Sel => I_WS, I => Wr);
R0:	reg port map (WE => S(0), clk => clock, D => WI, Q => Q1);
R1:	reg port map (WE => S(1), clk => clock, D => WI, Q => Q2);
R2:	reg port map (WE => S(2), clk => clock, D => WI, Q => Q3);
R3:	reg port map (WE => S(3), clk => clock, D => WI, Q => Q4);
M1: FourToOneMux port map (I1 => Q1, I2 => Q2, I3 => Q3, I4 => Q4, Sel => I_RS, O => rs);
M2: FourToOneMux port map (I1 => Q1, I2 => Q2, I3 => Q3, I4 => Q4, Sel => I_RT, O => rt);
end behav;

