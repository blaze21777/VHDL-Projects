----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2019 18:39:18
-- Design Name: 
-- Module Name: decoder_3to8 - Behavioral
-- Project Name: 3 to 8 decoder with concurrent assignmnet
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

-- Decoder tutorial used https://www.youtube.com/watch?v=FNmhsHO_osU

entity decoder_3to8 is
	generic (data_width : integer); -- Not really required but done for practice 
	port (
		-- inputs
		A, B, C : in std_logic;
		-- Outputs
		output  : out std_logic_vector(data_width - 1 downto 0)
	);
end decoder_3to8;

architecture Behavioral of decoder_3to8 is
	-- Inputs selected signal assignment 
	signal inputs_concat : std_logic_vector(2 downto 0);

	-- Output condition signal assignment 
	signal output_cond   : std_logic_vector(data_width - 1 downto 0);
begin
	-- Using selected signal assignment
	inputs_concat                      <= (A & B & C);
	with (inputs_concat) select output <= "10000000" when "000",
                                          "01000000" when "001",
                                          "00100000" when "010",
                                          "00010000" when "011",
                                          "00001000" when "100",
                                          "00000100" when "101",
                                          "00000010" when "110",
                                          "00000001" when "111",
	(others => 'X') when others;

	-- Using conditional assignment 
	output_cond <= "10000000" when (A = '0' and B = '0' and C = '0') else
		           "01000000" when (A = '0' and B = '0' and C = '1') else
		           "00100000" when (A = '0' and B = '1' and C = '0') else
                   "00010000" when (A = '0' and B = '1' and C = '1') else
                   "00001000" when (A = '1' and B = '0' and C = '0') else
                   "00000100" when (A = '1' and B = '0' and C = '1') else
                   "00000010" when (A = '1' and B = '1' and C = '0') else
                   "00000001" when (A = '1' and B = '1' and C = '1') else
		(others => 'X');
end Behavioral;
