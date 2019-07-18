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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity T_Junction_tb is
	--  Port ( );
end T_Junction_tb;

architecture Behavioral of T_Junction_tb is
	
	-- Generic signals 
	constant clock_frequency_Hz : integer := 100;
	constant arm_lights         : integer := 9; -- Number of arms * 3 (number of lights)
	constant slip_lights        : integer := 2; -- Number of slip lanes 
	constant pedestrian_lights  : integer := 6; -- Number of pedestrian crossings 
	constant detector_num       : integer := 3; -- Number of detectors 
	
	-- Clock signals
	constant clk_period         : time    := 1000 ms / clock_frequency_Hz;
	
	-- Inputs
	signal clk                  : std_logic;
	signal reset                : std_logic;                                        -- Original did not have reset 
	signal dectector            : std_logic_vector(detector_num - 1 downto 0);      -- Detectors(A,B,C)
	signal pedestrian_button    : std_logic_vector(pedestrian_lights - 1 downto 0); -- slip button(A,B)
	
	-- Outputs
	signal arm                  : std_logic_vector(arm_lights - 1 downto 0);            -- Traffic lights arm(A,B,C)
	signal arm_slip             : std_logic_vector(slip_lights - 1 downto 0);       -- Slip lights slip(A,B)
	signal pedestrian_crossings : std_logic_vector(pedestrian_lights - 1 downto 0); -- Pedestrian lights slip(A,B)

begin

	i_T_Junction : entity work.T_Junction(Behavioral)
		generic map(
			clock_frequency_Hz => clock_frequency_Hz,
			arm_lights         => arm_lights,
			slip_lights        => slip_lights,
			pedestrian_lights  => pedestrian_lights,
			detector_num       => detector_num
		)
		port map(
			clk                  => clk,
			reset                => reset,
			dectector            => dectector,
			pedestrian_button    => pedestrian_button,
			arm                  => arm,
			arm_slip             => arm_slip,
			pedestrian_crossings => pedestrian_crossings
		);

	clk_process : process is
	begin
		clk <= '1';
		wait for clk_period;
		clk <= '0';
		wait for clk_period;
	end process;

	-- Testbench sequence 
	process is
	begin
		wait until rising_edge(Clk);
		wait until rising_edge(Clk);
	end process;

end Behavioral;