----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2019 01:05:34
-- Design Name: 
-- Module Name: parity_checker_moore - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity parity_checker_moore is
  Port ( 
        clk    : in std_logic;
		rst    : in std_logic;
		x      : in std_logic_vector(1 downto 0);
		parity : out std_Logic
  );
end parity_checker_moore;

architecture Behavioral of parity_checker_moore is

-- Decalare state that can be taken
	type state_type is (S0, S1);
	signal state, next_state : state_type;

begin

    -- Sync everything to the clock
	sync_proc : process (clk) is
	begin
		if rising_edge(clk) then
			if rst = ('1') then
				state <= S0;
			else
				state <= next_state;
			end if;
		end if;
	end process;
 
	-- Decide on the next state
	next_state_decode : process (clk) is
	begin
		--next_state <= S0;
		case (state) is
			when S0 => 
				if (x = "01") then
					next_state <= S1;
				else
					next_state <= S0;
				end if;
			when S1 => 
				if (x = "01") then
					next_state <= S0;
				else
					next_state <= S1;
				end if;
		end case;
	end process;
 
	-- Decode the ouput
	output_decode : process (clk) is
	begin
		parity <= '0';
		case (state) is
			when S0 => 
				parity <= '0';
			when S1 => 
				parity <= '1';
			when others => 
			    parity <= '0';
		end case;
	end process;

end Behavioral;
