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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity order_random is
	port (
		clk   : in std_logic;
		reset : in std_logic);
end order_random;

architecture Behavioral of order_random is
	-- Pseduo_random signals
	signal fib_in1 : integer;
    signal fib_in2 :  integer;
    signal fib_in3 :  integer;
    signal fib_in4 :  integer;
    signal fib_end1 : integer;
    signal fib_end2 : integer;
	signal number_out   : std_logic_vector(31 downto 0); -- Has to be 32-bit output

	-- Memory signals 
	constant data_width : integer := 8;
	constant addr_width : integer := 8;
	signal we           : std_logic;
	signal addr         : std_logic_vector(addr_width - 1 downto 0);
	signal din          : std_logic_vector(data_width - 1 downto 0);
	signal dout         : std_logic_vector(data_width - 1 downto 0);

	-- Sorting signals 
	constant length     : integer := 32; -- 32 bit 
	signal sort_value   : std_logic_vector(length - 1 downto 0);
	signal sorted_value : std_logic_vector(length - 1 downto 0);

begin

	-- Pseduo_random instatiation
	pseudo_random : entity work.pseudo_random_num(Behavioral)
		port map(
			clk    => clk,
			reset  => reset,
			fib_in1 => fib_in1,
            fib_in2 => fib_in2,
            fib_in3 => fib_in3,
            fib_in4 => fib_in4,
            fib_end1 => fib_end1,
            fib_end2 => fib_end2,
			number => number_out);

	-- Memory instatiation
	memory : entity work.single_port_ram(Behavioral)
		generic map(
			addr_width => addr_width,
			data_width => data_width
		)
		port map(
			clk  => clk,
			we   => we,
			addr => addr,
			din  => din,
			dout => dout
		);

	-- Sorting instatiation
	sorting : entity work.sorting_module(Behavioral)
		generic map(length => length) -- 32 bit num
		port map(
			clk          => clk,
			reset        => reset,
			sort_value   => sort_value,
			sorted_value => sorted_value
		);

end Behavioral;