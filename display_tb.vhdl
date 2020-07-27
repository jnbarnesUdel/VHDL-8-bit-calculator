LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY display_tb IS
END display_tb;

ARCHITECTURE behavior OF display_tb IS

-- Component Declaration for the Unit under Test

	COMPONENT display
		Port ( opcode : in STD_LOGIC_VECTOR (1 downto 0); -- 10
			RT : in STD_LOGIC_VECTOR (1 downto 0); -- 00
			imm : in STD_LOGIC_VECTOR (3 downto 0); -- 00
			rs : in STD_LOGIC_VECTOR (7 downto 0); -- output or zero
			seven : out STD_LOGIC_VECTOR (7 downto 0)); -- rs or zero
	END COMPONENT;

--Inputs
	signal opcode : std_logic_vector(1 downto 0) := (others => '0');
	signal RT : std_logic_vector(1 downto 0) := (others => '0');
	signal imm : std_logic_vector(3 downto 0) := (others => '0');
	signal rs : std_logic_vector(7 downto 0) := (others => '0');

--Outputs
	signal seven : std_logic_vector(7 downto 0);

	BEGIN

-- Instantiate the Component we are testing
		uut: display PORT MAP (
			opcode => opcode,
			RT => RT,
			imm => imm,
			rs => rs,
			seven => seven
		);

-- Stimulus process
	stim_proc: process
	begin
-- hold reset state for 100 ns.
		wait for 100 ns;
		opcode <= "00"; 
		RT <= "00"; 
		imm <= "0000"; 
		rs <= "00000001";
		
		wait for 100 ns;
		opcode <= "10"; 
		RT <= "00"; 
		imm <= "0000"; 
		rs <= "00000010";
		
		wait for 100 ns;
		opcode <= "10"; 
		RT <= "10"; 
		imm <= "0000"; 
		rs <= "00000011";
		
		wait for 100 ns;
		opcode <= "10"; 
		RT <= "00"; 
		imm <= "0010"; 
		rs <= "00000100";
		
		wait for 100 ns;
		opcode <= "10"; 
		RT <= "00"; 
		imm <= "0000"; 
		rs <= "00000101";
		
		
		wait for 100 ns;
		
		wait;
	end process;

END;