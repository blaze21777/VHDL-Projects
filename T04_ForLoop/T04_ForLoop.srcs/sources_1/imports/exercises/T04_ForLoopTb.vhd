entity T04_ForLoopTb is
end entity;

architecture sim of T04_ForLoopTb is
begin

    process is
    begin

        -- TASK: Create For-loop here.
        --       Print the value of the implicit variable inside of the loop
        for i in 1 to 10 loop  -- i for integer 
             report "i = " & integer'image(i);  -- Convert i interger to string 
                                                -- & is concatenation
        end loop;
        wait;

    end process;

end architecture;