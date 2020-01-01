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
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity threeD_printer is
	generic (num_bits : integer := 9);
	port (
		-- Inputs
		cash_en         : in std_logic;
		cash            : in std_logic_vector(num_bits downto 0);
		cancel          : in std_logic;
		order_en        : in std_logic;
		order           : in std_logic_vector(3 downto 0);
		reset           : in std_logic;
		clk             : in std_logic;
		-- Outputs
		check_balance   : out std_logic;
		printing        : out std_logic;
		ready           : out std_logic;
		order_cancelled : out std_logic;
		change_en       : out std_logic;
		change          : out std_logic_vector(num_bits downto 0));
end threeD_printer;

architecture Behavioral of threeD_printer is

	-- Decalare states that can be taken
	type state_type is (
		reset_s,
		pre_order_s,
		order_s,
		cancel_s,
		subtract_s,
		change_s,
		printing_s,
		ready_s,
		check_balance_s);
	signal state, next_state : state_type;

	-- Order signals
	signal order_price       : std_logic_vector(num_bits + 2 downto 0) := (others => '0');
	signal order_save        : std_logic_vector(3 downto 0)            := (others => '0');
	
	-- Cancel signal
	signal cancel_save       : std_logic                               := '0';

	-- Serial adder signals 
	signal a, b              : std_logic_vector(11 downto 0)           := (others => '0');
	signal s                 : std_logic_vector(11 downto 0)           := (others => '0');
	signal reset_adder       : std_logic                               := '0';
	signal total_cash        : std_logic_vector(num_bits + 2 downto 0) := (others => '0'); -- Sum of coins inserted ALU

	-- Subtraction
	-- NEED TO FIX 12 BIT SUBTRACTION
	signal sub_in1           : std_logic_vector(11 downto 0)           := (others => '0');
	signal sub_in2           : std_logic_vector(11 downto 0)           := (others => '0');
	signal sub_out           : std_logic_vector(11 downto 0)           := (others => '0');
	constant ten_pounds      : std_logic_vector(11 downto 0)           := "001111101000";
	constant five_pounds     : std_logic_vector(11 downto 0)           := "000111110100";
	constant two_pounds      : std_logic_vector(11 downto 0)           := "000011001000";
	constant one_pound       : std_logic_vector(11 downto 0)           := "000001100100";
	constant fifty_pence     : std_logic_vector(11 downto 0)           := "000000110010";
	-- Delay signals 
	signal valid_data        : std_logic                               := '0';
	signal data_in, data_out : std_logic                               := '0';
	signal d                 : integer                                 := 0; --number of clock cycles by which input should be delayed.

	-- Counter signals 
	signal count_rst         : std_logic;
	signal count_en          : std_logic;
	signal max_count         : integer;
	signal done              : std_logic;
