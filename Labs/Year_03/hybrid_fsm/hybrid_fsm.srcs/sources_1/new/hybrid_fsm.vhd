----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2019 13:26:05
-- Design Name: 
-- Module Name: hybrid_fsm - Behavioral
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

entity hybrid_fsm is
	port (
		x        : in std_logic;
		rst      : in std_logic;
		clk      : in std_logic;
		Z1_moore : out std_logic;
		Z2_mealy : out std_logic
	);
end hybrid_fsm;

architecture Behavioral of hybrid_fsm is

	-- Decalare state that can be taken
	type state_type is (S0, S1, S2, S3);
	signal state, next_state : state_type;

begin

	sync_proc : process (clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				state <= S0;
			else
				state <= next_state;
			end if;
		end if;
	end process;

	next_state_decode : process (state, x)
	begin
		next_state <= S0;

		case (state) is

				-- State 0
			when S0 =>
				if (x = '0') then
					next_state <= S1;
				else
					next_state <= S0;
				end if;

				-- State 1       
			when S1 =>
				if (x = '0') then
					next_state <= S2;
				else
					next_state <= s1;
				end if;

				-- State 2
			when S2 =>
				if (x = '0') then
					next_state <= S3;
				else
					next_state <= S2;
				end if;

				-- State 3
			when S3 =>
				if (x = '0') then
					next_state <= S0;
				else
					next_state <= S3;
				end if;

				-- Catch all, should never reach here
			when others =>
				next_state <= S0;
		end case;
	end process;
	
	outut_decode : process (state, x)
	begin
		Z1_moore <= '0';
		Z2_mealy <= '1';
		case (state) is

				-- State 0
			when S0 =>
				Z1_moore <= '1';
				if (x = '0') then
					Z2_mealy <= '0';
				elsif (x = '1') then
					Z2_mealy <= '1';
				end if;

				-- State 1
			when S1 =>
				Z1_moore <= '1';
				if (x = '0') then
					Z2_mealy <= '0';
				elsif (x = '1') then
					Z2_mealy <= '1';
				end if;

				-- State 2
			when S2 =>
				Z1_moore <= '0';
				if (x = '0') then
					Z2_mealy <= '0';
				elsif (x = '1') then
					Z2_mealy <= '1';
				end if;

				-- State 3
			when S3 =>
				Z1_moore <= '1';
				if (x = '0') then
					Z2_mealy <= '0';
				elsif (x = '1') then
					Z2_mealy <= '1';
				end if;

				-- Catch all, should never reach here
			when others =>
				Z1_moore <= '0';
				Z2_mealy <= '0';
		end case;
	end process;
end Behavioral;