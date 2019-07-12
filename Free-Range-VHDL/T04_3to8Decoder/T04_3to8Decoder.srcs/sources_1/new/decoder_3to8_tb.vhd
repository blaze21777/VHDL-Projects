----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2019 18:57:50
-- Design Name: 
-- Module Name: decoder_3to8_tb - Behavioral
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

entity decoder_3to8_tb is
	--  Port ( );
end decoder_3to8_tb;

architecture Behavioral of decoder_3to8_tb is

	constant data_width : integer := 8;
	-- Inputs 
	signal A, B, C      : std_logic;
	signal input        : std_logic_vector(2 downto 0);
	-- Outputs
	signal output       : std_logic_vector(data_width - 1 downto 0);

begin

	(A, B, C) <= input;

	i_decoder : entity work.decoder_3to8(Behavioral)
		generic map(data_width => data_width)
		port map(
			A      => A,
			B      => B,
			C      => C,
			output => output
		);

	process is
	begin
		wait for 10ns;       -- To test fail conditions 
		for i in 0 to 8 loop -- Loop number controls how high the count is
			-- Still need to work out what the conversion function are doing
			-- to_unsigned converts "i" to unsinged of size "input'length"
			-- This is converted to a std_logic_vector
			-- Then assigned to the input
			input <= std_logic_vector(to_unsigned(i, input'length));
			wait for 10ns; -- This statement is require to update signal 
			-- Maybe a varaible would remove the need for it
		end loop;

	end process;

end Behavioral;
