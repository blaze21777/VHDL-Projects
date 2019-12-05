----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2019 13:08:07
-- Design Name: 
-- Module Name: voicemail_controller - Behavioral
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
package happy_pack is
    type t_vm_state is (main_st, review_st, repeat_st
                        save_st, erase_st, send_st, 
                        address_St, record_st, begin_rec_st,
                        message_st);
    type t_key is ('0','1','2','3','4','5','6','7','8','9','*','#');
end package ;

use work.happy_pack.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity voicemail_controller is
  Port (clk : in std_logic;
        key : in t_key;
        play, recrd, erase, save, address : out std_logic);
end voicemail_controller;

architecture Behavioral of voicemail_controller is

begin
process(current_state, key) is
    begin
        play <= '0'; save <= '0'; erase <= '0'; recrd <= '0'; address <= '0';
    case(current_state) is 
    end case;
end process;


end Behavioral;
