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
		add_s,
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
	signal add_in1, add_in2  : std_logic_vector(11 downto 0)           := (others => '0');
	signal add_out           : std_logic_vector(11 downto 0)           := (others => '0');
	signal reset_adder       : std_logic                               := '0';

	-- Subtraction signals 
	signal sub_in1           : std_logic_vector(11 downto 0)           := (others => '0');
	signal sub_in2           : std_logic_vector(11 downto 0)           := (others => '0');
	signal sub_out           : std_logic_vector(11 downto 0)           := (others => '0');
	
	-- Constants as defined in the specfication
	constant ten_pounds      : std_logic_vector(11 downto 0)           := "001111101000";
	constant five_pounds     : std_logic_vector(11 downto 0)           := "000111110100";
	constant two_pounds      : std_logic_vector(11 downto 0)           := "000011001000";
	constant one_pound       : std_logic_vector(11 downto 0)           := "000001100100";
	constant fifty_pence     : std_logic_vector(11 downto 0)           := "000000110010";
	
	-- Counter signals 
	signal count_rst         : std_logic;
	signal count_en          : std_logic;
	signal max_count         : integer;
	signal count_done              : std_logic;
begin

	-- Serial adder instatiation
	serial_adder : entity work.serial_adder(behav)
		port map(
			clk   => clk,
			reset => reset_adder,
			add_in1  => add_in1,
			add_in2     => add_in2,
			add_out     => add_out);
			
    -- Counter instantiation 
	counter : entity work.loop_counter(Behavioral)
		port map(
			clk       => clk,
			reset     => count_rst,
			count_en  => count_en,
			max_count => max_count,
			count_done      => count_done);

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
	
    ----------------------------------------------------------
	------------------- Next state decode -------------------- 
	----------------------------------------------------------
	next_state_decode : process (order_price, sub_out, cancel, 
	                             state, order_en, cash_en, 
	                             count_done,add_out, cancel_save) is 

	begin

		case state is
		    ------------------- Reset state ---------------------- 
		    when reset_s => 
		    next_state <= add_s;
		    
			------------------- Add state ------------------------ 
			when add_s =>
				if (order_en = '1') then
					next_state <= pre_order_s;
				elsif (cancel = '1') then
					next_state <= cancel_s;
				end if;

			------------------- Pre order state -------------------
			when pre_order_s =>
				if (cancel = '1') then -- 
					next_state <= cancel_s;
				else
					next_state <= order_s;
				end if;

			------------------- Order state ------------------------
			when order_s =>
				-- If balance => order price, then execute the order and give the change back
				-- If balance =< order price, then cancel the order and give the current balance back
				if (add_out >= order_price) then -- s = total cash from adder
					next_state <= subtract_s;
				elsif (add_out < order_price) then -- WAS TOTAL_CASH
					next_state <= cancel_s;
				else
					next_state <= subtract_s;
				end if;

			-------------------  Subtract state ---------------------
			when subtract_s =>
				next_state <= change_s;

			------------------- Change state ------------------------
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

			------------------- Cancel state -------------------------
			when cancel_s =>

				next_state <= subtract_s;

			------------------- Printing state -----------------------
			when printing_s =>
			    -- done = delay signal to simulate printing
			    -- Extra cycle is taken to change state but printing is finished when done = 1
				if (count_done = '1') then 
					next_state <= ready_s;
				end if;
			
			------------------- Ready state --------------------------
			when ready_s =>
			next_state <= reset_s;
			
            ------------------- Check balance state ------------------
			when check_balance_s =>
            
            ------------------- Error check state --------------------
            -- FSM should neve make it to this state if error free
			when others          =>
				next_state <= reset_s;
		end case;
	end process;
	
    --------------------------------------------------------- 
	------------------- Output decode -----------------------
	--------------------------------------------------------- 
	output_decode : process (add_out, sub_in1, sub_in2, sub_out, 
	                         order, order_en, state, order_save,
	                         cash, cash_en, order_price) is
	begin
		case state is

			------------------- Reset state --------------------- 
			when reset_s =>
				-- Reset FSM outputs and signal 
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
      
				-- Adder signals 
				reset_adder     <= '0'; -- Reset in ready state
				
			------------------- Add state -----------------------
			check_balance <= '1'; -- When 1 adder output will be displayed to a display 
			when add_s =>
				-- Adding takes place in reset as no need for extra state.
				if (cash_en = '1') then
					add_in1    <= "00" & cash; -- 12-bit assignment 
					add_in2    <= "000000000000"; -- Always zero as after first assignment output is used 
				else
					add_in1 <= "000000000000"; -- Stop adding when cash_en is off

				end if;
                
                -- Next state condition 
				if (order_en = '1') then
					order_save <= order; -- Save order to be used later 
				end if;

		    ------------------- Pre order state ------------------- 
		    -- Order prices are assigned in this state 
			when pre_order_s =>
				case order_save is -- Uses order save as order gets reset 
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

			------------------- Order state -----------------------
			when order_s =>
                -- Assign values in preperation for change calculation 
				sub_in1 <= add_out;           
				sub_in2 <= order_price; -- If bigger than s order is cancelled so no negative numbers 

			------------------- Subtract state --------------------
			when subtract_s =>
			    -- Subtraction calculation 
				sub_out <= std_logic_vector(unsigned(sub_in1) - unsigned(sub_in2));

			------------------- Change state ----------------------     
			-- Change calculation takes multiple clock cycles as total cash needs to be 
			-- split into 10-bit values of accepted cash                                                                                                
			when change_s =>
				change_en <= '1'; -- Turn on when change is being calculated 
				count_rst <= '0'; -- Allows counter to count
				
				-- Keep subtracting until zero is reached
				if (sub_out > ten_pounds) then -- Greater than £10 
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
				change  <= "0000000000"; -- Must set to zero as it keeps last value for infinte change despensing
				change_en <= '0'; -- Change is no longer being calculated 
				end if;
				

			------------------- Cancel state ----------------------
			when cancel_s   =>
				sub_in1 <= add_out;           
				sub_in2 <= "000000000000"; -- An intial value is required 
                cancel_save <= '1'; -- Indicate cancel has been triggered 
                order_cancelled <= '1'; -- Order has been cancelled (can't read ouputs)
                reset_adder <= '1';
                
			------------------- Printing state ---------------------
			when printing_s =>
			      -- Check balance cannot happen at the same time as printing 
			      -- Balance goes to zero once change has been given
			      check_balance <= '0'; 
				  printing <= '1'; -- Printing in progress
				case order_save is
					when "0000" => -- No order
                        -- NEED TO FIGURE OUT WHAT HAPPENS HERE
                        
					when "0001" => -- Gun
						max_count  <= 1;
						count_en   <= '1';

					when "0010" => -- Capes or cloaks
						max_count  <= 2;
						count_en   <= '1';

					when "0011" => -- Gun + cape or cloak
						max_count  <= 3;
						count_en   <= '1';

					when "0100" => -- Yoda
						max_count  <= 4;
						count_en   <= '1';

					when "0101" => -- Yoda + lightsaber
						max_count  <= 5;
						count_en   <= '1';
					when "0110" => -- Yoda + cloak
						max_count  <= 6;
						count_en   <= '1';

					when "0111" => -- Yoda + cloak + lightsaber
						max_count  <= 7;
						count_en   <= '1';

					when "1000" => -- Leia
						max_count  <= 8;
						count_en   <= '1';

					when "1001" => -- Leia + rifle
						max_count  <= 9;
						count_en   <= '1';

					when "1010" => -- Leia + cape
						max_count  <= 10;
						count_en   <= '1';

					when "1011" => -- Leia + cloak + lightsaber
						max_count  <= 11;
						count_en   <= '1';

					when "1100" => -- Darth Vader
						max_count  <= 12;
						count_en   <= '1';

					when "1101" => -- Darth Vader + lightsaber
						max_count  <= 13;
						count_en   <= '1';

					when "1110" => -- Darth Vader + cloak
						max_count  <= 14;
						count_en   <= '1';

					when "1111" => -- Darth Vader + lightsaber + cloak
						max_count  <= 15;
						count_en   <= '1';

					when others => -- Should never make it here

				end case;

			when ready_s =>
				-- NEED TO CHANGE POSITION INTO PREVIOUS STATE IF TO MAKE MEALY   
				printing    <= '0'; -- Printing finished 
				ready       <= '1'; -- Product can be collected 
				reset_adder <= '1';
				count_en    <= '0'; -- Stop counter from counting 
			when others =>
		end case;
	end process;
end Behavioral;