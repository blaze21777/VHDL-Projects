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
use IEEE.std_logic_arith.all;

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

ARCHITECTURE tb OF threeD_printer_tb IS
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
	SIGNAL change          : std_logic_vector(9 DOWNTO 0);
	
	-- Delay 
	signal valid_data : std_logic;-- := '0';
    signal data_in,data_out : std_logic;-- := '0';
	
	type data is record
    cancel   : std_logic;
    cash_en  : std_logic;
    cash     : std_logic_vector(9 downto 0);
    order_en : std_logic;
    order    : std_logic_vector(3 downto 0);
    end record;
    
     type input_data is array (natural range <>) of data;

  -- ----------------------------------------------
  --| cancel | cash_en |cash | order_en | order |--
  -------------------------------------------------
  constant order_1 : input_data := 
  ( ('0', '1', conv_std_logic_vector(1000, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector(1000, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector(1000, 10), '0', "0000"),
    ('0', '0', conv_std_logic_vector(   0, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector( 500, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector( 200, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector(  50, 10), '0', "0000"),
    ('0', '0', conv_std_logic_vector(   0, 10), '1', "0101"), --  balance = ï¿½37,50 => order: Yoda + lightsaber (ï¿½24,50)
    ('0', '0', conv_std_logic_vector(   0, 10), '0', "0000")  --  In this case, the machine must return XXX and deliver the item. 
  );
  
  constant order_2 : input_data := 
  ( ('0', '1', conv_std_logic_vector( 500, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector( 200, 10), '0', "0000"),
    ('0', '0', conv_std_logic_vector(   0, 10), '0', "0000"),
    ('0', '0', conv_std_logic_vector(   0, 10), '1', "1111"), -- balance = ï¿½7,00 => order: Darth Vader + lightsaber + cloak (ï¿½40,00)
    ('0', '0', conv_std_logic_vector(   0, 10), '0', "0000")  -- insufficient ï¿½, order canceled 
  );
  
  constant order_3 : input_data := 
  ( ('0', '1', conv_std_logic_vector(1000, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector(1000, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector(1000, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector( 500, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector( 100, 10), '0', "0000"),
    ('0', '0', conv_std_logic_vector(   0, 10), '1', "1011"), -- balance = £36,00 => order : Leia + cloak + lightsaber (£36,00)
    ('0', '0', conv_std_logic_vector(   0, 10), '0', "0000")
  ); 

  constant order_4 : input_data := 
  ( ('0', '1', conv_std_logic_vector(1000, 10), '0', "0000"),
    ('0', '1', conv_std_logic_vector(  50, 10), '0', "0000"),
    ('1', '0', conv_std_logic_vector(   0, 10), '0', "0000"), -- balance £10,50 order cancelled
    ('0', '0', conv_std_logic_vector(   0, 10), '0', "0000")
  ); 

BEGIN
    
    -- Setting clock and reset default values
    reset <= '1', '0' after 3 ns;  
   -- clk <= not clk after 5 ns; 
       -- The clock process 

    -- The unit under test
	UUT_printer : entity work.threeD_printer(Behavioral)
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
    
clk_proc : process is 
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

    process --- read the stimulus
  begin

    wait for 10 ns; 

    -- order #1
    -- 'high = the highest array index possible (9 for order_1)
    for i in 0 to order_1'high loop
      cancel   <= order_1(i).cancel;
      cash_en  <= order_1(i).cash_en;
      cash     <= order_1(i).cash;
      order_en <= order_1(i).order_en;
      order    <= order_1(i).order;
      wait for 10 ns;
    end loop;
    wait for 200 ns; -- wait to finalize the order 1
    
--     -- order #2
--    for i in 0 to order_2'high loop
--      cancel   <= order_2(i).cancel;
--      cash_en  <= order_2(i).cash_en;
--      cash     <= order_2(i).cash;
--      order_en <= order_2(i).order_en;
--      order    <= order_2(i).order;
--      wait for 10 ns;
--    end loop;
--    wait for 200 ns; -- wait to finalize the order 2

--    -- order #3
--    for i in 0 to order_3'high loop
--      cancel   <= order_3(i).cancel;
--      cash_en  <= order_3(i).cash_en;
--      cash     <= order_3(i).cash;
--      order_en <= order_3(i).order_en;
--      order    <= order_3(i).order;
--      wait for 10 ns;
--    end loop;
--    wait for 200 ns; -- wait to finalize the order 3

--    -- order #4
--    for i in 0 to order_4'high loop
--      cancel   <= order_4(i).cancel;
--      cash_en  <= order_4(i).cash_en;
--      cash     <= order_4(i).cash;
--      order_en <= order_4(i).order_en;
--      order    <= order_4(i).order;
--      wait for 10 ns;
--    end loop;
--    wait for 200 ns; -- wait to finalize the order 4

    assert false
      report "End of Simulation"
      severity failure;
  
   end process;

END tb;