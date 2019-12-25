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

--serial adder for N bits. Note that we dont have to mention N here.
-- https://vhdlguru.blogspot.com/2017/11/vhdl-code-for-n-bit-serial-adder-with.html 
entity serial_adder is
    generic (num_bits : integer := 9);
    port(Clk,reset : in std_logic; --clock and reset signal
          --  cin : in std_logic;  --note that cin is used for only first iteration.
            a,b : in std_logic_vector(num_bits downto 0);
            s : out std_logic_vector(num_bits downto 0)  --note that s comes out at every clock cycle and cout is valid only for last clock cycle.
            );
end serial_adder;

architecture behav of serial_adder is

--intermediate signals.
signal flag : std_logic := '0';
signal s_buf : std_logic_vector(num_bits downto 0);

begin

process(clk,reset)
--we use variable, so that we need the carry value to be updated immediately.
variable s_buf : std_logic_vector(num_bits downto 0) := (OTHERS => '0'); 
begin
if(reset = '1') then --active high reset
    s_buf := "0000000000";
    --cout <= c;
    flag <= '0';
elsif(rising_edge(clk)) then
    if(flag = '0') then
        s_buf := std_logic_vector(unsigned(a) + unsigned(b));  --on first iteration after reset, assign cin to c.
        flag <= '1';  --then make flag 1, so that this if statement isnt executed any more.
    else 
    -- cout <= '0'; 
    s_buf := std_logic_vector(unsigned(a) + unsigned(s_buf));  --SUM
    -- c := (a and b) or (c and b) or (a and c);  --CARRY
    end if; 
   
end if;
s <= s_buf;
end process;

end behav;
