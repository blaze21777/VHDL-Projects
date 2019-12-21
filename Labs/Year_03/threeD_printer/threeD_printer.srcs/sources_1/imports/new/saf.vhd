----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2019 05:44:34
-- Design Name: 
-- Module Name: saf - Behavioral
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
use IEEE.std_logic_1164.all;
-- use IEEE.std_logic_arith.all; -- don't use this
use IEEE.numeric_std.all; -- use that, it's a better coding guideline

-- Also, never ever use IEEE.std_unsigned.all or IEEE.std_signed.all, these
-- are the worst libraries ever. They automatically cast all your vectors
-- to signed or unsigned. Talk about maintainability and strong typed language...

entity add_module is
  generic (num_bits : integer := 9);
  port(
    pr_in1   : in std_logic_vector(num_bits downto 0);
    pr_in2   : in std_logic_vector(num_bits downto 0);
    pr_out   : out std_logic_vector(num_bits downto 0)  
  );
end add_module;

architecture Behavior of add_module is

begin

  -- Here, you first need to cast your input vectors to signed or unsigned 
  -- (according to your needs). Then, you will be allowed to add them.
  -- The result will be a signed or unsigned vector, so you won't be able
  -- to assign it directly to your output vector. You first need to cast
  -- the result to std_logic_vector.

  -- This is the safest and best way to do a computation in VHDL.

  pr_out <= std_logic_vector(unsigned(pr_in1) + unsigned(pr_in2));

end architecture Behavior;
