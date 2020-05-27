----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2020 06:55:24
-- Design Name: 
-- Module Name: add_comp_tb - Behavioral
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

entity add_comp_tb is
--  Port ( );
end add_comp_tb;

architecture Behavioral of add_comp_tb is

    signal a,b :  std_logic_vector(2 downto 0);
    signal reg_comp : std_logic;
	signal reg_sum  : std_logic_vector(3 downto 0);
	
begin
    
    DUT : entity work.add_comp(Behavioral)
          port map(
            a => a,
            b => b,
            reg_comp => reg_comp,
            reg_sum => reg_sum
          );
    
    process is
	begin
		wait for 10ns;       -- To test fail conditions 
		for i in 0 to 3 loop -- Loop number controls how high the count is
			a <= std_logic_vector(to_unsigned(i, a'length));
			for i in 0 to 3 loop
			     b <= std_logic_vector(to_unsigned(i, b'length));
			    -- wait for 10ns;
			end loop;
			wait for 10ns; -- This statement is require to update signal 
		end loop;

	end process;    
    

end Behavioral;
