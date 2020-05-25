----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.05.2020 17:44:46
-- Design Name: 
-- Module Name: signal_assignments - Behavioral
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

entity signal_assignments is
  Port (L,M,N : in std_logic;
        combinational : out std_logic;
        intermediate : out std_logic;
        conditional : out std_logic;
        selected : out std_logic;
        concatenation : out std_logic);
end signal_assignments;

architecture Behavioral of signal_assignments is
   
   -- Solution 2: intermediate signals are declared
   signal A, B : std_logic;
   
   -- Solution 5: selected signal assignment along with concatenation operation
   signal t_sig : std_logic_vector(2 downto 0);
   
begin
   --Solution 1: combinational logic circuit
   combinational <=((NOT L) AND (NOT M) AND N) OR (L AND M);
   
   -- Solution 2: intermediate signals are declared
   A <= (NOT L) AND (NOT M) AND N;
   B <= (L AND M);
   intermediate <= A or B;
  
   -- Solution 3: conditional signal assignment
   conditional <= '1' when (L= '0' AND M = '0' AND N = '1') else
                  '1' when (L= '1' AND M = '1') else '0';
                  
   -- Solution 4: selected signal assignment
   with ((L and M and N) or (L and M)) select
   selected <= '1' when '1',
   '0' when '0',
   '0' when others;

   -- Solution 5: selected signal assignment along with concatenation operation
   t_sig <= (L & M & N); -- concatenation operator
   with (t_sig) select concatenation <= '1' when "001" | "110" | "111",
   '0' when others;
   
end Behavioral;
