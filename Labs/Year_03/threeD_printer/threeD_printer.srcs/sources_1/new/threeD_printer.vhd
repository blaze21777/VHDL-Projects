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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY threeD_printer IS
    PORT (
        -- Inputs
        cash_en : IN std_logic;
        cash : IN std_logic_vector(9 DOWNTO 0);
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
        change : OUT std_logic);
END threeD_printer;

ARCHITECTURE Behavioral OF threeD_printer IS

    -- Decalare states that can be taken
    TYPE state_type IS (
        reset_s,
        order_s,
        cancel_s,
        cash_s,
        printing_s,
        ready_s,
        check_balance_s);
    SIGNAL state, next_state : state_type;

    -- Outputs as signals 
--    SIGNAL check_balance_s : std_logic;
--    SIGNAL printing_s : std_logic;
--    SIGNAL ready_s : std_logic;
--    SIGNAL order_cancelled_s : std_logic;
--    SIGNAL change_en_s : std_logic;
--    SIGNAL change_s : std_logic);

BEGIN
    -- Assigning outputs to signals 
--    check_balance_sig <= check_balance;
--    printing_sig <= printing;
--    ready_sig <= ready;
--    order_cancelled_sig <= order_cancelled;
--    change_en_sig <= change;
--    change_sig <= change;

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
    BEGIN
        CASE state is 
        -- Reset state --
        WHEN reset_s =>        
        if (order_en = '1') then 
        next_state <= order_s;
        end if;
        
--            WHEN _s =>
--            next_state <=
--            WHEN _s =>
--            next_state <=
--            WHEN _s =>
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
begin
    case state is
    WHEN reset_s =>
    -- Set all outputs to 0
        check_balance <= '0';
        printing <= '0';
        ready <= '0';
        order_cancelled <= '0';
        change_en <= '0';
        change <= '0';
        
    -- Mealy output    
    if (order_en = '1') then 
        printing <= '0';
        
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
--        WHEN _s =>
--        next_state <=
    end if;
    
    WHEN OTHERS =>
    end case;
    end process;
    END Behavioral;