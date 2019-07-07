entity T06_SignalTb is
end entity;

architecture sim of T06_SignalTb is
    -- region fro declaring things up until begin keyword
    -- TODO: Declare a signal of type integer with initial value 0
    signal my_signal : integer := 0;  -- Accessible by all processes 
begin

    process is
        -- TODO: Declare a variable of type integer with initial value 0
        variable my_variable : integer := 0;  -- Only this process has access
    begin

        report "*** Process begin ***";

        -- TODO: Increment the signal and variable here
        my_signal <= my_signal + 1;
        my_variable := my_variable + 1;
        
        -- TODO: Print the signal and variable values here
        report "my_variable = " & integer'image(my_variable) &
               ", my_signal = " & integer'image(my_signal);
               
        -- TODO: Increment the signal and variable here
         my_signal <= my_signal + 1;
         my_variable := my_variable + 1;
         
        -- TODO: Print the signal and variable values here
        report "my_variable = " & integer'image(my_variable) &
               ", my_signal = " & integer'image(my_signal);
        wait for 10 ns;

        -- TODO: Print the signal and variable values here
        report "my_variable = " & integer'image(my_variable) &
               ", my_signal = " & integer'image(my_signal);
    end process;

end architecture;