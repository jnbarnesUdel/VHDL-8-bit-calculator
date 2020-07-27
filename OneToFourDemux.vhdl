
library ieee;
use ieee.std_logic_1164.all;

entity OneToFourDemux is
	port(	O:			out std_logic_vector(3 downto 0);
			I:			in std_logic;
			Sel:		in std_logic_vector(1 downto 0)
		);
end OneToFourDemux;

architecture behav of OneToFourDemux is
begin
D1:	process(Sel, I) is
	begin
		if(sel(1 downto 0) = "11")then	
		O(3) <= I;
		O(2 downto 0) <= "000";
		elsif(sel(1 downto 0) = "10")then
		O(2) <= I;
		O(3) <= '0';
		O(1 downto 0) <= "00";
		elsif(sel(1 downto 0) = "01")then
		O(1) <= I;
		O(3 downto 2) <= "00";
		O(0) <= '0';
		elsif(sel(1 downto 0) = "00")then
		O(0) <= I;
		O(3 downto 1) <= "000";
		end if;
	end process;
end behav;

