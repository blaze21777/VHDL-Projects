----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2020 14:39:33
-- Design Name: 
-- Module Name: bubble_sort - Behavioral
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
library ieee;
use ieee.std_logic_1164.all;

package array_type is
    type bubble is array (0 to 15) of std_logic_vector(3 downto 0);
    
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.array_type.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
    use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bubble_sort is
    port (
             clk:             in  std_logic;
             reset:           in  std_logic;
             in_array:        in  bubble;
             sorted_array:    out bubble 
        );
end bubble_sort;

architecture Behavioral of bubble_sort is

begin
    BSORT:
    process (clk)
        variable temp:      std_logic_vector (3 downto 0);
        variable var_array:     bubble;        
    begin
        var_array := in_array;
        if rising_edge(clk) then
            for j in bubble'LEFT to bubble'RIGHT - 1 loop 
                for i in bubble'LEFT to bubble'RIGHT - 1 - j loop 
                    if unsigned(var_array(i)) > unsigned(var_array(i + 1)) then
                        temp := var_array(i);
                        var_array(i) := var_array(i + 1);
                        var_array(i + 1) := temp;
                    end if;
                end loop;
            end loop;
            sorted_array <= var_array;
        end if;
    end process;

end Behavioral;
