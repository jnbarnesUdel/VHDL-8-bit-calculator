LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Adder_tb IS
END Adder_tb;

ARCHITECTURE behavior OF Adder_tb IS

-- Component Declaration for the Unit under Test

	COMPONENT Adder
		PORT(
		X : IN std_logic_vector(7 downto 0);
		Y : IN std_logic_vector(7 downto 0);
		S : OUT std_logic_vector(7 downto 0);
		Cout : OUT std_logic;
		under : OUT std_logic);
	END COMPONENT;

--Inputs
	signal X : std_logic_vector(7 downto 0) := (others => '0');
	signal Y : std_logic_vector(7 downto 0) := (others => '0');
	--signal Cin : std_logic := '0';

--Outputs
	signal S : std_logic_vector(7 downto 0);
	signal Cout : std_logic;
	signal under : std_logic;

	BEGIN

-- Instantiate the Component we are testing
		uut: Adder PORT MAP (
			X => X,
			Y => Y,
			S => S,
			Cout => Cout,
			under => under
		);

-- Stimulus process
	stim_proc: process
	begin
-- hold reset state for 100 ns.
		wait for 100 ns;
		X <= "00000110"; -- 6 u = 0
		Y <= "00000100"; -- 4 o = 1

		wait for 100 ns;
		X <= "00001111"; -- -1 u = 0
		Y <= "00001100"; -- -4 o = 0

		wait for 100 ns;
		X <= "00000110"; -- 6 u = 0
		Y <= "00000111"; -- 7 o = 1

		wait for 100 ns;
		X <= "00000110"; -- 6 u = 0
		Y <= "00001110"; -- -2 o = 0

		wait for 100 ns;
		X <= "00001001"; -- -7 u = 1
		Y <= "00001011"; -- -4 o = 0
		
		wait for 100 ns;
		X <= "00001111"; -- -1 u = 0
		Y <= "00001101"; -- -3 o = 0
		
		wait for 100 ns;
		X <= "00001011"; -- -5 u = 1
		Y <= "00001000"; -- -8 o = 0
		
		wait for 100 ns;
		X <= "00001101"; -- -3 u = 1
		Y <= "00001001"; -- -7 o = 0

		wait;
	end process;

END;