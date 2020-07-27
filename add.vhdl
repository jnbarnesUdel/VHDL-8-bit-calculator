library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder is
	Port ( X : in STD_LOGIC_VECTOR (7 downto 0);
		Y : in STD_LOGIC_VECTOR (7 downto 0);
		S : out STD_LOGIC_VECTOR (7 downto 0);
		Cout : out STD_LOGIC; -- This is the overflow overflow bit
		under : out STD_LOGIC); -- This is the underflow bit
end Adder;

architecture add_all of Adder is

-- This is so we can use sub adders 
component SA
	port( X, Y, Cin : in std_logic;
		sum, Cout : out std_logic);
end component;

-- Carry signals
signal c1,c2,c3,c4,c5,c6,c7,s_temp,Cout_temp: STD_LOGIC;

begin

-- Map all the ports of the sub adders
	FA1: SA port map( X(0), Y(0),'0', S(0), c1); --Cin
	FA2: SA port map( X(1), Y(1), c1, S(1), c2);
	FA3: SA port map( X(2), Y(2), c2, S(2), c3);
	FA4: SA port map( X(3), Y(3), c3, S(3), c4);
	FA5: SA port map( X(4), Y(4), c4, S(4), c5);
	FA6: SA port map( X(5), Y(5), c5, S(5), c6);
	FA7: SA port map( X(6), Y(6), c6, S(6), c7);
	FA8: SA port map( X(7), Y(7), c7, s_temp, Cout_temp); --S(7) , Cout
	s(7) <= s_temp;
	under <= (((not(s_temp)) and Y(7)) and X(7));
	Cout <= s_temp and (not(Y(7)) and not(X(7)));
	

end add_all;
