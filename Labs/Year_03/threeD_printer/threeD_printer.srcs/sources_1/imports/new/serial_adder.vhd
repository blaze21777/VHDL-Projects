----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.12.2019 10:14:21
-- Design Name: 
-- Module Name: serial_adder - Behavioral
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

-- Serial adder adapted from
-- https://vhdlguru.blogspot.com/2017/11/vhdl-code-for-n-bit-serial-adder-with.html 
entity serial_adder is
    generic (num_bits : integer := 11);
    port(Clk,reset : in std_logic; --clock and reset signal
            add_in1, add_in2 : in std_logic_vector(num_bits downto 0);
            -- note that add_out comes out at every clock cycle
            add_out : out std_logic_vector(num_bits downto 0)  
            );
end serial_adder;

architecture behav of serial_adder is

-- Intermediate signals.
signal flag : std_logic := '0';
signal s_buf : std_logic_vector(num_bits downto 0);

begin

process(clk,reset)
-- We use a variable so that the buffer value is updated immediately.
variable s_buf : std_logic_vector(num_bits downto 0) := (OTHERS => '0'); 
begin
if(reset = '1') then -- Active high reset
    s_buf := "000000000000";
    flag <= '0';
elsif(rising_edge(clk)) then
    if(flag = '0') then
        s_buf := std_logic_vector(unsigned(add_in1) + unsigned(add_in2));  
        flag <= '1';  -- Make flag 1 so that this if statement isnt executed any more.
    else 
    s_buf := std_logic_vector(unsigned(add_in1) + unsigned(s_buf));  --SUM
    end if; 
   
end if;
add_out <= s_buf;
end process;

end behav;
