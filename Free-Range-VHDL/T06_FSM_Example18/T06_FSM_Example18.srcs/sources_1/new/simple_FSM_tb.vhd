----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.07.2019 09:44:02
-- Design Name: 
-- Module Name: simple_FSM_tb - Behavioral
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

entity simple_FSM_tb is
	--  Port ( );
end simple_FSM_tb;

architecture Behavioral of simple_FSM_tb is

	-- Input signals 
	signal clk          : std_logic;
	signal clr          : std_logic;
	signal tog_en       : std_logic;
	-- Output signals 
	signal Z1           : std_logic;

	-- Clock signals
	constant clk_period : time := 10ns;
	
begin

	-- FSM instantiation 
	i_FSM : entity work.simple_FSM(Behavioral) port map (
		clk    => clk,
		clr    => clr,
		tog_en => tog_en,
		z1     => z1
		);

	-- Clock process
	clk_proc : process is
	begin
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
	end process;

	-- Testbench processs
	test : process is
	begin
		wait for 10ns;
		tog_en <= '1';
		wait for 10ns;
		tog_en <= '0';
		wait for 40ns;
		clr <= '1';
		wait for 20ns;
		clr <= '0';
		wait for 10ns;
		clr <= '1';
		tog_en <= '1';
		wait for 30ns;
        clr <= '0';
		tog_en <= '0';

	end process;
end Behavioral;
