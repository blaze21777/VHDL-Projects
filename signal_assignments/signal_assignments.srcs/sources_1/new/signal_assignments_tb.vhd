----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.05.2020 18:44:40
-- Design Name: 
-- Module Name: signal_assignments_tb - Behavioral
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

entity signal_assignments_tb is
--  Port ( );
end signal_assignments_tb;

architecture Behavioral of signal_assignments_tb is
        signal L,M,N : std_logic;
        signal combinational : std_logic;
        signal intermediate : std_logic;
        signal conditional : std_logic;
        signal selected :  std_logic;
        signal concatenation : std_logic;

begin

    signal_assignments : entity work.signal_assignments(Behavioral)
                        port map(
                        L => L,
                        M => M,
                        N => N,
                        combinational => combinational,
                        intermediate => intermediate,
                        conditional => conditional,
                        selected => selected,
                        concatenation => concatenation
                        );
                        
     process is 
     begin
     wait for 10ns;
     L <= '1';
     M <= '0';
     N <= '1';
     
     end process;
     

end Behavioral;
