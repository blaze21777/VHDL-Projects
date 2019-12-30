----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2019 08:37:48
-- Design Name: 
-- Module Name: threeD_printer - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY threeD_printer IS
	GENERIC (num_bits : INTEGER := 9);
	PORT (
		-- Inputs
		cash_en         : IN std_logic;
		cash            : IN std_logic_vector(num_bits DOWNTO 0);
		cancel          : IN std_logic;
		order_en        : IN std_logic;                           
		order           : IN std_logic_vector(3 DOWNTO 0);
		reset           : IN std_logic;
		clk             : IN std_logic;
		-- Outputs
		check_balance   : OUT std_logic;
		printing        : OUT std_logic;
		ready           : OUT std_logic; 
		order_cancelled : OUT std_logic;
		change_en       : OUT std_logic;
		change          : OUT std_logic_vector(num_bits DOWNTO 0));
END threeD_printer;

ARCHITECTURE Behavioral OF threeD_printer IS

	-- Decalare states that can be taken
	TYPE state_type IS (
		reset_s,
		pre_order_s,
		order_s,
		cancel_s,
		subtract_s,
		change_s,
		printing_s,
		ready_s,
		check_balance_s);
	SIGNAL state, next_state   : state_type;
    
    -- Order signals
	SIGNAL order_price         : std_logic_vector(num_bits + 2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL order_save          : std_logic_vector(3 DOWNTO 0)            := (OTHERS => '0');

	-- Serial adder signals 
	SIGNAL a, b                : std_logic_vector(11 DOWNTO 0)            := (OTHERS => '0');
	SIGNAL s                   : std_logic_vector(11 DOWNTO 0)            := (OTHERS => '0'); 
	SIGNAL reset_adder         : std_logic := '0';
	SIGNAL total_cash          : std_logic_vector(num_bits +2 DOWNTO 0)     := (OTHERS => '0'); -- Sum of coins inserted ALU
  
    -- Subtraction
    -- NEED TO FIX 12 BIT SUBTRACTION
    SIGNAL sub_in1              : std_logic_vector(11 DOWNTO 0)            := (OTHERS => '0');
	SIGNAL sub_in2              : std_logic_vector(11 DOWNTO 0)            := (OTHERS => '0');
	SIGNAL sub_out              : std_logic_vector(11 DOWNTO 0)            := (OTHERS => '0');

	-- Delay signals 
	SIGNAL valid_data          : std_logic                               := '0';
	SIGNAL data_in, data_out   : std_logic                               := '0';
	SIGNAL d                   : INTEGER                                 := 0; --number of clock cycles by which input should be delayed.

BEGIN

	-- Serial adder instatiation
	-- NEED TO CREATE EXPLICIT PORT MAPPING!
	-- https://stackoverflow.com/questions/21163915/how-does-vhdl-deal-with-overflow
	serial_adder : ENTITY work.serial_adder(behav)
		PORT MAP(
		clk => clk, 
		reset => reset_adder, 
		a => a,
		b => b,
		s => s);

	-- dealay instatiation
	delay : ENTITY work.delay PORT MAP (
		Clk        => Clk,
		valid_data => valid_data,
		data_in    => data_in,
		data_out   => data_out,
		d          => d
		);
	-- The clock process
	sync_proc : PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF (reset = '1') THEN
				state <= reset_s;
			ELSE
				state <= next_state;
			END IF;
		END IF;
	END PROCESS;

	-- Next state decode 
	next_state_decode : PROCESS (state, order_en, cash_en, d, data_out, total_cash) IS

	BEGIN

		CASE state IS
			-- Reset state --
			WHEN reset_s =>
				IF (order_en = '1') THEN
					next_state <= pre_order_s;
				END IF;
				
            -- Pre order state --
			WHEN pre_order_s =>
				IF (cancel = '1') THEN --- MIGHT BE POINTLESS 
					next_state <= cancel_s;
				ELSE
					next_state <= order_s;
				END IF;

			-- Order state --
			WHEN order_s =>
				-- NEED TO GET ADDER WORKING FIRST!!
				-- If balance => order price, then execute the order and give the change back
				-- If balance =< order price, then cancel the order and give the current balance back

				IF (total_cash < order_price) THEN
					next_state <= cancel_s;
				ELSE
					next_state <= subtract_s;
				END IF;
				
			-- Subtract state --
			WHEN subtract_s => 
			next_state <= change_s;
			
			-- Change state --
			WHEN change_s =>
			next_state <= printing_s;
			
		    -- Cancel state --
			WHEN cancel_s =>

				next_state <= reset_s;
				
            -- Printing state --
			WHEN printing_s =>
				-- Printing test
				IF (data_out = '1') THEN
					next_state <= ready_s;
				END IF;

	        WHEN check_balance_s =>
	        
			WHEN OTHERS =>
				next_state <= reset_s;
		END CASE;
	END PROCESS;

	-- Output decode
	output_decode : PROCESS (order_en, state, d, order_save, data_out, total_cash, cash, cash_en, order_price) IS

	BEGIN
		CASE state IS
		
		    -- Reset state --
			WHEN reset_s =>
				-- Set all FSM outputs to 0
				check_balance   <= '0';
				printing        <= '0';
				ready           <= '0';
				order_cancelled <= '0';
				change_en       <= '0';
				change          <= "0000000000";
				
		        -- Delay signals
		       -- data_out <= '0';      
				-- Adder signals 
				 reset_adder <= '0'; -- Reset in ready state
				-- NEED TO ADD OVERFLOW COMPENSAION 
				IF (cash_en = '1') THEN
					a          <= "00" & cash; -- 12-bit assignment 
					b          <= "000000000000";
					total_cash <= s;
				ELSE
					a <= "000000000000";
		
				END IF;

				-- Mealy output    
				IF (order_en = '1') THEN
					order_save <= order;
					printing   <= '0';
				END IF;

				-- Pre order state -- 
				-- printing time should be assigned here
			WHEN pre_order_s =>
				CASE order_save IS
					WHEN "0000" => -- No order
						order_price <= x"000";

					WHEN "0001" => -- Gun
						order_price <= x"0C8";

					WHEN "0010" => -- Capes or cloaks
						order_price <= x"258";

					WHEN "0011" => -- Gun + cape or cloak
						order_price <= x"258";

					WHEN "0100" => -- Yoda
						order_price <= x"8CA";

					WHEN "0101" => -- Yoda + lightsaber
						order_price <= x"992";

					WHEN "0110" => -- Yoda + cloak
						order_price <= x"B22";

					WHEN "0111" => -- Yoda + cloak + lightsaber
						order_price <= x"BEA";

					WHEN "1000" => -- Leia
						order_price <= x"AF0";

					WHEN "1001" => -- Leia + rifle
						order_price <= x"BB8";

					WHEN "1010" => -- Leia + cape
						order_price <= x"D48";

					WHEN "1011" => -- Leia + cloak + lightsaber
						order_price <= x"E10";

					WHEN "1100" => -- Darth Vader
						order_price <= x"C80";

					WHEN "1101" => -- Darth Vader + lightsaber
						order_price <= x"D48";

					WHEN "1110" => -- Darth Vader + cloak
						order_price <= x"ED8";

					WHEN "1111" => -- Darth Vader + lightsaber + cloak
						order_price <= x"FA0";

					WHEN OTHERS =>
						order_price <= x"000";
				END CASE;
				
            -- Order state --
			WHEN order_s    =>
				-- set output to some value 
              sub_in1 <= s; -- SHOULD BE TOTAL COIN BUT THATS BROKEN NOW.
              sub_in2 <= order_price; -- ORDER PRICE HAS 12 ELEMENTS NEED TO FIX!
              
            -- Subtract state --
            when subtract_s =>
            sub_out <= std_logic_vector(unsigned(sub_in1) - unsigned(sub_in2));
            
            -- Change state --     
            -- CHANGE TAKES MULTIPLE CLOCK CYCLES, SPLIT TOTAL CASH TO 10-BIT PARTS
            -- MULTIPLE IF STATEMETNS TO CHECK IF HIGHEST DENOMINATION CAN BE TAKEN OUT                                                                                                  
            WHEN change_s => 
            change_en <= '1';
            change <= sub_out(num_bits downto 0); -- QUICK CHANGE FIX (DOESN'T GIVE ACTUAL CHANGE)
            
            -- Cancel state --
			WHEN cancel_s   =>
			-- NEEDS TO USE SAME IF STATEMENTS AS CHANGE_S
           -- change <= total_cash; THIS IS DUMB, TOTAL CASH CAN BE HIGHER THAN 10 BITS!! 
            
            -- Printing state --
			WHEN printing_s =>
				--  printing <= '1';
				CASE order_save IS
					WHEN "0000" => -- No order

					WHEN "0001" => -- Gun
						

					WHEN "0010" => -- Capes or cloaks
						

					WHEN "0011" => -- Gun + cape or cloak
						

					WHEN "0100" => -- Yoda
						

					WHEN "0101" => -- Yoda + lightsaber
						valid_data  <= '1';
						data_in     <= '1';
						d           <= 5;
					WHEN "0110" => -- Yoda + cloak
						

					WHEN "0111" => -- Yoda + cloak + lightsaber
						

					WHEN "1000" => -- Leia
						

					WHEN "1001" => -- Leia + rifle
						

					WHEN "1010" => -- Leia + cape
						

					WHEN "1011" => -- Leia + cloak + lightsaber
						

					WHEN "1100" => -- Darth Vader
						

					WHEN "1101" => -- Darth Vader + lightsaber
						

					WHEN "1110" => -- Darth Vader + cloak
						

					WHEN "1111" => -- Darth Vader + lightsaber + cloak
						

					WHEN OTHERS =>
						
				END CASE;

			WHEN ready_s =>
				-- NEED TO CHANGE POSITION INTO PREVIOUS STATE IF TO MAKE MEALY   
				printing <= '0';
				ready    <= '1';
                reset_adder <= '1';
                -- Turn off delay 
                valid_data  <= '1';  --POBABLY POINTLESS SIGNAL, REMOVE?
				data_in     <= '1';  --POBABLY POINTLESS SIGNAL, REMOVE?
				d           <= 0;
			WHEN OTHERS =>
		END CASE;
	END PROCESS;
END Behavioral;