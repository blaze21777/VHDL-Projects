----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2020 14:38:25
-- Design Name: 
-- Module Name: sorting_module - Behavioral
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

entity sorting_module is
  generic(length : integer); -- 32 bit num
  Port (
  clk : in std_logic;
  reset : in std_logic;
  sort_value : in std_logic_vector(length-1 downto 0);
  sorted_value : out std_logic_vector(length-1 downto 0));
end sorting_module;

architecture Behavioral of sorting_module is

    -- Bubble sort signals 
    signal in_array:         bubble;
    signal sorted_array:     bubble;

begin
    -- Bubble sort instatiation 
    bubble : entity work.bubble_sort(Behavioral)
        port map (
            clk => clk,
            reset => reset,
            in_array => in_array,
            sorted_array => sorted_array
        );

end Behavioral;
