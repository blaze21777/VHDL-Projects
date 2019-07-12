----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2019 20:03:12
-- Design Name: 
-- Module Name: my_ckt - Behavioral
-- Project Name: Using case and if to design a circuit
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

-- circuit from http://freerangefactory.org/pdf/df344hdh4h8kjfh3500ft2/free_range_vhdl.pdf
-- Page 68 question 2
entity my_ckt is
  Port (
    -- Inputs
    A_1, A_2 : in std_logic;
    B_1, B_2 : in std_logic;
    D_1      : in std_logic;
    -- Outputs
    E_out    : out std_logic
    );
end my_ckt;

architecture Behavioral of my_ckt is

-- REQUIRES TRUTH TABLE... MAYBE LATER

begin


end Behavioral;
