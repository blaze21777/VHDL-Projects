----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2019 09:38:58
-- Design Name: 
-- Module Name: DFF - Behavioral
-- Project Name: Behavioural model of a D flip flop
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

-- Diagram on page 78 >> http://freerangefactory.org/pdf/df344hdh4h8kjfh3500ft2/free_range_vhdl.pdf
entity DFF is
	port (
		-- Inputs
		clk, D : in std_logic;
		-- Outputs
		Q      : out std_logic
	);
end DFF;

architecture Behavioral of DFF is

begin

	DFF : process (clk) is
	begin
		-- The lack of an else statement means nothing changes
		-- when the if statement is not met e.g storing a bit value
		if rising_edge(clk) then
			Q <= D;
		end if;

	end process DFF;

end Behavioral;
