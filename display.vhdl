library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
USE ieee.numeric_std.ALL;


entity display is
	Port ( opcode : in STD_LOGIC_VECTOR (1 downto 0); -- 10
		imm : in STD_LOGIC_VECTOR (3 downto 0); -- 00
		rs : in STD_LOGIC_VECTOR (7 downto 0); -- output or zero
		seven : out STD_LOGIC_VECTOR (7 downto 0)); -- rs or zero
end display;

architecture display_arch of display is


-- Carry signals
--signal (c1,c2,c3,c4: STD_LOGIC;
--	neg_rt, not_rt, final_rt : STD_LOGIC_VECTOR (7 downto 0));
begin
	process (opcode, imm, rs) -- may I print directly from display
	begin
		if (opcode = "10") and (imm = "0000") then
			seven <= rs;
			
			report " ----- ";
			report "rs value is " & integer'image(to_integer(signed(rs)));

			--report " ----- ";
			--for i in 0 to rs'LENGTH - 1 loop
			--	report "rs("&integer'image(i)&") value is" &   
			--		std_logic'image(rs(i));
			--end loop;			
			
		end if;
	end process;

end display_arch;