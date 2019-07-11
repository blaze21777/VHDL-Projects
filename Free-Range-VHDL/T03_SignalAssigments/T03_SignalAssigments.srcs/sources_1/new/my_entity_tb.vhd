----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2019 14:20:41
-- Design Name: 
-- Module Name: my_entity_tb - Behavioral
-- Project Name: Test bench for signal assignments
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

entity my_entity_tb is
	--  Port ( );
end my_entity_tb;

architecture Behavioral of my_entity_tb is
	-- Entity signals 
	signal L, M, N      : std_logic;
	signal F3           : std_logic;
	signal input_concat : std_logic_vector(2 downto 0) := (others => '0');

begin
	-- Need to figure out what this method is called 
	(L, M, N) <= input_concat;

	i_DUT : entity work.my_entity port map (
		L  => L,
		M  => M,
		N  => N,
		F3 => F3
		);

	-- Test bench process 
	process is
	begin

		report "Entered process";
		
		wait for 10ns;
		-- Find oput what this loop is actually doing and how
		-- Cycles through all possible inputs
		for i in 0 to 4 loop
			input_concat <= std_logic_vector(to_unsigned(i, input_concat'length));
			wait for 10ns;
		end loop;

	end process;

end Behavioral;