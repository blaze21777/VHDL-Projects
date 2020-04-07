----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2020 13:03:03
-- Design Name: 
-- Module Name: single_port_ram_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
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

entity single_port_ram_tb is
--  Port ( );
end single_port_ram_tb;

architecture Behavioral of single_port_ram_tb is

    constant addr_width : integer := 2;
    constant data_width : integer := 3;
    signal clk: std_logic;
    signal clk_period : time := 10ns;
    signal we : std_logic;
    signal addr : std_logic_vector(addr_width-1 downto 0);
    signal din : std_logic_vector(data_width-1 downto 0);
    signal dout : std_logic_vector(data_width-1 downto 0);

begin

ram : entity work.single_port_ram(Behavioral)
        generic map(
        addr_width => addr_width,
        data_width => data_width
        )
		port map(
		clk  => clk,	
        we => we,
        addr => addr,
        din => din,
        dout => dout
        );

    -- Clock process 
    clk_proc : process is 
begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

    -- Testbench process
    process
    begin
    we <= '1';
    wait for 10 ns;
    addr <= "01";
    din <= "001";
    end process;
            
end Behavioral;
