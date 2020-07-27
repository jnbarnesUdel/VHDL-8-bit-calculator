
library ieee;
use ieee.std_logic_1164.all;
entity ThreeToOneMuxCon is
	port( 	Sel:		in std_logic_vector(2 downto 0);
			Scout:		out std_logic_vector(1 downto 0)
	);
end ThreeToOneMuxCon;

architecture behav of ThreeToOneMuxCon is
begin
	process(Sel) is
	begin
		if(Sel = "010")then
		Scout <= "01";
		elsif(Sel = "001")then
		Scout <= "11";
		else	
		Scout <= "00";
		end if;
	end process;
end behav;

