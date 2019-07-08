library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T17_FlipFlop is
port(
    -- TODO: Complete the port of a flip flop.
    --       
    --       The inputs of type std_logic shall be:
    --          Clk (clock)
    --          nRst (negative reset)
    --          Input
    --
    --       The output of type std_logic shall be: Output
    Clk    : in std_logic;
    nRst   : in std_logic;  -- Resets when zero
    Input  : in std_logic;
    Output : out std_logic
);
end entity;

architecture rtl of T17_FlipFlop is
begin

    -- Flip-flop with synchronized reset
    -- TODO: Implement a Flip-flop in a clocked process here.
    --       Use negative synchronous reset.
    process(Clk) is
    begin
        if rising_edge(Clk) then 
            if nRst = '0' then 
                Output <= '0';
            else
                Output <= Input;
            end if;
        end if;
    end process;
end architecture;