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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity threeD_printer is
  Port ( 
    -- Inputs
    cash_en : in std_logic;
    cash : in std_logic_vector(9 downto 0);
    cancel : in std_logic;
    order_en : in std_logic; 
    order : in std_logic_vector(3 downto 0); 
    reset : in std_logic; 
    clock: in std_logic; 
    -- Outputs
    check_balance : out std_logic;
    printing : out std_logic;
    ready : out std_logic;
    order_cancelled : out std_logic;
    change_en : out std_logic;
    change : out std_logic);
    end threeD_printer;

architecture Behavioral of threeD_printer is
    
    -- Decalare states that can be taken
    type state_type is (
        reset_s, 
        order_s,
        cancel_s,
        cash_s,
        printing_s,
        ready_s,
        check_balance_s);
    signal state, next_state : state_type;
    
    -- Outputs as signals 
    signal check_balance_s : std_logic;  
    signal printing_s : std_logic;
    signal ready_s : std_logic;
    signal order_cancelled_s : std_logic;
    signal change_en_s : std_logic;
    signal change_s : std_logic);

begin
    -- Assigning outputs to signals (change "_s" to "_sig")
    check_balance_s <=  check_balance;
    printing_s <= printing;
    ready_s <=  ready;
    order_cancelled_s <= order_cancelled;
    change_en_s <=  change;
    change_s <=  change;       

    -- The clock process
    sync_proc : process (clk) 
begin 
if rising_edge(clk) then 
    if (rst = '1') then 
    state <= S0;
    else 
    state <= next_state;
    end if;
    end if;
    end process;

    -- Next state decode 
    next_state_decode : process (state, order_en, cash_en, change_en, cancel_s) 
    begin 
when _s =>
next_state <= 
when _s =>
next_state <= 
when _s =>
next_state <= 
when _s =>
next_state <= 
when _s =>
next_state <= 
when _s =>
next_state <= 
when _s =>
next_state <= 
when _s =>
next_state <=  
     when others => 
     next_state <= reset;
     end case;
    end process;
    

end Behavioral;
