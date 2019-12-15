----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2019 05:18:56
-- Design Name: 
-- Module Name: threeD_printer_tb - Behavioral
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY threeD_printer_tb IS
	--  Port ( );
END threeD_printer_tb;

ARCHITECTURE Behavioral OF threeD_printer_tb IS
    -- Clock signal 
    signal clk_period : time := 10ns;
	-- Component signal declaration
	SIGNAL cash_en         : std_logic;
	SIGNAL cash            : std_logic_vector(9 DOWNTO 0);
	SIGNAL cancel          : std_logic;
	SIGNAL order_en        : std_logic;
	SIGNAL order           : std_logic_vector(3 DOWNTO 0);
	SIGNAL reset           : std_logic;
	SIGNAL clk             : std_logic;
	-- Outputs
	SIGNAL check_balance   : std_logic;
	SIGNAL printing        : std_logic;
	SIGNAL ready           : std_logic;
	SIGNAL order_cancelled : std_logic;
	SIGNAL change_en       : std_logic;
	SIGNAL change          : std_logic;

BEGIN

    -- The unit under test
	printer : entity work.threeD_printer(Behavioral)
	PORT MAP(
        -- Inputs 
		cash_en         => cash_en,
		cash            => cash,
		cancel          => cancel,
		order_en        => order_en,
		order           => order,
		reset           => reset,
		clk             => clk,
		-- Outputs
		check_balance   => check_balance,
		printing        => printing,
		ready           => ready,
		order_cancelled => order_cancelled,
		change_en       => change_en,
		change          => change
    );
    
    -- The clock process 
clk_proc : process is 
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

END Behavioral;