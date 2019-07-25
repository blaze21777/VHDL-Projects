----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.07.2019 09:13:24
-- Design Name: 
-- Module Name: half_adder - Behavioral
-- Project Name: Half adder
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

entity half_adder is
  Port ( 
  -- Inputs
  A,B : in std_logic;
  -- Outputs
  S,C : out std_logic;
  overflow : out std_logic
  );
end half_adder;

architecture Behavioral of half_adder is
signal S_temp : std_logic;
begin
S_temp <= A xor B;
-- Overflow and carry are the same since we are adding only 1 bit numbers 
C <= A and B;
overflow <= '1' when A = B and S_temp /= A
                else '0';
S <= S_temp;

end Behavioral;
