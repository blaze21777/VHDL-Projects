----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2020 13:42:16
-- Design Name: 
-- Module Name: circuit02_tb - Behavioral
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

entity circuit02_tb is
--  Port ( );
end circuit02_tb;

architecture Behavioral of circuit02_tb is
    -- Declare signals 
    signal BTNC :  STD_LOGIC;
	signal	SW0  : STD_LOGIC;
	signal 	SW1  : STD_LOGIC;
	signal 	SW2  : STD_LOGIC;
	signal	LD0  : STD_LOGIC;
begin

uut: entity work.circuit02 port map (
        BTNC => BTNC,
		SW0  => SW0,
		SW1  => SW1,
		SW2  => SW2
        );
        
stim_proc : process is
    begin
        BTNC <= '1';
        wait for 10ns;
        SW0 <= '0';
        SW1 <= '0';
        SW2 <= '1';
        wait for 10ns;
        --BTNC <= '1';
    end process; 

end Behavioral;
