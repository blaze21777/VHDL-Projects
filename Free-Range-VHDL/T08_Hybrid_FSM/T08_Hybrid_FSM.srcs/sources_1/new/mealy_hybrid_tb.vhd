----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2019 19:34:16
-- Design Name: 
-- Module Name: mealy_hybrid_tb - Behavioral
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

entity mealy_hybrid_tb is
	--  Port ( );
end mealy_hybrid_tb;

architecture Behavioral of mealy_hybrid_tb is
	-- Clock signals
	constant clk_period : time := 10ns;
	-- Inputs 
	signal clk          : std_logic;
	signal x1, x2       : std_logic;
	signal input        : std_logic_vector(1 downto 0);
	-- Outputs
	signal y3, y2, y1   : std_logic; -- State encoding outputs
	signal z1, z2       : std_logic;

begin

	-- Entity instatsiation 
	i_mealy_FSM : entity work.mealy_hybrid(Behavioral)
		port map(
			clk => clk,
			x1  => x1,
			x2  => x2,
			y3  => y3,
			y2  => y2,
			y1  => y1,
			z1  => z1,
			z2  => z2
		);
	clk_process : process is
	begin
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
	end process;

	-- Test process
	(x1, x2) <= input;
	process is
	begin
		wait for 10ns;       -- To test fail conditions 
		for i in 0 to 2 loop -- Loop number controls how high the count is
			input <= std_logic_vector(to_unsigned(i, input'length));
			wait for 10ns;
		end loop;

	end process;

end Behavioral;