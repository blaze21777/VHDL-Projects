----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2019 12:54:16
-- Design Name: 
-- Module Name: alu_simplified - Behavioral
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

entity alu_simplified is
  Port (
    alu_in1   : in std_logic_vector(1 downto 0);
    alu_in2   : in std_logic_vector(1 downto 0);
    alu_out   : out std_logic_vector(1 downto 0)
    );
end alu_simplified;

architecture Behavioral of alu_simplified is

begin
alu_out <= std_logic_vector(unsigned(alu_in1) + unsigned(alu_in2));

end Behavioral;
