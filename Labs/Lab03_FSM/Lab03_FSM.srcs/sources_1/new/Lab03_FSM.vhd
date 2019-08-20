----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.08.2019 11:21:23
-- Design Name: 
-- Module Name: Lab03_FSM - Behavioral
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

entity Lab03_FSM is
  Port ( 
    -- Inputs
    GCLK : in STD_LOGIC;
    BTNC : in STD_LOGIC;
    BTNL : in STD_LOGIC;
    SW0 : in STD_LOGIC;
    SW1 : in STD_LOGIC;
    SW2 : in STD_LOGIC;
    -- Output
    LD0 : out STD_LOGIC);
end Lab03_FSM;

architecture Behavioral of Lab03_FSM is
    type t_state is (s0, s1, s2, s3, s4);
    signal state, next_state : t_state;
    signal reset : std_logic;
    signal b : std_logic;
    signal c : std_logic;
    signal d : std_logic;
    signal transition : std_logic;
begin

    sync_proc : process(GCLK,reset) is
    begin
        if reset = '1' then  
        state <= s0;
        elsif rising_edge(GCLK) then
        state <= next_state;
        end if;
    end process;
    
    

end Behavioral;
