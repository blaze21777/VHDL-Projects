----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.07.2019 12:32:32
-- Design Name: 
-- Module Name: my_entity - Behavioral
-- Project Name: How to create an entity
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

-- An entity describes how the module will inteface with the outside
-- Usually derived from a black box diagram
entity my_entity is
  Port ( 
        -- Inputs
        port_name1 : in std_logic;    -- std_logic is the data type of the signal 
                                      -- Can take the values "0,1,U,X,Z,W,L,H,-"
        -- Outputs
        port_name2 : out std_logic;   -- Output signals cannot be read
        port_name3 : inout std_logic  -- Inout can be read and used as an output
                                      -- Last declaration does not have a semi-colon (because reasons)
       );  
end my_entity;

architecture Behavioral of my_entity is

begin


end Behavioral;
