----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2020 09:34:52
-- Design Name: 
-- Module Name: chess_clock_board - Behavioral
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

entity chess_clock_board is
  Port (
    SW0 : in STD_LOGIC;
    SW1 : in STD_LOGIC;
    SW2 : in STD_LOGIC;
    SW3 : in STD_LOGIC;
    SW4 : in STD_LOGIC;
    SW5 : in STD_LOGIC;
    SW6 : in STD_LOGIC;
    SW7 : in STD_LOGIC;
    BTNC : in STD_LOGIC; -- Allow input greater than 8 switches
    BTNL : in STD_LOGIC; -- Reset button?
    BTNR : in STD_LOGIC; -- Button for wrong mate 
    LD0 : out STD_LOGIC; -- Can use LEDs to represent which part of the value is being taken
    LD1 : out STD_LOGIC;
    LD2 : out STD_LOGIC;
    LD3 : out STD_LOGIC;
    LD4 : out STD_LOGIC;
    LD5 : out STD_LOGIC;
    LD6 : out STD_LOGIC;
    LD7 : out STD_LOGIC
   
   );
end chess_clock_board;

architecture Behavioral of chess_clock_board is

begin

-- Instantiate chess clock 
    -- chess clock will use 4 digit decimal counter 
    -- decimal counters will be created with generate 


end Behavioral;
