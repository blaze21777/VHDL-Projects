----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2019 15:22:58
-- Design Name: 
-- Module Name: hybrid_fsm_tb - Behavioral
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

entity hybrid_fsm_tb is
	--  Port ( );
end hybrid_fsm_tb;

architecture Behavioral of hybrid_fsm_tb is

	-- Signal declaration 
	signal x          : std_logic;
	signal rst        : std_logic;
	signal clk        : std_logic;
	signal Z1_moore   : std_logic;
	signal Z2_mealy   : std_logic;
	signal clk_period : time := 10ns;
	
begin

	-- The unit under test
	hybrid_fsm : entity work.hybrid_fsm(Behavioral)
		port map(
			x        => x,
			rst      => rst,
			clk      => clk,
			Z1_moore => Z1_moore,
			Z2_mealy => Z2_mealy
		);
		
	-- The clock process 
	clk_proc : process is
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
	end process;

	-- The testing process
	test_proc : process is
	begin
	    wait for clk_period;
		x <= '0';
		wait for clk_period;
		x <= '1';
		-- wait for clk_period;
	end process;
	
	-- The reset process 
	reset : process is 
	begin 
        rst <= '0';
        wait for clk_period * 4;
        rst <= '1';
        wait for clk_period;
        rst <= '0';
	end process;

end Behavioral;