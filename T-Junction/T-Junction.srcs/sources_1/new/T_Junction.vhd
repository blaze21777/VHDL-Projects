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
-- Description: Assumptions: all green to red trasition and vice versa change to yellow first 
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

entity T_Junction is
	generic (
		clock_frequency_Hz : integer;
		arm_lights         : integer; -- Number of arms * 3 (number of lights)
		slip_lights        : integer; -- Number of slip lanes
		pedestrian_lights  : integer; -- Number of pedestrian crossings 
		detector_num       : integer  -- Number of detectors
	);
	port (
		-- Inputs
		clk                  : in std_logic;
		reset                : in std_logic;                                   -- Original did not have reset 
		detector             : in std_logic_vector(detector_num - 1 downto 0); -- Detectors(A,B,C)
		pedestrian_button    : in std_logic_vector(pedestrian_lights - 1 downto 0);
		-- Outputs
		-- Traffic lights arm(A,B,C) each arm with 3 lights 
		-- Order is G,Y,R 
		arm                  : out std_logic_vector(arm_lights - 1 downto 0);
		-- Slip lights slip(A,B) 
		arm_slip             : out std_logic_vector(slip_lights - 1 downto 0);
		-- Pedestrian lights (A,B)
		pedestrian_crossings : out std_logic_vector(pedestrian_lights - 1 downto 0)
	);
end T_Junction;

architecture Behavioral of T_Junction is

	-- Enumerated type declaration and state signal declaration
	type state_type is (
		transition1, -- Starts from state 1 onwards
		transition2, -- Phase_single_green,
		transition3, -- Phase_single_green
		transition4,
		transition5, -- Phase_all_red
		transition6,
		transition7, -- Ends at state 2, phase_single_green
		detection,
		busy,
		empty,
		quiet,
		phase_all_red,
		phase_single_green,
		transition_sequence_1_green,
		transition_sequence_red,
		transition_sequence1,
		transition_sequence2,
		phase1_pedestrian,
		phase2_pedestrian
	);
	signal ps, ns  : state_type;

	-- Timer signals 
	--	constant ClockFrequencyHz : integer   := 10; -- 10 Hz
	--	constant ClockPeriod      : time      := 1000 ms / ClockFrequencyHz;
	--	--signal Clk     : std_logic := '1';
	--	signal nRst               : std_logic := '0';
	--	signal Seconds            : integer;
	--	signal Minutes            : integer;
	--	signal Hours              : integer;

	-- Counter for counting clock periods, 1 minute max
	signal Counter : integer range 0 to clock_frequency_Hz * 60;
	
	-- Select between the 3 utilisations 
	-- Concat to use with selected assignment 
	signal detector_choice_quiet : std_logic_vector((arm_lights + detector_num) - 2 downto 0); 
	signal detector_choice_busy  : std_logic_vector((arm_lights + pedestrian_lights + detector_num) - 3 downto 0); 
	signal detector_choice_empty : std_logic_vector((arm_lights + pedestrian_lights + detector_num) - 3 downto 0); 
	 -- Use arm outputs as inputs 
	signal arm_signal : std_logic_vector(arm_lights - 1 downto 0);
begin

	--	-- Timer instantiation
	--	i_timer_main : entity work.T19_Timer(rtl)
	--		generic map(ClockFrequencyHz => ClockFrequencyHz)
	--		port map(
	--			Clk     => Clk,
	--			nRst    => nRst,
	--			Seconds => Seconds,
	--			Minutes => Minutes,
	--			Hours   => Hours);

	sync_proc : process (clk, ps) is
	begin
		if (reset = '1') then
			ps <= transition1;
		elsif rising_edge(clk) then
			ps <= ns;
		end if;
	end process;

	next_state_decode : process (clk, ps) is

		-- Procedure for changing state after a given time
		procedure ChangeState(ToState : state_type;
		Minutes                       : integer := 0;
		Seconds                       : integer := 0) is
		variable TotalSeconds         : integer;
		variable ClockCycles          : integer;
	begin
		TotalSeconds := Seconds + Minutes * 60;
		ClockCycles  := TotalSeconds * clock_frequency_Hz - 1;
		if Counter = ClockCycles then
			Counter <= 0;
			ns      <= ToState;
		end if;
	end procedure;

begin
    -- Signal assignments 
	Counter <= Counter + 1;
	arm <= arm_signal ;
	detector_choice_quiet <= (arm_signal & pedestrian_button);
	case ps is
		when transition1                 =>
			-- ChangeState(transition2, seconds => 1);  -- Testing only 
            ChangeState(detection, seconds => 1);
		when transition2                 =>
			ChangeState(transition3, seconds => 1);

		when transition3                 =>
			ChangeState(transition4, seconds => 1);

		when transition4                 =>
			ChangeState(transition5, seconds => 1);

		when transition5                 =>
			ChangeState(transition6, seconds => 1);

		when transition6                 =>
			ChangeState(transition7, seconds => 1);

		when transition7                 =>
			ChangeState(transition1, seconds => 1);

		when detection                   =>
		      
		when busy                        =>
		when empty                       =>
		when quiet                       =>
		when phase_all_red               =>
		when phase_single_green          =>
		when transition_sequence_1_green =>
		when transition_sequence_red     =>
		when transition_sequence1        =>
		when transition_sequence2        =>
		when phase1_pedestrian           =>
		when phase2_pedestrian           =>
		when others                      =>
	end case;
end process;

output_decode : process (ps) is

begin
	-- Default values
	arm_signal <= (others => '0');
	arm <= arm_signal ;
	-- arm                  <= (others => '0');
	pedestrian_crossings <= (others => '0');
	arm_slip             <= (others => '0');
	case ps is
		when transition1 =>
			arm      <= "100001100";
			arm_slip <= "00";
		when transition2 =>
			arm      <= "010001100";
			arm_slip <= "10";
		when transition3                 =>
		when transition4                 =>

		when transition5                 =>
		when transition6                 =>
		when transition7                 =>

		when detection                   =>
		when busy                        =>
		when empty                       =>
		when quiet                       =>
		when phase_all_red               =>
		when phase_single_green          =>
		when transition_sequence_1_green =>
		when transition_sequence_red     =>
		when transition_sequence1        =>
		when transition_sequence2        =>
		when phase1_pedestrian           =>
		when phase2_pedestrian           =>
		when others                      =>
	end case;
end process;

end Behavioral;