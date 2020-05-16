----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2020 15:12:06
-- Design Name: 
-- Module Name: using_functions - Behavioral
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

entity using_functions is
--  Port ( );
end using_functions;

architecture Behavioral of using_functions is
--The syntax for declaring a function in VHDL is:
--[pure|impure] function <function_name> (<parameter1_name> : <parameter1_type> := <default_value>;
--                                        <parameter2_name> : <parameter2_type> := <default_value>;
--                                        ... ) return <return_type> is
--    <constant_or_variable_declaration>
--begin
--    <code_performed_by_the_function>
--    return <value>
--end function;

signal a : integer;
--signal b : integer;
impure function test(input : integer) return integer is
begin
    return input + 1;
end function;

begin
a <= test(input => 5);

end Behavioral;