begin

	-- Serial adder instatiation
	-- NEED TO CREATE EXPLICIT PORT MAPPING!
	-- https://stackoverflow.com/questions/21163915/how-does-vhdl-deal-with-overflow
	serial_adder : entity work.serial_adder(behav)
		port map(
			clk   => clk,
			reset => reset_adder,
			a     => a,
			b     => b,
			s     => s);

	-- dealay instatiation
	delay : entity work.delay port map (
		Clk        => Clk,
		valid_data => valid_data,
		data_in    => data_in,
		data_out   => data_out,
		d          => d
		);

	counter : entity work.loop_counter(Behavioral)
		port map(
			clk       => clk,
			reset     => count_rst,
			count_en  => count_en,
			max_count => max_count,
			done      => done);

	-- The clock process
	sync_proc : process (clk)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				state <= reset_s;
			else
				state <= next_state;
			end if;
		end if;
	end process;

	-- Next state decode 
	next_state_decode : process (order_price, sub_out, cancel, state, order_en, cash_en, d, data_out, total_cash, done) is -- NEED TO REMOVE DATA OUT!!

	begin

		case state is
				-- Reset state --
			when reset_s =>
				if (order_en = '1') then
					next_state <= pre_order_s;
				elsif (cancel = '1') then
					next_state <= cancel_s;
				end if;

				-- Pre order state --
			when pre_order_s =>
				if (cancel = '1') then --- MIGHT BE POINTLESS 
					next_state <= cancel_s;
				else
					next_state <= order_s;
				end if;

				-- Order state --
			when order_s =>
				-- If balance => order price, then execute the order and give the change back
				-- If balance =< order price, then cancel the order and give the current balance back
				if (s >= order_price) then
					next_state <= subtract_s;
				elsif (s < order_price) then -- WAS TOTAL_CASH
					next_state <= cancel_s;
				else
					next_state <= subtract_s;
				end if;

				-- Subtract state --
			when subtract_s =>
				next_state <= change_s;

				-- Change state --
			when change_s =>
							
				if (sub_out > ten_pounds) then -- Greather than £10
					next_state <= subtract_s;
				elsif (sub_out > five_pounds and sub_out <= ten_pounds) then -- Greater than £5
					next_state <= subtract_s;
				elsif (sub_out > two_pounds and sub_out <= five_pounds) then -- Greater than £2
					next_state <= subtract_s;
				elsif (sub_out > one_pound and sub_out <= two_pounds) then -- Greater than £1
					next_state <= subtract_s;
				elsif (sub_out > "000000000000" and sub_out <= one_pound) then -- Greater than 50p
					next_state <= subtract_s;
				elsif (sub_out = "000000000000") then -- Greater than 50p
				    if (cancel_save = '1') then 
				    next_state <= reset_s;
				    else	
				    next_state <= printing_s;
				    end if;
				end if;

				-- Cancel state --
			when cancel_s =>

				next_state <= subtract_s;

				-- Printing state --
			when printing_s =>
				-- Printing test
				if (done = '1') then
					next_state <= ready_s;
				end if;

			when check_balance_s =>

			when others          =>
				next_state <= reset_s;
		end case;
	end process;

	-- Output decode
	output_decode : process (s, sub_in1, sub_in2, sub_out, order, order_en, state, d, order_save, data_out, total_cash, cash, cash_en, order_price) is

	begin
		case state is

				-- Reset state --
			when reset_s =>
				-- Set all FSM outputs to 0
				check_balance   <= '0';
				printing        <= '0';
				ready           <= '0';
				order_cancelled <= '0';
				change_en       <= '0';
				change          <= "0000000000";
				
				-- Reset buffer signals
                cancel_save <= '0';
                order_cancelled <= '0';
               -- order_save <= "0000";
                
				-- Counter signals 
				count_rst       <= '1'; -- Reset counter 
				count_en        <= '0';
				max_count       <= 0;

				-- Delay signals
				-- data_out <= '0';      
				-- Adder signals 
				reset_adder     <= '0'; -- Reset in ready state
				-- NEED TO ADD OVERFLOW COMPENSAION 	
				if (cash_en = '1') then
					a          <= "00" & cash; -- 12-bit assignment 
					b          <= "000000000000";
					total_cash <= s;
				else
					a <= "000000000000";

				end if;

				-- Mealy output    
				if (order_en = '1') then
					order_save <= order;
					printing   <= '0';
				end if;

				-- Pre order state -- 
				-- printing time should be assigned here
			when pre_order_s =>
				case order_save is
					when "0000" => -- No order
						order_price <= x"000";

					when "0001" => -- Gun
						order_price <= x"0C8";

					when "0010" => -- Capes or cloaks
						order_price <= x"258";

					when "0011" => -- Gun + cape or cloak
						order_price <= x"258";

					when "0100" => -- Yoda
						order_price <= x"8CA";

					when "0101" => -- Yoda + lightsaber
						order_price <= x"992";

					when "0110" => -- Yoda + cloak
						order_price <= x"B22";

					when "0111" => -- Yoda + cloak + lightsaber
						order_price <= x"BEA";

					when "1000" => -- Leia
						order_price <= x"AF0";

					when "1001" => -- Leia + rifle
						order_price <= x"BB8";

					when "1010" => -- Leia + cape
						order_price <= x"D48";

					when "1011" => -- Leia + cloak + lightsaber
						order_price <= x"E10";

					when "1100" => -- Darth Vader
						order_price <= x"C80";

					when "1101" => -- Darth Vader + lightsaber
						order_price <= x"D48";

					when "1110" => -- Darth Vader + cloak
						order_price <= x"ED8";

					when "1111" => -- Darth Vader + lightsaber + cloak
						order_price <= x"FA0";

					when others =>
						order_price <= x"000";
				end case;

				-- Order state --
			when order_s =>

				sub_in1 <= s;           -- SHOULD BE TOTAL COIN BUT THATS BROKEN NOW.
				sub_in2 <= order_price; -- ORDER PRICE HAS 12 ELEMENTS NEED TO FIX!

				-- Subtract state --
			when subtract_s =>
				sub_out <= std_logic_vector(unsigned(sub_in1) - unsigned(sub_in2));

				-- Change state --     
				-- CHANGE TAKES MULTIPLE CLOCK CYCLES, SPLIT TOTAL CASH TO 10-BIT PARTS
				-- MULTIPLE IF STATEMETNS TO CHECK IF HIGHEST DENOMINATION CAN BE TAKEN OUT                                                                                                  
			when change_s =>
				change_en <= '1';
				
				count_rst <= '0'; -- Preparing counter to count
				if (sub_out > ten_pounds) then -- Greater than £10
					-- NEED TO CLEAN UP WITH CONSTANTS 
					change  <= ten_pounds(num_bits downto 0);
					sub_in1 <= sub_out;
					sub_in2 <= ten_pounds;
					
				elsif (sub_out >= five_pounds and sub_out <= ten_pounds) then -- Greater than £5
					change  <= five_pounds(num_bits downto 0);
					sub_in1 <= sub_out;
					sub_in2 <= five_pounds;
					
				elsif (sub_out >= two_pounds and sub_out <= five_pounds) then -- Greater than £2
					change  <= two_pounds(num_bits downto 0);
					sub_in1 <= sub_out;
					sub_in2 <= two_pounds;
					
				elsif (sub_out >= one_pound and sub_out <= two_pounds) then -- Greater than £1
					change  <= one_pound(num_bits downto 0);
					sub_in1 <= sub_out;
					sub_in2 <= one_pound;
					
				elsif (sub_out > "000000000000" and sub_out <= one_pound) then -- Greater than 50p
				    change  <= fifty_pence(num_bits downto 0);
					sub_in1 <= sub_out;
					sub_in2 <= fifty_pence;
					
				elsif (sub_out = "000000000000") then -- Zero
				change  <= "0000000000";
				change_en <= '0';
				end if;
				

				-- Cancel state --
			when cancel_s   =>
				sub_in1 <= s;           -- SHOULD BE TOTAL COIN BUT THATS BROKEN NOW.
				sub_in2 <= "000000000000"; 
                cancel_save <= '1';
                reset_adder <= '1';
                order_cancelled <= '1';
				-- Printing state -- NEED TO REMOVE ALL DELAY SIGNAL, USELESS
			when printing_s =>
				  printing <= '1';
				case order_save is
					when "0000" => -- No order

					when "0001" => -- Gun
						valid_data <= '1';
						data_in    <= '1';
						d          <= 1;
						max_count  <= 1;
						count_en   <= '1';

					when "0010" => -- Capes or cloaks
						valid_data <= '1';
						data_in    <= '1';
						d          <= 2;
						max_count  <= 2;
						count_en   <= '1';

					when "0011" => -- Gun + cape or cloak
						valid_data <= '1';
						data_in    <= '1';
						d          <= 3;
						max_count  <= 3;
						count_en   <= '1';

					when "0100" => -- Yoda
						valid_data <= '1';
						data_in    <= '1';
						d          <= 4;
						max_count  <= 4;
						count_en   <= '1';

					when "0101" => -- Yoda + lightsaber
						valid_data <= '1';
						data_in    <= '1';
						d          <= 5;
						max_count  <= 5;
						count_en   <= '1';
					when "0110" => -- Yoda + cloak
						valid_data <= '1';
						data_in    <= '1';
						d          <= 6;
						max_count  <= 6;
						count_en   <= '1';

					when "0111" => -- Yoda + cloak + lightsaber
						valid_data <= '1';
						data_in    <= '1';
						d          <= 7;
						max_count  <= 7;
						count_en   <= '1';

					when "1000" => -- Leia
						valid_data <= '1';
						data_in    <= '1';
						d          <= 8;
						max_count  <= 8;
						count_en   <= '1';

					when "1001" => -- Leia + rifle
						valid_data <= '1';
						data_in    <= '1';
						d          <= 9;
						max_count  <= 9;
						count_en   <= '1';

					when "1010" => -- Leia + cape
						valid_data <= '1';
						data_in    <= '1';
						d          <= 10;
						max_count  <= 10;
						count_en   <= '1';

					when "1011" => -- Leia + cloak + lightsaber
						valid_data <= '1';
						data_in    <= '1';
						d          <= 11;
						max_count  <= 11;
						count_en   <= '1';

					when "1100" => -- Darth Vader
						valid_data <= '1';
						data_in    <= '1';
						d          <= 12;
						max_count  <= 12;
						count_en   <= '1';

					when "1101" => -- Darth Vader + lightsaber
						valid_data <= '1';
						data_in    <= '1';
						d          <= 13;
						max_count  <= 13;
						count_en   <= '1';

					when "1110" => -- Darth Vader + cloak
						valid_data <= '1';
						data_in    <= '1';
						d          <= 14;
						max_count  <= 14;
						count_en   <= '1';

					when "1111" => -- Darth Vader + lightsaber + cloak
						valid_data <= '1';
						data_in    <= '1';
						d          <= 15;
						max_count  <= 15;
						count_en   <= '1';

					when others =>

				end case;

			when ready_s =>
				-- NEED TO CHANGE POSITION INTO PREVIOUS STATE IF TO MAKE MEALY   
				printing    <= '0';
				ready       <= '1';
				reset_adder <= '1';
				-- Turn off delay and counter!!!!
				valid_data  <= '1'; --POBABLY POINTLESS SIGNAL, REMOVE?
				data_in     <= '1'; --POBABLY POINTLESS SIGNAL, REMOVE?
				d           <= 0;
				count_en    <= '0';
			when others =>
		end case;
	end process;
end Behavioral;