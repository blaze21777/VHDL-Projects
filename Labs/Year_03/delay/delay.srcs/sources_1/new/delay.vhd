----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2019 03:13:29
-- Design Name: 
-- Module Name: delay - Behavioral
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

entity delay is
port(   Clk : in std_logic;
        valid_data : in std_logic; -- goes high when the input is valid.
        data_in : in std_logic; -- the data input
        d : in integer; --number of clock cycles by which input should be delayed.
        data_out : out std_logic --the delayed input data.
        );
end delay;

architecture Behavioral of delay is

signal c : integer := 0;
-- constant d : integer := 100; --number of clock cycles by which input should be delayed.
signal data_temp : std_logic := '0';
type state_type is (idle,delay_c); --defintion of state machine type
signal next_s : state_type; --declare the state machine signal.

begin

process(Clk)
begin
    if(rising_edge(Clk)) then
        case next_s is
            when idle =>
                if(valid_data= '1') then
                    next_s <= delay_c;
                    data_temp <= data_in; --register the input data.
                    c <= 1;
                end if;
            when delay_c =>
                if(c = d) then
                    c <= 1; --reset the count
                    data_out <= data_temp; --assign the output
                    next_s <= idle; --go back to idle state and wait for another valid data.
                else
                    c <= c + 1;
                end if;
            when others =>
                NULL;
        end case;
    end if;
end process;   

   
end Behavioral;
