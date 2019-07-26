----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2019 13:00:07
-- Design Name: 
-- Module Name: multi_bit_adder - Behavioral
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

entity multi_bit_adder is
	generic (NUM_BITS : integer);
	port (
		mba_i_bits1 : in std_logic_vector(NUM_BITS - 1 downto 0);
		mba_i_bits2 : in std_logic_vector(NUM_BITS - 1 downto 0);
		mba_o_carry : out std_logic_vector(NUM_BITS - 1 downto 0);
		mba_o_sum   : out std_logic_vector(NUM_BITS - 1 downto 0);
		overflow    : out std_logic
	);
end multi_bit_adder;

architecture Behavioral of multi_bit_adder is
	-- Full adder 0 
	--	signal fa0_i_bit1     : std_logic;
	--	signal fa0_i_bit2     : std_logic;
	--	signal fa0_i_carry    : std_logic;
	--	signal fa0_o_sum      : std_logic;
	--	signal fa0_o_carry    : std_logic;

	-- Full adder NUM_BITS
	signal vector_i_bit1  : std_logic_vector (NUM_BITS - 1 downto 0);
	signal vector_i_bit2  : std_logic_vector (NUM_BITS - 1 downto 0);
	signal vector_i_carry : std_logic_vector (NUM_BITS - 1 downto 0);
	signal vector_o_sum   : std_logic_vector (NUM_BITS - 1 downto 0);
	signal vector_o_carry : std_logic_vector (NUM_BITS - 1 downto 0);

begin
	gen_add : for i in 0 to NUM_BITS - 1 generate
		first_bit : if i = 0 generate
			fa0 : entity work.full_adder
				port map(
					fa_i_bit1  => vector_i_bit1(I),
					fa_i_bit2  => vector_i_bit2(I),
					fa_i_carry => '0',
					fa_o_carry => vector_o_carry(I),
					fa_o_sum   => vector_o_sum(I)
				);
		end generate first_bit;

		other_bits : if i > 0 generate
			fax : entity work.full_adder
				port map(
					fa_i_bit1  => vector_i_bit1(I),
					fa_i_bit2  => vector_i_bit2(I),
					fa_i_carry => vector_o_carry(I - 1),
					fa_o_carry => vector_o_carry(I),
					fa_o_sum   => vector_o_sum(I)
				);
		end generate other_bits;

	end generate gen_add;

	vector_i_bit1 <= mba_i_bits1;
	vector_i_bit2 <= mba_i_bits2;

	mba_o_sum     <= vector_o_sum;
	mba_o_carry   <= vector_o_carry;
	overflow      <= '1' when (mba_i_bits1(NUM_BITS - 1) = mba_i_bits2(NUM_BITS - 1) and
		                       vector_o_sum(NUM_BITS - 1) /= mba_i_bits1(NUM_BITS - 1))
		else '0';

end Behavioral;