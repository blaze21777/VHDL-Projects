entity T03_LoopTb is
end entity;

architecture sim of T03_LoopTb is
begin

    process is
    begin
    
        report "Hello!";

        -- TODO: Create loop.
        --       Then, exit the loop.
        loop
            report "I am inside the loop";
            wait for 100ns;
            exit;  -- Escape the loop 
        end loop;
            
        report "Goodbye!";
        wait;
        
    end process;

end architecture;