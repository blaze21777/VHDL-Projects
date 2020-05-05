library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use std.env.finish;
use std.textio.all;

entity random_gen_tb is
end random_gen_tb;

architecture sim of random_gen_tb is

begin

  process

  variable seed1, seed2 : integer := 999;
  variable l : line;
  subtype for_range is integer range 1 to 10;

  -- Generate random real within the min-max range
  impure function rand_real(min_val, max_val : real) return real is
    variable r : real;
  begin
    uniform(seed1, seed2, r);
    return r * (max_val - min_val) + min_val;
  end function;

  -- Generate random integer within the min-max range
  impure function rand_int(min_val, max_val : integer) return integer is
    variable r : real;
  begin
    uniform(seed1, seed2, r);
    return integer(round(r * real(max_val - min_val + 1) + real(min_val) - 0.5));
  end function;

  -- Generate random std_logic_vector with length len
--  impure function rand_slv(len : integer) return std_logic_vector is
--    variable r : real;
--    variable slv : std_logic_vector(len - 1 downto 0);
--  begin
--    for i in slv'range loop
--      uniform(seed1, seed2, r);
--      slv(i) := '1' when r > 0.5 else '0';
--    end loop;
--    return slv;
--  end function;

  -- Generate random time within the min-max range
  -- The unit should be set to the simulator resolution
  impure function rand_time(min_val, max_val : time; unit : time := ns) return time is
    variable r, r_scaled, min_real, max_real : real;
  begin
    uniform(seed1, seed2, r);
    min_real := real(min_val / unit);
    max_real := real(max_val / unit);
    r_scaled := r * (max_real - min_real) + min_real;
    return real(r_scaled) * unit;
  end function;

  begin

    -- Generate random real in the range -9.0 to 9.0
    for i in for_range loop
      write(l, rand_real(-9.0, 9.0));
      writeline(output, l);
    end loop;

    -- Generate random int in the range -9 to 9
    for i in for_range loop
      write(l, rand_int(-9, 9));
      writeline(output, l);
    end loop;

    -- Generate random std_logic_vector with length 16
--    for i in for_range loop
--      write(l, rand_slv(16));
--      writeline(output, l);
--    end loop;

    -- Generate random time in the range 500 ns to 1 us
    for i in for_range loop
      write(l, rand_time(500 ns, 1 us));
      writeline(output, l);
    end loop;
    
    wait;

  end process;

end architecture;