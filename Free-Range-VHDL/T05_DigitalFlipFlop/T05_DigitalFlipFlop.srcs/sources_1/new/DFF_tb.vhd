----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2019 09:47:36
-- Design Name: 
-- Module Name: DFF_tb - Behavioral
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

entity DFF_tb is
	--  Port ( );
end DFF_tb;

architecture Behavioral of DFF_tb is
	-- Clock signals 
	constant clk_period : time := 20ns ;

	-- Inputs of DFF
    signal clk, D : std_logic;

	-- Outputs of DFF
	signal Q : std_logic;

begin

	-- Entity instantiation of DFF
	i_DFF : entity work.DFF port map (
		clk => clk,
		D   => D,
		Q   => Q
		);

	-- Clock process 
	-- clk <= not clk after clk_period / 2;
	
	clk_process : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS;
	
	-- Testbench process 
	stim_proc : process is
	begin
		wait for 20ns;
		D <= '0';
		wait for 15ns;
		D <= '1';

	end process stim_proc;
end Behavioral;
