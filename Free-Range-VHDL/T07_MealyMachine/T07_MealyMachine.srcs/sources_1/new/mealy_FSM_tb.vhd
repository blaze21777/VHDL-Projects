----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.07.2019 18:03:37
-- Design Name: 
-- Module Name: mealy_FSM_tb - Behavioral
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

entity mealy_FSM_tb is
	--  Port ( );
end mealy_FSM_tb;

architecture Behavioral of mealy_FSM_tb is
	signal set          : std_logic;
	signal x            : std_logic;
	signal clk          : std_logic;
	-- Outputs
	signal Z2           : std_logic;
	signal Y            : std_logic;


	-- Clock signals
	constant clk_period : time := 10ns;
begin

	i_FSM : entity work.mealy_FSM(Behavioral) port map(
		set => set,
		x   => x,
		clk => clk,
		Z2  => Z2,
		Y   => Y
		);

	-- Clock process
	clock_process : process is
	begin
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
	end process;

	-- Test bench process
	test_proc : process is
	begin
		wait for 11ns;
		x <= '1';
		wait for 10ns;
		x <= '0';
	end process;

	-- Set process
	set_proc : process is
	begin
		wait for 11ns;
		set <= '1';
		wait for 10ns;
		set <= '0';
		wait for 50ns;
	end process;

end Behavioral;