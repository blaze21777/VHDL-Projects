----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2020 13:05:49
-- Design Name: 
-- Module Name: pseudo_random_num - Behavioral
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

entity pseudo_random_num is
  Port (
    -- Inputs
    clk : in std_logic;
    reset : in std_logic;
    -- inputs for fib module
    fib_in1 : in integer;
    fib_in2 : in integer;
    fib_in3 : in integer;
    fib_in4 : in integer;
    fib_end1 : in integer;
    fib_end2 : in integer;
    -- Outputs
    number : out std_logic_vector(31 downto 0)  -- Has to be 32-bit output
   );
end pseudo_random_num;

architecture Behavioral of pseudo_random_num is

-- Decalare states that can be taken
	type state_type is (
		reset_s,
		add_s);
	signal state, next_state : state_type;

        -- Fibonacci sequence1 signals
    constant N : integer := 8;
    --signal clk_fib1, reset_fib1 :  bit;
	signal fibo_series1 : integer range 0 to 2 ** N - 1;
	signal start_a1, start_b1 : integer range 0 to 2 ** N - 1; -- allow change in sequence start points
	signal end_point1 : integer range 0 to 2 ** N - 1; -- Max number to not exceed
	signal output1 :  std_logic_vector(N-1 downto 0); -- Output will go to memory 
	
	 -- Fibonacci sequence2 signals
	--signal clk_fib2, reset_fib2 :  bit;
	signal fibo_series2 : integer range 0 to 2 ** N - 1;
	signal start_a2, start_b2 : integer range 0 to 2 ** N - 1; -- allow change in sequence start points
	signal end_point2 : integer range 0 to 2 ** N - 1; -- Max number to not exceed
	signal output2 :  std_logic_vector(N-1 downto 0); -- Output will go to memory 
	
	
	signal padding : std_logic_vector(15 downto 0) := (others => '0'); -- Place holder for algorithm

begin

    -- Fibonacci sequence1 instatiation
fib1	 : entity work.fibonacci_series(Behavioral)
        generic map(N => N)
		port map(
			clk => clk, 
			reset => reset,
			start_a => fib_in1,
		    start_b => fib_in2,
		    end_point => fib_end1,
		    --fibo_series => fibo_series1,
            output => output1);
        
    -- Fibonacci sequence2
    fib2	 : entity work.fibonacci_series(Behavioral)
        generic map(N => N)
		port map(
			clk => clk, 
			reset => reset,
			start_a => fib_in3,
		    start_b => fib_in4,
		    end_point => fib_end1,
		    --fibo_series => fibo_series2,
            output => output2);
    
    -- PRNG algorithm A instatiation
    
    -- PRNG algorithm B instatiation
    
--    -- The clock process
--	sync_proc : process (clk)
--	begin
--		if rising_edge(clk) then
--			if (reset = '1') then
--				state <= reset_s;
--			else
--				state <= next_state;
--			end if;
--		end if;
--	end process;
	
	number <= padding & output1 & output2;
    
end Behavioral;
