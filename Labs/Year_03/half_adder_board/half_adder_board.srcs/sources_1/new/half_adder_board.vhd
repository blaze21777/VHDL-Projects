----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2020 08:46:11
-- Design Name: 
-- Module Name: half_adder_board - Behavioral
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

entity half_adder_board is
  Port (
    SW0 : in std_logic; -- Bit 1
    SW1 : in std_logic; -- Bit 2
    LD0 : out std_logic; -- Sum
    LD1 : out std_logic -- Carry 
   );
end half_adder_board;

architecture Behavioral of half_adder_board is

    -- Signals for adder 
    signal i_bit1       : std_logic;
	signal i_bit2       : std_logic;
	signal o_sum        : std_logic;
	signal o_carry      : std_logic;

begin
    
    -- Map inputs and outputs 
    i_bit1 <= SW0;
    i_bit2 <= SW1;
    LD0 <= o_sum;
    LD1 <= o_carry;
    
    -- Instantiate half adder 
	ha1 : entity work.half_adder
		port map(
			i_bit1  => i_bit1,
			i_bit2  => i_bit2,
			o_sum   => o_sum,
			o_carry => o_carry
		);
		
end Behavioral;
