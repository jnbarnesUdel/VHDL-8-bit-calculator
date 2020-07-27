
library ieee;
use ieee.std_logic_1164.all;

entity FlipFlop is
	port( 	D:			in std_logic_vector(1 downto 0);
			Q:			out std_logic_vector(1 downto 0);
			clk:		in std_logic
	);
end FlipFlop;

architecture behav of FlipFlop is
begin
r1:	process(clk) is
	begin
		if(clk'event and clk = '1')then	--swaped to falling edge stuff	
			Q <= D;
		end if;
	end process;
end behav;

