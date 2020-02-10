----------------------------------------------------------------------------------
-- Design Name:
-- Module Name: tb_blinking_led - Behavioral
-- Project Name: Loughborough University - 18WSC054 – Electronic System Design with FPGAs
-- Target Devices: ZedBoard - Zynq 7000 (xc7z020clg484pkg)
-- Tool Versions: Vivado 2016.4
-- Description: Simple test bench to stimuli the blinking_led module
--
-- Dependencies: blinking_led.vhd
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_blinking_led is
        --  Port ( );
        end tb_blinking_led;

architecture Behavioral of tb_blinking_led is

        component blinking_led
                Port ( GCLK : in STD_LOGIC;
                       BTNC : in STD_LOGIC;
                       SW0  : in STD_LOGIC;
                       SW1  : in STD_LOGIC;
                       SW2  : in STD_LOGIC;
                       SW3  : in STD_LOGIC;
                       SW4  : in STD_LOGIC;
                       SW5  : in STD_LOGIC;
                       SW6  : in STD_LOGIC;
                       SW7  : in STD_LOGIC;
                       LD0 : out STD_LOGIC;
                       LD1 : out STD_LOGIC;
                       LD2 : out STD_LOGIC;
                       LD3 : out STD_LOGIC;
                       LD4 : out STD_LOGIC;
                       LD5 : out STD_LOGIC;
                       LD6 : out STD_LOGIC;
                       LD7 : out STD_LOGIC
        );
        end component;


        --Inputs
        signal GCLK : STD_LOGIC;
        signal BTNC : STD_LOGIC;
        signal SW0  : STD_LOGIC;
        signal SW1  : STD_LOGIC;
        signal SW2  : STD_LOGIC;
        signal SW3  : STD_LOGIC;
        signal SW4  : STD_LOGIC;
        signal SW5  : STD_LOGIC;
        signal SW6  : STD_LOGIC;
        signal SW7  : STD_LOGIC;

        --Outputs
        signal LD0 : STD_LOGIC;
        signal LD1 : STD_LOGIC;
        signal LD2 : STD_LOGIC;
        signal LD3 : STD_LOGIC;
        signal LD4 : STD_LOGIC;
        signal LD5 : STD_LOGIC;
        signal LD6 : STD_LOGIC;
        signal LD7 : STD_LOGIC;

        -- Clock period definition
        constant clk_period : time := 10 ns;

        signal sw  : STD_LOGIC_VECTOR(7 downto 0);

begin

        ( SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7 ) <= sw;

        utt : blinking_led Port map (
                                            GCLK => GCLK,
                                            BTNC => BTNC,
                                            SW0  => SW0,
                                            SW1  => SW1,
                                            SW2  => SW2,
                                            SW3  => SW3,
                                            SW4  => SW4,
                                            SW5  => SW5,
                                            SW6  => SW6,
                                            SW7  => SW7,
                                            LD0 => LD0,
                                            LD1 => LD1,
                                            LD2 => LD2,
                                            LD3 => LD3,
                                            LD4 => LD4,
                                            LD5 => LD5,
                                            LD6 => LD6,
                                            LD7 => LD7
                                    );

        clk_process : process
        begin
                GCLK <= '0';
                wait for clk_period/2;
                GCLK <= '1';
                wait for clk_period/2;
        end process;

        -- Stimulus process
        stim_proc : process
        begin
                wait for 100 ns;
                -- hold reset state for 100 ns.
                BTNC <= '1';
                wait for 10 * clk_period;
                BTNC <= '0';
                for i in 0 to 255 loop
                        sw <= std_logic_vector(to_unsigned(i, sw'length));
                        wait for clk_period;
                end loop;
        end process;

end Behavioral;
