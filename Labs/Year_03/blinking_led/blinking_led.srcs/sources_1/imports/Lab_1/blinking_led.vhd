----------------------------------------------------------------------------------
-- Developer: Vitor Bandeira (bandeira@ieee.org)
--
-- Create Date: 09/27/2018 06:08:04 PM
-- Design Name:
-- Module Name: blinking_led - Behavioral
-- Project Name: Loughborough University - 18WSB020 Introduction to FPGA Design
-- Target Devices: ZedBoard - Zynq 7000 (xc7z020clg484pkg)
-- Tool Versions: Vivado 2016.4
-- Description: Simple blinking led RTL description. Inputs are board clock,
-- button that acts as reset, and switches to modify clock divisor and counter
-- step.
--
-- Dependencies: None
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity blinking_led is
        Port ( SW0  : in STD_LOGIC;
               SW1  : in STD_LOGIC;
               SW2  : in STD_LOGIC;
               SW3  : in STD_LOGIC;
               SW4  : in STD_LOGIC;
               SW5  : in STD_LOGIC;
               SW6  : in STD_LOGIC;
               SW7  : in STD_LOGIC;
               LD0 : out STD_LOGIC;
               LD1 : out STD_LOGIC;
               LD2 : out STD_LOGIC;
               LD3 : out STD_LOGIC;
               LD4 : out STD_LOGIC;
               LD5 : out STD_LOGIC;
               LD6 : out STD_LOGIC;
               LD7 : out STD_LOGIC
       );
end blinking_led;

architecture Behavioral of blinking_led is

begin

        LD7 <= not(SW0);
        LD6 <= not(SW1);
        LD5 <= not(SW2);
        LD4 <= SW3;
        LD3 <= SW4;
        LD2 <= SW5;
        LD1 <= SW6;
        LD0 <= SW7;

end Behavioral;
