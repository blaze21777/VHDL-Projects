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
		pre_add_s,
		add_s,
		pre_order_s,
		order_s,
		cancel_s,
		cash_s,
		change_s,
		printing_s,
		ready_s,
		check_balance_s);
	SIGNAL state, next_state   : state_type;

	SIGNAL order_price         : std_logic_vector(num_bits + 2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL order_save          : std_logic_vector(3 DOWNTO 0)            := (OTHERS => '0');

	-- Serial adder signals 
	SIGNAL a, b                : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');
	SIGNAL s                   : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');

	--ALU signals 
	SIGNAL total_coin          : std_logic_vector(num_bits DOWNTO 0)     := (OTHERS => '0'); -- Sum of coins inserted ALU
  
    -- Subtraction
    SIGNAL sub_in1              : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');
	SIGNAL sub_in2              : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');
	SIGNAL sub_out              : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');

	-- adder 1
--	SIGNAL pr_in1              : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');
--	SIGNAL pr_in2              : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');
--	SIGNAL pr_out              : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');

--	-- Adder 2
--	SIGNAL pr_in1_1            : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');
--	SIGNAL pr_in2_2            : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');
--	SIGNAL pr_out2             : std_logic_vector(9 DOWNTO 0)            := (OTHERS => '0');

	-- Outputs as signals 
	SIGNAL check_balance_buf   : std_logic                               := '0';
	SIGNAL printing_buf        : std_logic                               := '0';
	SIGNAL ready_buf           : std_logic                               := '0';
	SIGNAL order_cancelled_buf : std_logic                               := '0';
	SIGNAL change_en_buf       : std_logic                               := '0';
	SIGNAL change_buf          : std_logic_vector(num_bits DOWNTO 0)     := (OTHERS => '0');

	-- Delay signals 
	-- signal Clk : std_logic := '0';
	SIGNAL valid_data          : std_logic                               := '0';
	SIGNAL data_in, data_out   : std_logic                               := '0';
	CONSTANT Clk_period        : TIME                                    := 5 ns;
	SIGNAL d                   : INTEGER                                 := 0; --number of clock cycles by which input should be delayed.

BEGIN
	-- Buffering outputs to signals 
	check_balance   <= check_balance_buf;
	printing        <= printing_buf;
	ready           <= ready_buf;
	order_cancelled <= order_cancelled_buf;
	change_en       <= change_en_buf;
	change          <= change_buf;

	-- Adder instatiation 
--	adder1 : ENTITY work.add_module(Behavior)
--		PORT MAP(
--			pr_in1 => cash,
--			pr_in2 => total_coin,
--			pr_out => pr_out
--		);

--	adder2 : ENTITY work.add_module(Behavior)
--		PORT MAP(
--			pr_in1 => pr_out,
--			pr_in2 => "0000000000",
--			pr_out => pr_out2
--		);

	-- Serial adder instatiation
	-- NEED TO CREATE EXPLICIT PORT MAPPING!
	serial_adder : ENTITY work.serial_adder(behav)
		PORT MAP(Clk, reset, a, b, s);

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
	next_state_decode : PROCESS (state, order_en, cash_en, d, data_out, total_coin) IS

	BEGIN

		CASE state IS
			-- Reset state --
			WHEN reset_s =>
				-- next_state <= pre_add_s;

				-- alu_out <= std_logic_vector(unsigned(alu_in1) + unsigned(total_coin)); 

				IF (order_en = '1') THEN
					-- Maybe an array to hold all the cahs values until next state
					next_state <= pre_order_s;
					--alu_out <= std_logic_vector(unsigned(alu_in1) + unsigned(alu_in2));
					-- Need condition to get it to change state after accepting all money 
					--  		if (cash_en = '0') then
					--        next_state <= order_s;
					--        end if;
				END IF;

				--  		WHEN pre_add_s =>  

				--        -- alu_out <= std_logic_vector(unsigned(alu_in1) + unsigned(alu_in2)); 
				--        -- alu_out <= std_logic_vector(unsigned(alu_in1) + unsigned(alu_in2));
				--         if (cash_en = '1') then
				--         next_state <= add_s;    
				--        end if;

				--  		WHEN add_s =>
				--  		 if (order_en = '1') then 
				--        -- Maybe an array to hold all the cahs values until next state
				--         next_state <= pre_order_s;
				--  		--alu_out <= std_logic_vector(unsigned(alu_in1) + unsigned(alu_in2));
				--  		-- Need condition to get it to change state after accepting all money 
				----  		if (cash_en = '0') then
				----        next_state <= order_s;
				----        end if;
				--        else 
				--        next_state <= pre_add_s;
				--  		end if;
				
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

				IF (total_coin < order_price) THEN
					next_state <= cancel_s;
				ELSE
					next_state <= change_s;
				END IF;
			
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
	         
				--            next_state <=
				--            WHEN _s =>
				--            next_state <=
				--            WHEN _s =>
				--            next_state <=
			WHEN OTHERS =>
				next_state <= reset_s;
		END CASE;
	END PROCESS;

	-- Output decode
	output_decode : PROCESS (order_en, state, d, order_save, data_out, total_coin, cash, cash_en, order_price) IS

		-- variable alu_in1        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
		--	variable alu_in2        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
		--	variable alu_out        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');  
		VARIABLE total_cash : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0'); -- Sum of coins inserted ALU
	BEGIN
		CASE state IS
		
		    -- Reset state --
			WHEN reset_s =>
				-- Set all outputs to 0
				check_balance   <= '0';
				printing        <= '0';
				ready           <= '0';
				order_cancelled <= '0';
				change_en       <= '0';
				change          <= "0000000000";
				-- s <= "0000000000"; -- Reset adder tally
				-- total_coin  <= alu_out;
				--alu_in1     <= cash;
				--alu_in2     <= total_coin;

				-- Adder signals 
				IF (cash_en = '1') THEN
					a          <= cash;
					b          <= "0000000000";
					total_coin <= s;
				ELSE
					a <= "0000000000";
					-- total_coin <= pr_out2; 
					-- pr_in1 <= cash;
					--pr_in2 <= total_cash;
					-- pr_in2_2 <= cash;
					--total_cash  := pr_out;
				END IF;
				--
				--        Total_Coin  := "0000000000";
				--        alu_in1     := cash;
				--        alu_in2     := total_coin;

				-- Mealy output    
				IF (order_en = '1') THEN
					order_save <= order;
					printing   <= '0';
				END IF;

				--        WHEN pre_add_s =>
				--        -- Stop it from adding everything!
				--        if (cash_en = '1') then 
				--        pr_in1 <= cash;
				--        pr_in2 <= total_coin;
				--        end if;

				--        WHEN add_s =>
				--        -- Update total coin
				--       total_coin <= pr_out;

				-- Pre order state -- 
				-- printing time should be assigned here
			WHEN pre_order_s =>
				CASE order IS
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
              sub_in2 <= "0000000001"; -- ORDER PRICE HAS 12 ELEMENTS NEED TO FIX!
            -- Change state --
            WHEN change_s =>
   --         change_buf <= std_logic_vector(unsigned(total_coin) - unsigned(order_price)); 
          
            sub_out <= std_logic_vector(unsigned(sub_in1) - unsigned(sub_in2)); 
            -- Cancel state --
			WHEN cancel_s   =>
            change_buf <= total_coin; -- CHANGE BUFF IS BASICALLY TOTOAL COIN, RENAME?
            
            -- Printing state --
			WHEN printing_s =>
				--  printing <= '1';
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
						valid_data  <= '1';
						data_in     <= '1';
						d           <= 5;
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

			WHEN ready_s =>
				-- NEED TO CHANGE POSITION INTO PREVIOUS STATE IF TO MAKE MEALY   
				printing <= '0';
				ready    <= '1';
				--        WHEN _s =>

				--        WHEN _s =>
				--        next_state <=
			WHEN OTHERS =>
		END CASE;
	END PROCESS;
END Behavioral;