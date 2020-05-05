----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2020 14:22:36
-- Design Name: 
-- Module Name: pseudo_random_num_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pseudo_random_num_tb is
--  Port ( );
end pseudo_random_num_tb;

architecture Behavioral of pseudo_random_num_tb is
-- Clock signal 
    signal clk_period : time := 10ns;
    
    -- Tesst signals 
   signal clk :  std_logic;
   signal reset :  std_logic;
    -- Outputs
   signal number : std_logic_vector(31 downto 0);  

begin
  -- The unit under test
	random_num : entity work.pseudo_random_num(Behavioral)
	PORT MAP(
        -- Inputs 
    clk => clk,
    reset => reset,
    -- Outputs
    number => number);
    
    -- Setting clock and reset default values
    reset <= '1', '0' after 3 ns;  
   -- clk <= not clk after 5 ns; 
    
clk_proc : process is 
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;


  

end Behavioral;
