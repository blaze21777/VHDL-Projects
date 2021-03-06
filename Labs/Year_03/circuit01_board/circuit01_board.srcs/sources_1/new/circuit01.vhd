----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2020 12:49:22
-- Design Name: 
-- Module Name: circuit01 - Behavioral
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

entity circuit01 is
port (
        BTNC : in STD_LOGIC;
        SW0 : in STD_LOGIC;
        SW1 : in STD_LOGIC;
        SW2 : in STD_LOGIC;
        LD0 : out STD_LOGIC);
end circuit01;

architecture Behavioral of circuit01 is
    -- Signal declaration
    signal btn : std_logic;
    signal a : std_logic;
    signal b : std_logic;
    signal c : std_logic;
    signal d : std_logic;
    signal btn_flag : std_logic;
begin
 
-- process(clk) is 
-- begin 
-- case btn_flag is 
--    when =>
-- end case;
-- end process;
 -- Mapping signals to interface
 LD0 <= a;
 btn <= BTNC;
 b <= SW0;
 c <= SW1;
 d <= SW2;
 
 -- Circuit implementation 
a <= (b and c) or not(d);

end Behavioral;
