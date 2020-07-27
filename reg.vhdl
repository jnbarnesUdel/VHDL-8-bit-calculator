
library ieee;
use ieee.std_logic_1164.all;

entity reg is
	port( 	WE:			in std_logic;
			D:			in std_logic_vector(7 downto 0);
			Q:			out std_logic_vector(7 downto 0);
			clk:		in std_logic
	);
end reg;

architecture behav of reg is
begin
r1:	process(clk) is
	begin
		if(clk'event and clk = '1' and WE = '1')then	--swaped to falling edge stuff	
			Q <= D;
		end if;
	end process;
end behav;

