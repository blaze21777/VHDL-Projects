----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 15.04.2020 17:19:56
-- Design Name:
-- Module Name: fibonacci_series - Behavioral
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

entity fibonacci_series is
	generic (N : integer := 16); ------number of bits
	port (
		clk, reset : in bit;
		fibo_series : out integer range 0 to 2 ** N - 1
	);
end fibonacci_series;

architecture Behavioral of fibonacci_series is
	signal a, b, c : integer range 0 to 2 ** N - 1;
begin
	process (clk, reset)
	begin
		if (reset = '1') then
			b <= 1;
			c <= 0;
		elsif (clk'EVENT and clk = '1') then
			c <= b;
			b <= a;
		end if;
		a <= b + c;
	end process;
	fibo_series <= c;
end Behavioral;