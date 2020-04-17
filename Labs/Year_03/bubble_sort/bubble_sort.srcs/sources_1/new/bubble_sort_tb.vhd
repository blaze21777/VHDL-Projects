----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2020 14:43:10
-- Design Name: 
-- Module Name: bubble_sort_tb - Behavioral
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
use work.array_type.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bubble_sort_tb is
--  Port ( );
end bubble_sort_tb;

architecture Behavioral of bubble_sort_tb is
    
    signal clk:             std_logic := '0';
    signal reset:           std_logic := '0';
    signal in_array:        bubble :=
                   (x"F", x"E", x"D", x"C", x"B", x"A", x"9", x"8",
                    x"7", x"6", x"5", x"4", x"3", x"2", x"1", x"0");
    signal sorted_array:    bubble;
    
begin
    DUT:
    entity work.bubble_sort(Behavioral)
        port map (
            clk => clk,
            reset => reset,
            in_array => in_array,
            sorted_array => sorted_array
        );
CLOCK:
    process
    begin
        wait for 10 ns;
        clk <= not clk;
        if now > 30 ns then
            wait;
        end if;
    end process;

end Behavioral;
