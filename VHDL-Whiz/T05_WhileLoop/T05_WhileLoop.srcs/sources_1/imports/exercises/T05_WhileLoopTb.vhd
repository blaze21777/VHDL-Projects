entity T05_WhileLoopTb is
end entity;

architecture sim of T05_WhileLoopTb is
begin
    
    process is
        -- TODO: Declare a variable here of type integer
        --       with an initial value of 0.
        variable i : integer := 0;
    begin

        -- TODO: Create a While-loop which which has a condition that
        --       tests if the variable is less than 10.
        --       Increment the variable by 2 inside of the loop.
        while i < 10 loop 
            report "i = " & integer'image(i);  -- Convert integer into string
            i := i + 2;  -- For loops do not all steps of 2
        end loop;
        wait;

    end process;

end architecture;