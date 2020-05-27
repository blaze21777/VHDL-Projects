----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2020 05:59:07
-- Design Name: 
-- Module Name: clk_divider_fsm - Behavioral
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

entity clk_divider_fsm is
  Port (clk : in std_logic;
        reset : in std_logic;
        Y   : out std_logic); -- clk output
end clk_divider_fsm;
 
architecture Behavioral of clk_divider_fsm is

    -- Decalare states that can be taken
    type state_type is (S0, S1, s2);
    signal state, next_state : state_type;
    
begin

    sync_proc : process (clk)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				state <= S0;
			else
				state <= next_state;
			end if;
		end if;
	end process;
    
    next_state_output_decode : process (clk)
	begin
		case (state) is
			when S0 => 
				next_state <= s1;
				Y <= '1';
			when S1 => 
				next_state <= s2;
				Y <= '0';
			when S2 => 
			     Y <= '0';
		end case;
	end process;


end Behavioral;
