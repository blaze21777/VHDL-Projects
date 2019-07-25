----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.07.2019 09:25:28
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity half_adder_tb is
--  Port ( );
end half_adder_tb;

architecture Behavioral of half_adder_tb is
-- Inputs 
signal  A,B : std_logic;
  -- Outputs
 signal S,C : std_logic;
 signal overflow : std_logic;
 signal input_concat : std_logic_vector(1 downto 0);

begin

    (A,B) <= input_concat;

    i_half_adder : entity work.half_adder
     port map (
      A => A,
      B => B,
      S => S,
      C => C,
      overflow => overflow
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
