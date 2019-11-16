----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2019 01:07:33
-- Design Name: 
-- Module Name: parity_checker_moore_tb - Behavioral
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

entity parity_checker_moore_tb is
--  Port ( );
end parity_checker_moore_tb;

architecture Behavioral of parity_checker_moore_tb is

-- Signal declaration 
    signal clk : std_logic;
	signal 	rst    : std_logic;
	signal	x      : std_logic_vector(1 downto 0);
	signal	parity : std_Logic;
	signal clk_period : time := 10ns;

begin

    -- Instatiation of the parity checker 
parity_checker : entity work.parity_checker_moore(Behavioral)
port map(
    clk => clk,
    rst => rst,
    x => x,
    parity => parity
);

-- The clock process 
clk_proc : process is 
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

-- The testing process
test_proc : 
    process is
	begin
		wait for 10ns;        
		for i in 0 to 3 loop -- Loop number controls how high the count is
			x <= std_logic_vector(to_unsigned(i, x'length));
			wait for 10ns; -- Update signal 
		end loop;
	end process;

end Behavioral;
