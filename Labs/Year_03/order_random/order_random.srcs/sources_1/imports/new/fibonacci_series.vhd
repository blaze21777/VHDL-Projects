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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fibonacci_series is
	generic (N : integer); -- Will be 8 
	port (
		clk, reset : in std_logic;
		start_a, start_b : in integer range 0 to 2 ** N - 1; -- allow change in sequence start points
		end_point : in integer range 0 to 2 ** N - 1; -- Max number to not exceed
		-- fibo_series : out integer range 0 to 2 ** N - 1; integer output
		output : out std_logic_vector(N-1 downto 0) -- Output will go to memory 
	);
end fibonacci_series;

architecture Behavioral of fibonacci_series is
	signal a, b, c : integer range 0 to 2 ** N - 1;
begin
	process (clk, reset)
	begin
		if (reset = '1') then
			b <= start_a;
			c <= start_b;
		elsif (clk'EVENT and clk = '1') then
		-- End condition
		  if (c > end_point) then 
		      -- Keep counting
		  else
			c <= b;
			b <= a;
		  end if;
		end if;
		a <= b + c;
	end process;
	--fibo_series <= c; -- Integer output
	output <= std_logic_vector(to_unsigned(c, output'length)); -- Vector output
end Behavioral;