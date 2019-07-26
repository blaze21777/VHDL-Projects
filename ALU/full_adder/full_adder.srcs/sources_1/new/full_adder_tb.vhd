----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2019 10:41:16
-- Design Name: 
-- Module Name: full_adder_tb - Behavioral
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

entity full_adder_tb is
--  Port ( );
end full_adder_tb;

architecture Behavioral of full_adder_tb is
signal fa_i_bit1  : std_logic;
		signal fa_i_bit2  : std_logic;
		signal fa_i_carry : std_logic;
		signal fa_o_sum   : std_logic;
		signal fa_o_carry : std_logic;
		signal input_concat : std_logic_vector(2 downto 0);
		signal output_concat : std_logic_vector(1 downto 0);
begin 

(fa_i_bit1, fa_i_bit2, fa_i_carry) <= input_concat;
output_concat <= (fa_o_carry & fa_o_sum);

fa : entity work.full_adder
port map( 
   fa_i_bit1 => fa_i_bit1 ,
		fa_i_bit2 => fa_i_bit2,
		fa_i_carry => fa_i_carry,
		fa_o_sum  => fa_o_sum,
		fa_o_carry=> fa_o_carry
);

 -- Test process 
 process is 
 begin
 wait for 10ns;
    for i in 0 to 7 loop
        input_concat <= std_logic_vector(to_unsigned(i,input_concat'length));
    wait for 10ns;
    end loop;
 end process;
end Behavioral;
