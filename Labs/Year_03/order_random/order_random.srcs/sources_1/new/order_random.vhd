----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2020 15:21:52
-- Design Name: 
-- Module Name: order_random - Behavioral
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

entity order_random is
  Port (clk : in std_logic;
        reset : in std_logic );
end order_random;

architecture Behavioral of order_random is
 -- Pseduo_random signals
   signal number : std_logic_vector(31 downto 0);  -- Has to be 32-bit output

begin

-- Pseduo_random instatiation
	Pseduo_random : entity work.pseudo_random_num(Behavioral)
		port map(
		clk => clk,
		reset => reset,
		number => number);
-- Memory instatiation

-- Ordering instatiation


end Behavioral;
