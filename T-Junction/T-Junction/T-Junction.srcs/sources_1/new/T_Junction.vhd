----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.07.2019 11:04:50
-- Design Name: 
-- Module Name: T_Junction - Behavioral
-- Project Name: T-Junction traffic controller
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

entity T_Junction is
	port (
		-- Inputs
		clk             : in std_logic;
		reset           : in std_logic;                     -- Original did not have reset 
		dectector       : in std_logic;                     -- Detectors(A,B,C)
		-- Outputs
		arm             : out std_logic_vector(2 downto 0); -- Traffic lights arm(A,B,C)
		arm_slip        : out std_logic_vector(1 downto 0); -- Slip lights slip(A,B)
		slip_pedestrian : out std_logic_vector(1 downto 0)  -- Pedestrian lights slip(A,B)
	);
end T_Junction;

architecture Behavioral of T_Junction is

	-- States that can be taken
	type state_type is (phase1, phase2, detection, busy,
		empty, quiet, phase_all_red,
		phase_single_green,
		transition_sequence_1_green,
		transition_sequence_red,
		transition_sequence1,
		transition_sequence2,
		phase1_pedestrian,
		phase2_pedestrian
	);
	signal ps, ns : state_type;

begin

	sync_proc : process (clk, ps) is
	begin
		if (reset = '1') then
			ps <= phase1;
		elsif rising_edge(clk) then
			ps <= ns;
		end if;
	end process;

end Behavioral;