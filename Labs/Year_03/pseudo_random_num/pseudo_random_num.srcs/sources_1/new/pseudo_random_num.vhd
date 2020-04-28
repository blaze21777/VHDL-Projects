----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2020 13:05:49
-- Design Name: 
-- Module Name: pseudo_random_num - Behavioral
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

entity pseudo_random_num is
  Port (
    -- Inputs
    clk : in std_logic;
    reset : in std_logic;
    -- Outputs
    number : out std_logic_vector(31 downto 0)  -- Has to be 32-bit output
   );
end pseudo_random_num;

architecture Behavioral of pseudo_random_num is

begin

    -- Fibonacci sequence1 instatiation
--	 : entity work.serial_adder(behav)
--		port map(
--			clk     => clk,
--			reset   => reset_adder,

    -- Fibonacci sequence2
    
    -- PRNG algorithm A instatiation
    
    -- PRNG algorithm B instatiation
    
    
end Behavioral;
