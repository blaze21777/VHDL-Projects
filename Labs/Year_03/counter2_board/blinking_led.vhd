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
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinking_led is
        Port ( GCLK : in STD_LOGIC;
               BTNC : in STD_LOGIC;
               SW0  : in STD_LOGIC;
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

        signal clk_board : STD_LOGIC;
        signal clk_div   : STD_LOGIC_VECTOR (12 downto 0);
        signal clk_usr   : STD_LOGIC;
        signal counter   : STD_LOGIC_VECTOR (7 downto 0);
        signal rst_btn   : STD_LOGIC;
        signal sw        : STD_LOGIC_VECTOR (7 downto 0);

begin

        clk_board <= GCLK;
        clk_usr <= clk_div(12);
        rst_btn <= BTNC;
        sw <= (SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7);
        ( LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7 ) <= counter;

        -- clock divisor logic
        process (clk_board, rst_btn)
        begin
                if rst_btn = '1' then
                        clk_div <= (others=>'0');
                else
                        if clk_board' event and clk_board = '1' then
                                -- synchronous reset
                                -- increment clk_div with first 4 switches
                                clk_div <= clk_div + 1;
                        end if;
                end if;
        end process;

        -- counter logic
        process (clk_usr, rst_btn)
        begin
                -- synchronous reset
                if rst_btn = '1' then
                        counter <= (others=>'0');
                else
                        if clk_usr' event and clk_usr = '1' then
                                -- increment clk_div with last 4 switches
                                counter <= counter + 1;
                        end if;
                end if;
        end process;

end Behavioral;
