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
    SW2 : in std_logic; -- Carry in
    LD0 : out std_logic; -- Sum
    LD1 : out std_logic -- Carry out
   );
end half_adder_board;

architecture Behavioral of half_adder_board is

    -- Signals for adder 
    -- Sy
    signal fa_i_bit1  :  std_logic := '0';
    signal fa_i_bit2  :  std_logic := '0';
    signal fa_i_carry :  std_logic;
    signal fa_o_sum   :  std_logic := '0';
    signal fa_o_carry :  std_logic := '0';
    
    begin
    
    -- Instantiate full adder 
	fa1 : entity work.full_adder
		port map(
            fa_i_bit1  => fa_i_bit1,
            fa_i_bit2  => fa_i_bit2,
            fa_i_carry  => fa_i_carry, 
            fa_o_sum   => fa_o_sum, 
            fa_o_carry => fa_o_carry
    );
    
        -- Map inputs and outputs 
    fa_i_bit1 <= SW0;
    fa_i_bit2 <= SW1;
    fa_i_carry <= SW2;
    LD0 <= fa_o_sum;
    LD1 <= fa_o_carry;
    
    end Behavioral;
