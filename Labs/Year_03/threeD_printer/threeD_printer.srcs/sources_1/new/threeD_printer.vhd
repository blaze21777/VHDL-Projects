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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY threeD_printer IS
    GENERIC (num_bits : INTEGER := 9);
    PORT (
        -- Inputs
        cash_en : IN std_logic;
        cash : IN std_logic_vector(num_bits DOWNTO 0);
        cancel : IN std_logic;
        order_en : IN std_logic;
        order : IN std_logic_vector(3 DOWNTO 0);
        reset : IN std_logic;
        clk : IN std_logic;
        -- Outputs
        check_balance : OUT std_logic;
        printing : OUT std_logic;
        ready : OUT std_logic;
        order_cancelled : OUT std_logic;
        change_en : OUT std_logic;
        change : OUT std_logic_vector(num_bits DOWNTO 0));
END threeD_printer;

ARCHITECTURE Behavioral OF threeD_printer IS

    -- Decalare states that can be taken
    TYPE state_type IS (
        reset_s,
        pre_order_s,
        order_s,
        cancel_s,
        cash_s,
        printing_s,
        ready_s,
        check_balance_s);
    SIGNAL state, next_state : state_type;
    
    SIGNAL order_price : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
    SIGNAL printing_time : time;
    
    --ALU signals to check adder and subtractor
--	SIGNAL alu_in1        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
--	SIGNAL alu_in2        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
--	SIGNAL alu_out        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');  
--	SIGNAL total_coin     : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0'); -- Sum of coins inserted ALU
    
    -- Outputs as signals 
    SIGNAL check_balance_buf : std_logic;
    SIGNAL printing_buf : std_logic;
    SIGNAL ready_buf : std_logic;
    SIGNAL order_cancelled_buf : std_logic;
    SIGNAL change_en_buf : std_logic;
    SIGNAL change_buf : std_logic_vector(num_bits downto 0);

BEGIN
    -- Buffering outputs to signals 
    check_balance <= check_balance_buf;
    printing <= printing_buf;
    ready <= ready_buf;
    order_cancelled <= order_cancelled_buf;
    change_en <= change_en_buf;
    change <= change_buf;

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
    next_state_decode : PROCESS (state, order_en, cash_en) is
    
--    variable alu_in1        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
--	variable alu_in2        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
--	variable alu_out        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');  
--	variable total_coin     : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0'); -- Sum of coins inserted ALU
    
    BEGIN
    
        CASE state is 
        -- Reset state --
        WHEN reset_s =>   
        
        -- While loop
--        while cash_en = '1' loop
--            alu_out <= std_logic_vector(unsigned(alu_in1) + unsigned(alu_in2));
--        end loop;
             
        if (order_en = '1') then 
        -- Maybe an array to hold all the cahs values until next state
         next_state <= pre_order_s;
  		alu_out := std_logic_vector(unsigned(alu_in1) + unsigned(alu_in2));
  		-- Need condition to get it to change state after accepting all money 
--  		if (cash_en = '0') then
--        next_state <= order_s;
--        end if;
  		end if;
  		
            WHEN pre_order_s =>
              if (cancel = '1') then 
              next_state <= cancel_s;
              else
              next_state <= order_s;
              end if;
              
              -- Order state
              WHEN order_s =>
             -- If balance = order price, then proceed with the order
             -- If balance => order price, then execute the order and give the change back
             -- If balance =< order price, then cancel the order and give the current balance back

--            next_state <=
              WHEN cancel_s =>
              
--            next_state <=
--            WHEN _s =>
--            next_state <=
--            WHEN _s =>
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
output_decode : PROCESS (order_en,state) is

 variable alu_in1        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
	variable alu_in2        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');
	variable alu_out        : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0');  
	variable total_coin     : std_logic_vector(num_bits DOWNTO 0) := (OTHERS => '0'); -- Sum of coins inserted ALU
    

begin
    case state is
    WHEN reset_s =>
    -- Set all outputs to 0
        check_balance <= '0';
        printing <= '0';
        ready <= '0';
        order_cancelled <= '0';
        change_en <= '0';
        change <= "0000000000";
        Total_Coin  := "0000000000";
        alu_in1     := cash;
        alu_in2     := total_coin;
        
    -- Mealy output    
    if (order_en = '1') then 
        printing <= '0';
        end if;
        
        -- Pre order state 
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
				
          WHEN order_s =>
          -- set output to some value 

          WHEN cancel_s =>
            
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=

    
    WHEN OTHERS =>
    end case;
    end process;
    END Behavioral;