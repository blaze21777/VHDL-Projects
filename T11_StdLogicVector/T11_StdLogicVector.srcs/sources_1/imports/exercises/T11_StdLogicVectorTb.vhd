library ieee;
use ieee.std_logic_1164.all;

entity T11_StdLogicVectorTb is
end entity;

architecture sim of T11_StdLogicVectorTb is

    -- TODO: Declare the following 8-bit std_logic_vectors:
    --       
    --       - downto, no initial value
    signal slv1 : std_logic_vector(7 downto 0);
    --       - downto, initial value of all zeros using aggregate assignment
    signal slv2 : std_logic_vector(7 downto 0) := (others => '0');
    --       - downto, initial value of all ones using aggregate assignment
     signal slv3 : std_logic_vector(7 downto 0) := (others => '1');
    --       - downto, initial value: hex AA
     signal slv4 : std_logic_vector(7 downto 0) := x"AA";
    --       - to, inital value: binary 10101010
     signal slv5 : std_logic_vector(0 to 7) := "10101010";
    --       - downto, initial value: 1
     signal slv6 : std_logic_vector(7 downto 0) := "00000001";

begin

    -- Shift register
    process is
    begin

        wait for 10 ns;
        
        -- TODO: Create a looping shift register here which operates
        --       on the vector which has an inital value of 1.
        --     
        --       The shift register shall perform a barrel shift of
        --       all the bits every 10 nanoseconds.
        --
        --       First, use hard-coded bit indexes.
        --       Verified that it works in the waveform.
        --       Then, replace the hard coded values with the
        --       'left and 'right attributes.
        --       Verify that it still works.
        
        -- left and right ensure it works with any vector size
          for i in slv6'left downto slv6'right + 1 loop
            slv6(i) <= slv6(i-1);
          end loop;
          
        -- Right bit gets assigned MSB to prevent loss
          slv6(slv6'right) <= slv6(slv6'left);
    end process;

end architecture;