----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 13:55:46
-- Design Name: 
-- Module Name: counter_fsm - Behavioral
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

entity counter_fsm is
  Port (
  clk,rst : in std_logic;
  output : out std_logic_vector(3 downto 0)
   );
end counter_fsm;

architecture Behavioral of counter_fsm is

    -- Decalare states that can be taken
	type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
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

    next_state_output_decode : process (clk) 
    begin 
    case (state) is
    when S0 => 
    next_state <= s1;
    output <= "0000";
    When S1 => 
     next_state <= s2;
    output <= "0001";
    When S2 =>
     next_state <= s1;
    output <= "0000";
    When S3 =>
    When S4 =>
    When S5 =>
    When S6 =>
    When S7 =>
    When S8 =>
    When S9 =>
    when others => 
    end case;
    end process;
    
    
end Behavioral;
