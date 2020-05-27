----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2020 06:31:26
-- Design Name: 
-- Module Name: add_comp - Behavioral
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

entity add_comp is
 Port (
    a,b : in std_logic_vector(2 downto 0);
	reg_comp : out std_logic;
	reg_sum  : out std_logic_vector(3 downto 0));
end add_comp;

architecture Behavioral of add_comp is
    
    -- Signals to act as register to store values
    signal comp : std_logic := '0';
	signal sum  : std_logic_vector(3 downto 0) := "0000";
   
begin
    
   -- SUM CAUSED UNDEFINED ERRORS: program doesn't work with it
   -- reg_sum <= std_logic_vector(unsigned(a) - unsigned(b));
    
    process (a,b)
	begin
		if a > b then 
			comp <= '1';
		else 
		    comp <= '0';
		end if;
	end process;
	
	reg_comp <= comp;
	--reg_sum  <= sum;

end Behavioral;
