
library ieee;
use ieee.std_logic_1164.all;

entity FourToOneMux is
	port(I1,I2,I3,I4:	in std_logic_vector(7 downto 0);
			O:			out std_logic_vector(7 downto 0);
			Sel:		in std_logic_vector(1 downto 0)
	);
end FourToOneMux;

architecture behav of FourToOneMux is
begin
M1:	process(Sel, I1, I2, I3, I4) is
	begin
		if(sel(1 downto 0) = "11")then	
		O <= I4;
		elsif(sel(1 downto 0) = "10")then
		O <= I3;
		elsif(sel(1 downto 0) = "01")then
		O <= I2;
		elsif(sel(1 downto 0) = "00")then
		O <= I1;
		end if;
	end process;
end behav;

