----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2019 10:29:08
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
	port (
		fa_i_bit1  : in std_logic;
		fa_i_bit2  : in std_logic;
		fa_i_carry : in std_logic;
		fa_o_sum   : out std_logic;
		fa_o_carry : out std_logic
	);
end full_adder;

architecture Behavioral of full_adder is
	-- Half ader 0
	signal ha0_i_bit1  : std_logic;
	signal ha0_i_bit2  : std_logic;
	signal ha0_o_sum   : std_logic;
	signal ha0_o_carry : std_logic;
	-- Half adder 1
	signal ha1_i_bit1  : std_logic;
	signal ha1_i_bit2  : std_logic;
	signal ha1_o_sum   : std_logic;
	signal ha1_o_carry : std_logic;
begin

	ha0 : entity work.half_adder
		port map(
			i_bit1  => ha0_i_bit1,
			i_bit2  => ha0_i_bit2,
			o_sum   => ha0_o_sum,
			o_carry => ha0_o_carry
		);

	ha1 : entity work.half_adder
		port map(
			i_bit1  => ha1_i_bit1,
			i_bit2  => ha1_i_bit2,
			o_sum   => ha1_o_sum,
			o_carry => ha1_o_carry
		);

	ha0_i_bit1 <= fa_i_bit1;
	ha0_i_bit2 <= fa_i_bit2;

	ha1_i_bit1 <= ha0_o_sum;
	ha1_i_bit2 <= fa_i_carry;

	fa_o_sum   <= ha1_o_sum;
	fa_o_carry <= ha0_o_carry or ha1_o_carry;

end Behavioral;