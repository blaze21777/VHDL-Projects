----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.07.2019 13:39:30
-- Design Name: 
-- Module Name: mealy_FSM - Behavioral
-- Project Name: How to create a mealy FSM
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

-- Example from page 97 http://freerangefactory.org/pdf/df344hdh4h8kjfh3500ft2/free_range_vhdl.pdf
entity mealy_FSM is
	port (
		-- Inputs
		set : in std_logic;
		x   : in std_logic;
		clk : in std_logic;
		-- Outputs
		Z2  : out std_logic;
		Y   : out std_logic

	);
end mealy_FSM;

architecture Behavioral of mealy_FSM is

	-- The states that can be taken `
	type state_type is (st0, st1, st2);

	-- State signals
	signal ps, ns : state_type;

begin

	sync_proc : process (clk,set) is
	begin
		if (set = '1') then
			ps <= st2;
		elsif rising_edge(clk) then
			ps <= ns;
		end if;
	end process;

	comb_proc : process (PS, X)
	begin
		Z2 <= '0';             -- pre-assign FSM outputs
		case PS is when ST0 => -- items regarding state ST0
				Z2 <= '0';             -- Mealy output always 0
				if (X = '0') then
					NS      <= ST0;
				else NS <= ST1;
				end if;
			when ST1 => -- items regarding state ST1 
				Z2 <= '0';  -- Mealy output always 0
				if (X = '0') then
					NS <= ST0;
				else
					NS <= ST2;
				end if;
			when ST2 => -- items regarding state ST2
				-- Mealy output handled in the if statement
				if (X = '0') then
					NS      <= ST0;
					Z2      <= '0';
				else NS <= ST2;
					Z2      <= '1';
				end if;
			when others => -- the catch all condition
				Z2 <= '1';
				NS <= ST0;
		end case;
	end process comb_proc;

	-- assign values representing the state variables
	with PS select
		Y <= '0' when st0,
		'1' when ST1,
		'0' when others;

end Behavioral;
