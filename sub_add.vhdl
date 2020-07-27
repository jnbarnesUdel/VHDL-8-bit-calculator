-- sub adder
library ieee;
use ieee.std_logic_1164.all;
entity SA is -- This is the adder used inside the bigger adder as black box
	port( X, Y, Cin : in std_logic;
		sum, Cout : out std_logic);
end SA;

architecture add of SA is
begin
	sum <= (X xor Y) xor Cin;
	Cout <= (X and (Y or Cin)) or (Cin and Y);
end add;