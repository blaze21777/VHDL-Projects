-- TODO: Import the IEEE library for using std_logic
library ieee;
use ieee.std_logic_1164.all;

entity T10_StdLogicTb is
end entity;

architecture sim of T10_StdLogicTb is

    -- TODO: Declare a signal named "Signal1"
    --       of type std_logic with default value '0'
    signal signal1 : std_logic := '0';
    
  
    -- TODO: Declare a signal named "Signal2" of type std_logic
    signal signal2 : std_logic;
    -- TODO: Declare a signal named "Signal3" of type std_logic
    signal signal3 : std_logic;
      
begin

    process is
    begin
        
        wait for 10 ns;
        -- TODO: Invert the value of Signal1
        signal1 <= not signal1; 
    end process;

    -- Driver A
    process is
    begin

        -- TODO: Constantly drive 'Z' to Signal2 (drive means assign)
        signal2 <= 'Z';
        
        -- TODO: Constantly drive '0' to Signal3
        signal3 <= '0';
        wait;

    end process;

    -- Driver B
    process(signal1) is
    begin

        -- TODO: Drive 'Z' to both Signal2 and Signal3 if Signal1 is '0'
        --       Drive '1' to both Signal2 and Signal3 if Signal1 is not '0'
        if signal1 = '0' then 
           signal2 <= 'Z'; 
           signal3 <= 'Z'; 
        else 
           signal2 <= '1'; 
           signal3 <= '1'; 
        end if;
        --       Inspect the signals in the waveform and verify that the
        --       values are according to the resolution table.
        --       The resolution table is found here:
        --       https://vhdlwhiz.com/std_logic/
    
    end process;

end architecture;