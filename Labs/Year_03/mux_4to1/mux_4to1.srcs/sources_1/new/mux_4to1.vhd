----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2019 18:52:24
-- Design Name: 
-- Module Name: mux_7to1 - Behavioral
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

entity mux_4to1 is
	port (
		a, b : in std_logic_vector(7 downto 0);
		sel  : in std_logic_vector(1 downto 0);
		x    : out std_logic_vector(7 downto 0)
	);
end mux_4to1;

architecture Behavioral of mux_4to1 is

begin
	process (sel) is
	begin
		case (sel) is
			when "00" => x <= (others => '0');
			when "01" => x <= a;
			when "10" => x <= b;
            when "11" => x <= (others => 'Z');    
			when others => x <= (others => '0');
		end case;
	end process;

end Behavioral;
