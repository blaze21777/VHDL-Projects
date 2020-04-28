----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2020 20:07:54
-- Design Name: 
-- Module Name: fibonacci_series_tb - Behavioral
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

entity fibonacci_series_tb is
--  Port ( );
end fibonacci_series_tb;

architecture Behavioral of fibonacci_series_tb is
    
    signal clk, reset    :  bit;
	signal fibo_series : integer;
	constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.fibonacci_series PORT MAP (
          clk => clk,
          reset => reset,
          fibo_series => fibo_series
        );
        
   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;
   
   -- Stimulus process
   stim_proc: process
   begin       
      wait for 10 ns;
      reset <= '1';
      wait for 10 ns;
      reset <= '0'; 
        
      wait;
   end process;

end Behavioral;
