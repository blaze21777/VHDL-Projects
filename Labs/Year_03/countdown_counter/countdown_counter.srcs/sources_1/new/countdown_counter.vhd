----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2020 09:52:42
-- Design Name: 
-- Module Name: countdown_counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity countdown_counter is
    port (
        clock: in std_logic;
        reset: in std_logic;
        en: in std_logic;
        load: in std_logic;
        value: in std_logic_vector(3 downto 0);
        output: out std_logic_vector(3 downto 0)
      );
end countdown_counter;

architecture Behavioral of countdown_counter is

    signal count: integer;
    signal output_buf : std_logic_vector(3 downto 0);
begin

     process (clock, reset) begin
        if reset = '1' then
            count <= 0;
        elsif rising_edge(clock) then
            if load = '1' then
                count <= to_integer(unsigned(value));
            else
                count <= count - 1;
            end if;
        end if;
    end process;
    
    --output_buf <= std_logic_vector(to_unsigned(count,output_buf'length));
    --output <= output_buf;
    output <= std_logic_vector(to_unsigned(count,output'length));

end Behavioral;
