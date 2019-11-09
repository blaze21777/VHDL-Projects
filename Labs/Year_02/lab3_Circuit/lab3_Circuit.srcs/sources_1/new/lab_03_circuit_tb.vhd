----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.08.2019 10:04:30
-- Design Name: 
-- Module Name: lab_03_circuit_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab_03_circuit_tb is
	--  Port ( );
end lab_03_circuit_tb;

architecture Behavioral of lab_03_circuit_tb is

--	signal SW0   : STD_LOGIC;
--	signal SW1   : STD_LOGIC;
--	signal SW2   : STD_LOGIC;
--	signal LD0   : STD_LOGIC;
	signal a   : STD_LOGIC;
	signal b   : STD_LOGIC;
	signal c   : STD_LOGIC;
	signal d   : STD_LOGIC;

	signal input : STD_LOGIC_VECTOR(2 downto 0);
begin
--	(SW0, SW1, SW2) <= input;
    (b,c,d) <= input;

	-- Instantiate the unit under test (uut)
	UUT : entity work.lab_03_circuit
		port map(
--			SW0 => SW0,
--			SW1 => SW1,
--			SW2 => SW2,
--			LD0 => LD0
			SW0 => b,
			SW1 => c,
			SW2 => d,
			LD0 => a
		);

	-- Stimulus process
	stim_proc : process is
	begin
		wait for 10ns;
		for i in 0 to 7 loop
			input <= std_logic_vector(to_unsigned(i, input'length));
			wait for 10ns;
		end loop;
		wait;
	end process;

end Behavioral;