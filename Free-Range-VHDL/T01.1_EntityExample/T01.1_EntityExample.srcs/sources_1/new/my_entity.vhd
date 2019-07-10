----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.07.2019 13:08:09
-- Design Name: 
-- Module Name: my_entity - Behavioral
-- Project Name: Example entity from a black box diagram 
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

-- Using std_logic vectors 
entity my_entity is
  Port (
    -- Inputs
    clk     : in std_logic;
    input_w : in std_logic;
    a_data  : in std_logic_vector(7 downto 0);
    b_data  : in std_logic_vector(7 downto 0);
    -- Outputs
    dat_4   : out std_logic_vector(7 downto 0);
    dat_5   : out std_logic_vector(2 downto 0)
   );
end my_entity;

architecture Behavioral of my_entity is

begin


end Behavioral;
