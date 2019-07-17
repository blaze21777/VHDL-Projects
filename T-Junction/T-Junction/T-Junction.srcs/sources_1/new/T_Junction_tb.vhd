----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.07.2019 11:38:40
-- Design Name: 
-- Module Name: T_Junction_tb - Behavioral
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

entity T_Junction_tb is
	--  Port ( );
end T_Junction_tb;

architecture Behavioral of T_Junction_tb is
	-- Clock signals
	constant clk_period    : time := 10ns;
	-- Inputs
	signal clk             : std_logic;
	signal reset           : std_logic;                    -- Original did not have reset 
	signal dectector       : std_logic;                    -- Detectors(A,B,C)
	-- Outputs
	signal arm             : std_logic_vector(2 downto 0); -- Traffic lights arm(A,B,C)
	signal arm_slip        : std_logic_vector(1 downto 0); -- Slip lights slip(A,B)
	signal slip_pedestrian : std_logic_vector(1 downto 0); -- Pedestrian lights slip(A,B)

begin

	i_T_Junction : entity work.T_Junction(Behavioral)
		port map(
			clk             => clk,
			reset           => reset,
			dectector       => dectector,
			arm             => arm,
			arm_slip        => arm_slip,
			slip_pedestrian => slip_pedestrian
		);

	clk_process : process is
	begin
		clk <= '1';
		wait for 10ns;
		clk <= '0';
		wait for 10ns;
	end process;

end Behavioral;