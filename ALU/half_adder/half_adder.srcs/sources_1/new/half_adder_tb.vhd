----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2019 10:13:33
-- Design Name: 
-- Module Name: half_adder_tb - Behavioral
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity half_adder_tb is
	--  Port ( );
end half_adder_tb;

architecture Behavioral of half_adder_tb is
	signal i_bit1       : std_logic;
	signal i_bit2       : std_logic;
	signal o_sum        : std_logic;
	signal o_carry      : std_logic;
	signal input_concat : std_logic_vector(1 downto 0);
begin

	(i_bit1, i_bit2) <= input_concat;

	ha : entity work.half_adder
		port map(
			i_bit1  => i_bit1,
			i_bit2  => i_bit2,
			o_sum   => o_sum,
			o_carry => o_carry
		);

	-- Test process
	process is
	begin
		wait for 10ns;
		for i in 0 to 3 loop
			input_concat <= std_logic_vector(to_unsigned(i, input_concat'length));
			wait for 10ns;
		end loop;
	end process;
end Behavioral;
