LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU_tb IS
END ALU_tb;

ARCHITECTURE behavior OF ALU_tb IS

-- Component Declaration for the Unit under Test

	COMPONENT ALU
		Port ( rs : in STD_LOGIC_VECTOR (7 downto 0); -- rt
			rt : in STD_LOGIC_VECTOR (7 downto 0); -- rs
			op : in STD_LOGIC_VECTOR (1 downto 0); -- operation code
			Sum : out STD_LOGIC_VECTOR (7 downto 0); -- rs + rt or rs - rt
			beq : out STD_LOGIC); -- Does rt == rs?
	END COMPONENT;

--Inputs
	signal rs : std_logic_vector(7 downto 0) := (others => '0');
	signal rt : std_logic_vector(7 downto 0) := (others => '0');
	signal op : std_logic_vector(1 downto 0) := (others => '0');
	--signal Cin : std_logic := '0';

--Outputs
	signal Sum : std_logic_vector(7 downto 0);
	signal beq : std_logic;

	BEGIN

-- Instantiate the Component we are testing
		uut: ALU PORT MAP (
			rs => rs,
			rt => rt,
			op => op,
			Sum => Sum,
			beq => beq
		);

-- Stimulus process
	stim_proc: process
	begin
-- hold reset state for 100 ns.
		wait for 100 ns;
		rs <= "00000111"; 
		rt <= "00000100"; 
		op <= "00"; -- rs - rt

		wait for 100 ns;
		rs <= "00000111"; 
		rt <= "00000100"; 
		op <= "01"; -- rs + rt

		wait for 100 ns;
		rs <= "00000111"; 
		rt <= "00000100"; 
		op <= "10"; -- rs - rt

		wait for 100 ns;
		rs <= "00000111"; 
		rt <= "00000100"; 
		op <= "11"; -- rs + rt

		wait for 100 ns;
		rs <= "00001001"; 
		rt <= "00001001"; 
		op <= "00"; -- rs + rt
		
		wait for 100 ns;
		rs <= "00001111";
		rt <= "00001101";
		op <= "01"; -- rs + rt
		
		wait for 100 ns;
		rs <= "00001011";
		rt <= "00001011"; 
		op <= "10"; -- rs + rt
		
		wait for 100 ns;
		rs <= "00001101"; 
		rt <= "00001001"; 
		op <= "11"; -- rs + rt
		
		wait for 100 ns;
		rs <= "00001011";
		rt <= "00001011"; 
		op <= "00"; -- rs + rt

		wait;
	end process;

END;