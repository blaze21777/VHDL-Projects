----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2020 13:10:07
-- Design Name: 
-- Module Name: circuit02 - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circuit02 is
	port (
		BTNC : in STD_LOGIC;
		SW0  : in STD_LOGIC;
		SW1  : in STD_LOGIC;
		SW2  : in STD_LOGIC;
		LD0  : out STD_LOGIC);
end circuit02;

architecture Behavioral of circuit02 is
	-- Signal declaration
	--signal clk      : std_logic;
	signal btn      : std_logic;
	signal a        : std_logic;
	signal b        : std_logic;
	signal c        : std_logic;
	signal d        : std_logic;
	signal btn_flag : std_logic;
begin
	btn <= BTNC;

	process (btn, sw0, sw1, sw2, a, d, b, btn_flag, c) is
	begin
		btn_flag <= btn;
		case btn_flag is
			when '0' =>
				-- Mapping signals to interface
				LD0 <= a;
				b   <= SW0;
				c   <= SW1;
				d   <= SW2;
				-- Circuit implementation 
				a   <= (b and c) or not(d);
			when '1' =>
				-- Mapping signals to interface
				LD0 <= a;
				b   <= SW0;
				c   <= SW1;
				a   <= b and c;
            when others =>
		end case;
	end process;

end Behavioral;