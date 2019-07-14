----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2019 13:55:34
-- Design Name: 
-- Module Name: simple_FSM - Behavioral
-- Project Name: Implementation of a smiple Finite State Machine
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

entity simple_FSM is
	port (
		-- Inputs
		clk    : in std_logic;
		clr    : in std_logic;
		tog_en : in std_logic;
		-- Outputs
		Z1     : out std_logic
	);
end simple_FSM;

architecture Behavioral of simple_FSM is

	-- The states that can be taken
	type state is (st0, st1);

	-- State signals
	signal ps, ns : state;

begin
	sync_proc : process (clk,ns,clr) is
	begin
	    -- Asynchronous reset
		if (clr = '1') then
			ps <= st0;
		elsif rising_edge(clk) then
			ps <= ns;  -- Allows FSM to change to st1 
		end if;
	end process sync_proc;

	next_state_decode : process (tog_en, ps) is
	begin
		case ps is
			when st0 =>
				-- Stay in current state if not '1'
				if (tog_en = '1') then
					ns <= st1;
                else ns <= st0;  -- Required to prevent wrong state on clr
				end if;

			when st1 =>
				-- Stay in current state if not '1'
				if (tog_en = '1') then
					ns <= st0;
                else ns <= st1;  -- Required to prevent wrong state on clr
				end if;
			when others =>
				ns <= st0;
		end case;
	end process next_state_decode;

	output_decode : process (ps) is
	begin
		Z1 <= '0'; -- Pre-assign output
		case ps is
			when st0 =>
				z1 <= '0'; -- Moore output

			when st1 =>
				z1 <= '1'; -- Moore output

			when others =>
				Z1 <= 'X'; -- Error if this is reached
		end case;
	end process output_decode;

end Behavioral;
