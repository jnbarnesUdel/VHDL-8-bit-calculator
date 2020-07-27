
library ieee;
use ieee.std_logic_1164.all;
entity SkipSelect is
	port(	O:			out std_logic_vector(2 downto 0);
			con:		in std_logic;
			op:			in std_logic_vector(1 downto 0);
			sc:			in std_logic_vector(1 downto 0)
	);
end SkipSelect;

architecture behav of SkipSelect is
begin
	process(sc, con, op) is
	begin
		if(sc = "00" and con = '0')then	
		O <= "100";
		elsif(sc = "00" and con = '1' and (op = "00" or op = "11"))then
		O <= "100";
		elsif(sc = "01")then
		O <= "100";
		elsif(sc = "00" and con = '1' and op = "01")then
		O <= "010";
		elsif(sc = "11" )then
		O <= "010";
		elsif(sc = "00" and con = '1' and op = "10")then
		O <= "001";
		else
		O <= "100";
		end if;
	end process;
end behav;

