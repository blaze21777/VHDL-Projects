----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2019 19:24:14
-- Design Name: 
-- Module Name: mux_4to1_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_4to1_tb is
	--  Port ( );
end mux_4to1_tb;

architecture Behavioral of mux_4to1_tb is

	signal a : std_logic_vector(7 downto 0) := (others => '1');
	signal b : std_logic_vector(7 downto 0) := (others => 'X');
	signal sel  : std_logic_vector(1 downto 0);
	signal x    : std_logic_vector(7 downto 0);
	
begin

	mux : entity work.mux_4to1(Behavioral)
		port map(
			a   => a,
			b   => b,
			sel => sel,
			x   => x
		);
		
		process is
	begin
		wait for 10ns;       -- To test fail conditions 
		for i in 0 to 8 loop -- Loop number controls how high the count is
			sel <= std_logic_vector(to_unsigned(i, sel'length));
			wait for 10ns; -- This statement is require to update signal 
		end loop;
	end process;
end Behavioral;
