----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.08.2019 19:04:41
-- Design Name: 
-- Module Name: fsm_counter_tb - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_counter_tb is
	--  Port ( );
end fsm_counter_tb;

architecture Behavioral of fsm_counter_tb is
	-- Inputs
	signal GCLK : STD_LOGIC := '0';
	signal BTNC : STD_LOGIC := '0';-- button reset
	signal BTNL : STD_LOGIC := '0';
	signal SW0  : STD_LOGIC := '0'; -- breg 
	
	-- Outputs
	signal LD0  : STD_LOGIC;
	signal LD1  : STD_LOGIC;
	signal LD2  : STD_LOGIC;
	signal LD3  : STD_LOGIC;
	signal LD4  : STD_LOGIC;
	
	-- Clock signals
	constant clk_period : time := 10ns;
	
begin
	UUT : entity work.fsm_counter
		port map (
			GCLK => GCLK,
			BTNC => BTNC,
			BTNL => BTNL,
			SW0  => SW0,
			LD0  => LD0,
			LD1  => LD1,
			LD2  => LD2,
			LD3  => LD3,
			LD4  => LD4
		);
		
	-- Clock process
	clk_proc : process is
	begin
		GCLK <= '1';
		wait for clk_period/2;
		GCLK <= '0';
		wait for clk_period/2;
	end process;	
	
	-- Stimulus process	
	stim_proc : process is 
	begin
	wait for 100 ns;
                BTNC <= '1';
                wait for clk_period;
                BTNC <= '0';
                SW0  <= '0';
                wait for clk_period*10;
                SW0  <= '1';  -- press the button 
                wait for clk_period*1;
                SW0  <= '0';  -- release the button
                wait for clk_period*30;
                SW0  <= '1';  -- press the button
                wait for clk_period*5;
                SW0  <= '0';  -- release the button
                wait for clk_period*42;
                SW0  <= '1';  -- press the button
                wait for clk_period*28;
                SW0  <= '0';  -- release the button
                wait for clk_period*10;
                SW0  <= '1';  -- press the button
                wait for clk_period*1;
                SW0  <= '0';  -- release the button
                wait;
	end process;
end Behavioral;
