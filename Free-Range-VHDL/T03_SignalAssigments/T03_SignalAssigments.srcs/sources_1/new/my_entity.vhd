----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.07.2019 13:21:18
-- Design Name: 
-- Module Name: my_entity - Behavioral
-- Project Name: Examples of signal assignment methods
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

entity my_entity is
	port (
		L, M, N : in std_logic;
		F3      : out std_logic
	);
end my_entity;

architecture Behavioral of my_entity is
	-- Signals for solution 2
	signal F3_02  : std_logic; -- Output signal 
	signal A1, A2 : std_logic; -- Intermediate signals

	-- Signals for solution 3
	signal F3_03  : std_logic; -- Output signal 

	-- Signals for solution 4
	signal F3_04  : std_logic;

	-- Signals for solution 5
	signal t_sig  : std_logic_vector(2 downto 0);

begin
	-- SOLUTION 1: combinational logic circuit one line implementation 
	F3 <= ((not L) and (not M) and N) or (L and M);

	-- SOLUTION 2: intermediate signals are declared
	A1    <= ((not L) and (not M) and N);
	A2    <= L and M;
	F3_02 <= A1 or A2;

	-- SOLUTION 3: conditional signal assignment
	F3_03 <= '1' when (L = '0' and M = '0' and N = '1') else
		     '1' when (L = '1' and M = '1') else
		     '0';

	-- SOLUTION 4: selected signal assignment
	-- Requires a boolean?? investigate further 
	with((L = '0' and M = '0'and N = '1') or (L = '1' and M = '1')) select
	F3_04 <= '1' when true,
		     '0' when false,
		     '0' when others;

	-- SOLUTION 5: selected signal assignment along with concatenation operation
	t_sig                  <= (L & M & N);                                     -- "&" = concatenation operator 
	with (t_sig) select F3 <= '1' when "001" | "110" | "111", '0' when others; -- "|" = seperator 

end Behavioral;