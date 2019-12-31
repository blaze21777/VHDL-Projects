----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2019 11:12:48
-- Design Name: 
-- Module Name: loop_counter - Behavioral
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

entity loop_counter is
	port (
		clk       : in std_logic;
		reset     : in std_logic;
		max_count : in integer;
		done      : out std_logic);
end loop_counter;

architecture Behavioral of loop_counter is

	type state_type is (reset_s, count1_s, count2_s);
	signal state, next_state : state_type;

	signal count_sig         : integer := 0;

begin

	-- The clock process
	sync_proc : process (clk)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				state <= reset_s;
			else
				state <= next_state;
			end if;
		end if;
	end process;

	dow_work : process (clk) is
	begin
		case state is
			when reset_s  =>
            next_state <= count1_s;
            count_sig <= 0;
            done <= '0';
			when count1_s =>
				if (count_sig = max_count) then
					done <= '1';
				elsif rising_edge(clk) then
					count_sig  <= count_sig + 1;
					--next_state <= reset_s;
--					next_state <= count2_s;
				end if;

--			when count2_s =>
--				if (count_sig = max_count) then
--					done <= '1';
--				else
--					count_sig  <= count_sig + 1;
--					next_state <= count2_s;
--				end if;

			when others =>
				next_state <= reset_s;

		end case;
	end process;

end Behavioral;