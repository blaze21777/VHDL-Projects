----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2019 11:13:14
-- Design Name: 
-- Module Name: loop_counter_tb - Behavioral
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

entity loop_counter_tb is
	--  Port ( );
end loop_counter_tb;

architecture Behavioral of loop_counter_tb is

	signal clk        : std_logic;
	signal reset      : std_logic;
	signal max_count  : integer;
	signal done       : std_logic;
	signal clk_period : time := 10ns;

begin

	UUT : entity work.loop_counter(Behavioral)
		port map(
			clk       => clk,
			reset     => reset,
			max_count => max_count,
			done      => done);

    -- Setting clock and reset default values
   -- reset <= '1', '0' after 3 ns; 

	clk_proc : process is
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
	end process;
	
	stim_proc : process is
	begin
	    reset <= '1';
	    wait for 9ns;
	    reset <= '0';
		wait for 10ns;
		max_count <= 7;
--		wait for 50ns;
--		reset <= '1';
--		wait for 10ns;
--		reset <= '0';
--		wait for 60ns;
--		max_count <= 2;
		wait;
	end process;

end Behavioral;