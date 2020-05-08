----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2020 10:56:39
-- Design Name: 
-- Module Name: order_random_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity order_random_tb is
	--  Port ( );
end order_random_tb;

architecture Behavioral of order_random_tb is

	-- Clock signal 
	signal clk_period : time := 10ns;

	-- order_random signals
	signal clk        : std_logic;
	signal reset      : std_logic;

begin
	order_random : entity work.order_random(Behavioral)
		port map(
			clk   => clk,
			reset => reset
		);

	-- Setting clock and reset default values
	reset <= '1', '0' after 3 ns;

	-- The clock process 
	clk_proc : process is
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
	end process;

end Behavioral;