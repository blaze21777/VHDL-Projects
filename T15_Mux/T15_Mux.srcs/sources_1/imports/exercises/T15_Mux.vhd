library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- TODO: Create an entity with a port declaration
--       
--       The entity name shall be T15_Mux
--
--       The port shall have 5 inputs of type unsigned:
--       Sig1, Sig2, Sig3, Sig4, and Sel
--       And one output of type unsigned: Output
entity T15_Mux is
    port( 
        -- Inputs
        Sig1, Sig2 ,Sig3 ,Sig4 : in unsigned(7 downto 0);
        Sel : in unsigned(1 downto 0);
        Output : out unsigned(7 downto 0)     
    );
end entity;

architecture rtl of T15_Mux is

begin

    -- TODO: Move the MUX process from T15_PortMap.vhd to here
    process(Sel, Sig1, Sig2, Sig3, Sig4) is
    begin

        case Sel is
            when "00" =>
                Output <= Sig1;
            when "01" =>
                Output <= Sig2;
            when "10" =>
                Output <= Sig3;
            when "11" =>
                Output <= Sig4;
            when others => -- 'U', 'X', '-', etc.
                Output <= (others => 'X');
        end case;

    end process;
    
end architecture;