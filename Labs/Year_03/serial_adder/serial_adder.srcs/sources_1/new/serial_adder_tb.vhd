----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.12.2019 10:17:44
-- Design Name: 
-- Module Name: serial_adder_tb - Behavioral
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

    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT serial_adder
        generic (num_bits : integer := 9);
        port(Clk,reset : in std_logic; --clock and reset signal
          --  cin : in std_logic;  --note that cin is used for only first iteration.
            a,b : in std_logic_vector(num_bits downto 0);
            s : out std_logic_vector(num_bits downto 0)  --note that s comes out at every clock cycle and cout is valid only for last clock cycle.
            );
    END COMPONENT;   

   --Inputs
   signal Clk,reset : std_logic := '0';
   signal a,b : std_logic_vector(9 downto 0) := (OTHERS => '0');
    --Outputs
   signal s : std_logic_vector(9 downto 0) := (OTHERS => '0');

   -- Clock period definitions
   constant Clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
   uut: serial_adder PORT MAP (Clk,reset,a,b,s);

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
        wait until rising_edge(clk);
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        -- Add 10 bit numbers 
        a <= "0000000011";
        b <= "0000000111";
        wait for clk_period;
        a <= "0000000011";
        wait for clk_period;
        a <= "0000000011";
        
--        --add two 4 bit numbers, 1111 + 1101 = 11101
--        a <= '1'; b <= '1'; cin <= '1';   wait for 10 ns;
--        a <= '1'; b <= '0'; cin <= '0'; wait for 10 ns;
--        a <= '1'; b <= '1'; cin <= '0'; wait for 10 ns;
--        a <= '1'; b <= '1'; cin <= '0'; wait for 10 ns;
--        reset <= '1';
--        wait for 10 ns;
--        reset <= '0';
--        --add two 5 bit numbers, 11011 + 10001 = 101101
--        a <= '1'; b <= '1'; cin <= '1';   wait for 10 ns;
--        a <= '1'; b <= '0'; cin <= '0'; wait for 10 ns;
--        a <= '0'; b <= '0'; cin <= '0'; wait for 10 ns;
--        a <= '1'; b <= '0'; cin <= '0'; wait for 10 ns;
--        a <= '1'; b <= '1'; cin <= '0'; wait for 10 ns;
--        reset <= '1';
--        wait for 10 ns;
      wait;
   end process;

END;
