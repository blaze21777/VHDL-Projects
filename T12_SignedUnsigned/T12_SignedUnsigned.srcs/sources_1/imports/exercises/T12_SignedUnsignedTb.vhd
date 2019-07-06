library ieee;
use ieee.std_logic_1164.all;
-- TODO: Import the IEEE library for using signed and unsigned types
use ieee.numeric_std.all;

entity T12_SignedUnsignedTb is
end entity;

architecture sim of T12_SignedUnsignedTb is

    -- TODO: Declare the following signals:
    --       
    --       - 8-bit unsigned counter with an initial value of all zeros
    signal UnsCnt :  unsigned(7 downto 0) := (others => '0');
    --       - 8-bit signed counter with an initial value of all zeros
    signal SigCnt : signed(7 downto 0) := (others => '0');
    --       - 4-bit unsigned with an initial value of binary 1000
    signal Uns4 : unsigned(3 downto 0) := "1000";
    --       - 4-bit signed with an initial value of binary 1000
    signal Sig4 : signed(3 downto 0) := "1000";
    --       - 8-bit unsigned with an initial value of all zeros
    signal Uns8 : unsigned(7 downto 0) := (others => '0');
    --       - 8-bit signed with an initial value of all zeros
    signal Sig8 : signed(7 downto 0) := (others => '0');
    
begin

    process is
    begin
    
        wait for 10 ns;

        -- Wrapping counter
        
        -- TODO: Increment the signed and unsigned counters by 1
        UnsCnt <= UnsCnt + 1;
        SigCnt <= SigCnt + 1;
        -- Adding signals
        
        -- TODO: Increment the unsigned 8-bit signal with the value of the
        --       4-bit unsigned signal
        Uns8 <= Uns8 + Uns4;
        -- TODO: Increment the signed 8-bit signal with the value of the
        --       4-bit signed signal
        Sig8 <= Sig8 + sig4;

    end process;
    
end architecture;