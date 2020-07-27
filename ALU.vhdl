library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
	Port ( rs : in STD_LOGIC_VECTOR (7 downto 0); -- rt
		rt : in STD_LOGIC_VECTOR (7 downto 0); -- rs
		op : in STD_LOGIC_VECTOR (1 downto 0); -- operation code
		Sum : out STD_LOGIC_VECTOR (7 downto 0); -- rs + rt or rs - rt
		beq : out STD_LOGIC); -- Does rt == rs?
end ALU;

architecture alu_all of ALU is

-- This is so we can use sub adders 
component adder
	Port ( X : in STD_LOGIC_VECTOR (7 downto 0);
		Y : in STD_LOGIC_VECTOR (7 downto 0);
		S : out STD_LOGIC_VECTOR (7 downto 0);
		Cout : out STD_LOGIC; -- This is the overflow overflow bit
		under : out STD_LOGIC); -- This is the underflow bit
end component;

-- Carry signals
signal c1,c2,c3,c4: STD_LOGIC;
signal neg_rt, not_rt, final_rt : STD_LOGIC_VECTOR (7 downto 0);

begin
	not_rt <= not(rt); -- can I 'not' a vector
	FA1: adder port map( not_rt,"00000001",neg_rt, c1, c2); --Cin
	process (rt, neg_rt, op)
	begin
		if (op(0) = '1') then
			final_rt <= rt;
		elsif (op(0) = '0') then
			final_rt <= neg_rt;
		else
			final_rt <= rt;
		end if;
	end process;

	FA2: adder port map( rs,final_rt,Sum, c3, c4); --Cin

	process (rs,rt)
	begin
		if rs = rt then
			beq <= '1';
		else 
			beq <= '0';
		end if;
	end process;

end alu_all;