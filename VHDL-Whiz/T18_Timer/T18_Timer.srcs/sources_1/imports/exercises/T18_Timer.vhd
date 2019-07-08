library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T18_Timer is
generic(ClockFrequencyHz : integer);
port(
    Clk     : in std_logic;
    nRst    : in std_logic; -- Negative reset
    Seconds : inout integer;
    Minutes : inout integer;
    Hours   : inout integer);
end entity;

architecture rtl of T18_Timer is

    -- Signal for counting clock periods
    signal Ticks : integer;
    
begin

    process(Clk) is
    begin
        if rising_edge(Clk) then

            -- If the negative reset signal is active
            if nRst = '0' then
            
                -- TODO: Reset all the outputs and the Ticks signal
                Seconds <= 0;
                Minutes <= 0;
                Hours   <= 0;
                Ticks   <= 0;
            else

                -- True once every second
                if Ticks = ClockFrequencyHz - 1 then  -- 0 to X includes 0 so "-1" required
                    Ticks <= 0;
            
                    -- TODO: Implement the Seconds, Minutes and Hours counter
                    --       here by using nested If-Then-Else statements.
                    if Seconds = 59 then 
                        Seconds <= 0;
                        
                        -- True once a minute 
                        if minutes = 59 then 
                            Minutes <= 0;
                            
                            -- True once a day 
                            if Hours = 23 then 
                                Hours <= 0;
                            else 
                                Hours <= Hours + 1;
                            end if;
                        else 
                            Minutes <= Minutes + 1; 
                        end if;
                    else 
                        Seconds <= Seconds + 1;
                    end if;
                else
                    Ticks <= Ticks + 1;
                end if;
            
            end if;
        end if;
    end process;

end architecture;