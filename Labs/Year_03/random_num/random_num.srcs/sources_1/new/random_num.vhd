----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2020 20:45:39
-- Design Name: 
-- Module Name: random_num - Behavioral
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
use IEEE.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity random_num is
  Port (
   );
end random_num;

architecture Behavioral of random_num is



impure function rand_slv(len : integer) return std_logic_vector is
  variable r : real;
  variable slv : std_logic_vector(len - 1 downto 0);
begin
  for i in slv'range loop
    uniform(seed1, seed2, r);
    slv(i) := '1' when r > 0.5 else '0';
  end loop;
  return slv;
end function;

begin
  

end Behavioral;
