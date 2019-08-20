----------------------------------------------------------------------------------
-- Module Name: fsm_counter - Behavioral
-- Project Name: Loughborough University - 18WSB020 Introduction to FPGA Design
-- Target Devices: ZedBoard - Zynq 7000 (xc7z020clg484pkg)
-- Tool Versions: Vivado 2016.4
-- Description: Simple finite state machine counter RTL description. Inputs are
-- board clock, button that acts as reset, and switches and leds
--
-- Dependencies: None
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
-- use ieee.numeric_std.all;

-- uncomment the following library declaration if instantiating
-- any xilinx primitives in this code.
-- library unisim;
-- use unisim.vcomponents.all;

entity fsm_counter is
        port ( GCLK : in STD_LOGIC;
               BTNC : in STD_LOGIC; -- button reset
               BTNL : in STD_LOGIC;
               SW0  : in STD_LOGIC;
               LD0 : out STD_LOGIC;
               LD1 : out STD_LOGIC;
               LD2 : out STD_LOGIC;
               LD3 : out STD_LOGIC;
               LD4 : out STD_LOGIC
       );
end fsm_counter;

architecture behavioral of fsm_counter is

        type t_state is (s0, s1, s2);
        signal state, next_state : t_state;
        signal breg              : std_logic;
        signal done              : std_logic;
        signal count_reg         : std_logic_vector (4 downto 0);
        signal count             : std_logic;
        signal rst_counter       : std_logic;
        signal leds              : std_logic_vector (4 downto 0);

begin

        ( LD0, LD1, LD2, LD3, LD4 ) <= count_reg;

        -- input reg
        process (GCLK)
        begin
                if GCLK' event and GCLK = '1' then
                        breg <= SW0;
                end if;
        end process;

        -- fsm reg, update the actual state with the next state
        process (GCLK, BTNC)
        begin
                if BTNC = '1' then
                        state <= s0;
                elsif GCLK' event and GCLK = '1' then
                        state <= next_state;
                end if;
        end process;

        -- fsm main process, set next state and output(s)
        -- this is moore FSM as the output depends on
        -- the current state)
        process(breg, done, state)
        begin
                case state is
                        -- reset state, reset counter and it does not increment
                        -- the counter
                        when s0 =>
                                count <= '0';
                                rst_counter <='1';
                                if breg = '0' then
                                        next_state <= s0;
                                else
                                        next_state <= s1;
                                end if;

                        -- increment the counter, and keep its value (i.e., do not
                        -- reset)
                        when s1 =>
                                count <= '1';
                                rst_counter <= '0';
                                if (done = '1' and breg = '1') then
                                        next_state <= s2;
                                elsif (done = '1' and breg = '0') then
                                        next_state <= s0;
                                else
                                        next_state <= s1;
                                end if;

                        -- do not increment the counter, and keep its value (i.e.,
                        -- do not reset) this is the end state
                        when s2 =>
                                count <= '0';
                                rst_counter <= '0';
                                if breg = '0' then
                                        next_state <= s0;
                                else
                                        next_state <= s2;
                                end if;

                end case;
        end process;

        -- counter logic, increment register if count == '1'
        process (GCLK, rst_counter)
        begin
                if rst_counter = '1' then
                        count_reg <= (others=>'0');
                elsif GCLK' event and GCLK = '1' then
                        if count = '1' then
                                count_reg <= count_reg + 1;
                        end if;
                end if;
        end process;

        -- assign done signal, i.e., count up to 20 then stop
        done <= '1' when count_reg = "10100" else '0';

end behavioral;
