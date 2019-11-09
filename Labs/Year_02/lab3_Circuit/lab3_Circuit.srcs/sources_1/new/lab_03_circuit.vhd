----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.08.2019 09:57:29
-- Design Name: 
-- Module Name: lab_03_circuit - Behavioral
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

entity lab_03_circuit is
	port (
		SW0 : in STD_LOGIC;
		SW1 : in STD_LOGIC;
		SW2 : in STD_LOGIC;
		LD0 : out STD_LOGIC
	);
end lab_03_circuit;

architecture Behavioral of lab_03_circuit is

	signal a : std_logic; -- Output
	signal b : std_logic; -- And in 1
	signal c : std_logic; -- And in 2
	signal d : std_logic; -- Not in

begin

b <= SW0;
c <= SW1;
d <= SW2;

a <= (b and c) or not d;
LD0 <= a;

end Behavioral;