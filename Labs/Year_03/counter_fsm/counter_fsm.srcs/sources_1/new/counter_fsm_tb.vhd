----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2019 12:17:41
-- Design Name: 
-- Module Name: counter_fsm_tb - Behavioral
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

entity counter_fsm_tb is
--  Port ( );
end counter_fsm_tb;

architecture Behavioral of counter_fsm_tb is

signal clk, rst :  std_logic;
	signal	output : std_logic_vector(3 downto 0);
	signal clk_period : time := 20ns;
begin

-- Unit under test
counter_fsm : entity work.counter_fsm(Behavioral)
port map(
    clk => clk,
    rst => rst,
    output =>output
);

-- The clock process 
clk_proc : process is 
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

test_proc : process is
begin
wait for 33ns;
rst <= '1';
end process;

end Behavioral;
