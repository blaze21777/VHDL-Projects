----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2019 03:14:49
-- Design Name: 
-- Module Name: delay_tb - Behavioral
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

ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS

   signal Clk : std_logic := '0';
   signal valid_data : std_logic := '0';
   signal data_in,data_out : std_logic := '0';
   constant Clk_period : time := 5 ns;
   signal d : integer := 0; --number of clock cycles by which input should be delayed.

BEGIN

    -- Instantiate the Unit Under Test (UUT)
   uut: entity work.delay PORT MAP (
          Clk => Clk,
          valid_data => valid_data,
          data_in => data_in,
          data_out => data_out,
          d => d
        );

   -- Clock process definitions
   Clk_process :process
   begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin       
      wait for 100 ns; 
        valid_data <= '1';
        data_in <= '1';
        d <= 1;
      wait;
   end process;

END;
