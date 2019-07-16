----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2019 08:02:56
-- Design Name: 
-- Module Name: mealy_hybrid - Behavioral
-- Project Name: Creating a mealy hybrid finite state machine
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

-- Exercise  14 page 117 http://freerangefactory.org/pdf/df344hdh4h8kjfh3500ft2/free_range_vhdl.pdf

entity mealy_hybrid is
	port (
		-- Inputs 
		clk        : in std_logic;
		x1, x2     : in std_logic;
		-- Outputs
		y3, y2, y1 : out std_logic;  -- State encoding outputs
		z1, z2     : out std_logic
	);
end mealy_hybrid;

architecture Behavioral of mealy_hybrid is

	type state_type is (A, B, C);
	attribute enum_encoding               : string;
	attribute enum_encoding of state_type : type is "100 010 001";
	signal ps, ns                         : state_type;
	
	-- Testing if concatenation will work 
    signal y : std_logic_vector(2 downto 0) := (others => '0');
begin
    
	sync_proc : process (clk, ns) is
	begin
		-- No reset 
		if rising_edge(clk) then
			ps <= ns;
		end if;
	end process;

	state_decode : process (ps) is
	begin
		case ps is
			when A =>
				if (x1 = '1') then
					z2 <= '1'; -- Mealy output
					ns <= B;
				else
					z2 <= '1'; -- Mealy output
					ns <= C;
				end if;
			when B =>
				if (x2 = '1') then
					z2 <= '0'; -- Mealy output
					ns <= A;
				else
					z2 <= '1'; -- Mealy output
					ns <= C;
				end if;
			when C =>
				if (x1 = '1') then
					z2 <= '1'; -- Mealy output
					ns <= B;
				else
					z2 <= '1'; -- Mealy output
					ns <= A;
				end if;
		end case;

	end process;

	output_decode : process (ps) is
	begin
		z1 <= '0'; -- Inital moore output 
		z2 <= '0'; -- Inital mealy output 
		case ps is
			when A =>
				z1 <= '0'; -- Moore output
			when B =>
				z1 <= '1'; -- Moore output
			when C =>
				z1 <= '1'; -- Moore output
		end case;

	end process;

-- one-hot encoded approach
  (y3, y2, y1) <= y;	
	with PS select
		Y <= "100" when A,
		     "010" when B,
             "001" when C,
		     "100" when others;
		     
end Behavioral;
