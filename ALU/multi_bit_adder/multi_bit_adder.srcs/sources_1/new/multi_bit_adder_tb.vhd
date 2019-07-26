----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2019 14:22:59
-- Design Name: 
-- Module Name: multi_bit_adder_tb - Behavioral
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

entity multi_bit_adder_tb is
	--  Port ( );
end multi_bit_adder_tb;

architecture Behavioral of multi_bit_adder_tb is
	constant NUM_BITS   : integer := 4; -- 4 bit inputs/outputs
	signal mba_i_bits1  : std_logic_vector(NUM_BITS - 1 downto 0);
	signal mba_i_bits2  : std_logic_vector(NUM_BITS - 1 downto 0);
	signal mba_o_carry  : std_logic_vector(NUM_BITS - 1 downto 0);
	signal mba_o_sum    : std_logic_vector(NUM_BITS - 1 downto 0);
	signal overflow     : std_logic;

	signal input_concat : std_logic_vector((NUM_BITS * 2) - 1 downto 0);
begin
	-- This is annoying! only uses ulogic??
	(mba_i_bits1(3), mba_i_bits1(2), mba_i_bits1(1), mba_i_bits1(0),
	mba_i_bits2(3), mba_i_bits2(2), mba_i_bits2(1), mba_i_bits2(0)) <= input_concat;

	-- The Device Under Test (DUT)
	mba : entity work.multi_bit_adder
		generic map(NUM_BITS => NUM_BITS)
		port map(
			mba_i_bits1 => mba_i_bits1,
			mba_i_bits2 => mba_i_bits2,
			mba_o_carry => mba_o_carry,
			mba_o_sum   => mba_o_sum,
			overflow    => overflow
		);

	-- Test process
	process is
	begin
		wait for 10ns;
		for i in 0 to 256 loop
			input_concat <= std_logic_vector(to_unsigned(i, input_concat'length));
			wait for 10ns;
		end loop;
	end process;

end Behavioral;
