library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity DataPath_tb is
end DataPath_tb;

architecture behav of DataPath_tb is
--  Declaration of the component that will be instantiated.
component DataPath
port (	Instruction:	in std_logic_vector(7 downto 0);
	clock:				in std_logic;
	Disp:				out std_logic_vector(7 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
for DataPath_0: DataPath use entity work.DataPath(behav);
signal clock : std_logic;
signal instruction, disp : std_logic_vector(7 downto 0);
begin
--  Component instantiation.
DataPath_0: DataPath port map (instruction => Instruction, clock => clock, Disp => disp);

--  This process does the real job.
process
type pattern_type is record

clock : std_logic;
instruction, disp : std_logic_vector(7 downto 0);
-- RT and RS are outputs we want to look at
end record;
--  The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(('1', "11000011", "00000000"), --load 3 into r0
('0', "11000011", "00000000"),	--change clock
('1', "11010100", "00000000"),  -- load 4 into r1
('0', "11010100", "00000000"),	--change clock
('1', "00000100", "00000000"), --add r0, r0, r1 
('0', "00000100", "00000000"), -- change clock
('1', "10000000", "00000111"), --disp r0
('0', "10000000", "00000111"), --change clock
('1', "01000110", "00000111"), --sub r2 r0 r1
('0', "01000110", "00000111"), --change clock
('1', "10100000", "00000011"), --disp r2
('0', "10100000", "00000011"),	--change clock
('1', "11110011", "00000011"), --load r3 3
('0', "11110011", "00000011"),	--change clock
('1', "10101101", "00000011"), --beq r2 r3 1
('0', "10101101", "00000011"),	--change clock
('1', "00101100", "00000011"), --add r0 r2 r3
('0', "00101100", "00000011"),	--change clock
('1', "10000000", "00000111"), --disp r0
('0', "10000000", "00000111"), --change clock
('1', "10000001", "00000111"), --beq r0 r0 1
('0', "10000001", "00000111"),	--change clock
('1', "01010000", "00000111"), --sub r0 r1 r0
('0', "01010000", "00000111"),	--change clock
('1', "10000000", "00000111"), --disp r0
('0', "10000000", "00000111"),	--change clock
('1', "10000010", "00000111"), --beq r0 r0 2
('0', "10000010", "00000111"),	--change clock
('1', "11000011", "00000111"), --load r0 3
('0', "11000011", "00000111"),	--change clock
('1', "00000011", "00000111"), --add r3 r0 r0
('0', "00000011", "00000111"),	--change clock
('1', "10110000", "00000011"), --disp r3
('0', "10110000", "00000011"),	--change clock
('1', "11001111", "00000011"), --load r0 -1
('0', "11001111", "00000011"),	--change clock
('1', "10000000", "11111111"), --disp r0 ------------------ -1
('0', "10000000", "11111111"),	--change clock
('1', "01010001", "11111111"), --sub r1 r1 r0
('0', "01010001", "11111111"),	--change clock
('1', "10010000", "00000101"), --disp r1	----fug think this is at 4
('0', "10010000", "00000101"),	--change clock
('1', "10000101", "00000101"), --beq r0 r1 1	--should pass thruough this
('0', "10000101", "00000101"),	--change clock
('1', "00110011", "00000101"), --add r3 r3 r0
('0', "00110011", "00000101"),	--change clock
('1', "10110000", "00000010"), --disp r3
('0', "10110000", "00000010"));	--change clock

begin
--  Check each pattern.
for n in patterns'range loop
--  Set the inputs.
instruction <= patterns(n).instruction;
clock <= patterns(n).clock;

--  Wait for the results.
wait for 1 ns;
--  Check the outputs.
assert Disp = patterns(n).disp
report "bad disp value" severity error;

end loop;
assert false report "end of test" severity note;
--  Wait forever; this will finish the simulation.
wait;
end process;
end behav;
