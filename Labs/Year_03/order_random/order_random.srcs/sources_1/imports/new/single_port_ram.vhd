-- single_port_RAM.vhd

-- created by   :   Meher Krishna Patel
-- date         :   26-Dec-16

-- Functionality:
  -- store and retrieve data from single port RAM
 
  -- https://www.youtube.com/watch?v=oCh9VVG4_pE
  -- When write enable goes high the data in is written to
  -- the array postion pointed to by the address.
  -- This can then be read and placed in the data out 
  -- Read before write/ write before read

-- ports:
    -- we   : write enable
    -- addr : input port for getting address
    -- din : input data to be stored in RAM
    -- data : output data read from RAM
    -- addr_width : total number of elements to store (put exact number)
    -- addr_bits  : bits requires to store elements specified by addr_width
    -- data_width : number of bits in each elements


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity single_port_ram is
    generic(
        addr_width : integer;
        data_width : integer 
    );
    Port ( 
        clk: in std_logic;
        we : in std_logic;
        addr : in std_logic_vector(addr_width-1 downto 0);
        din : in std_logic_vector(data_width-1 downto 0);
        dout : out std_logic_vector(data_width-1 downto 0)
    );
end single_port_ram;

architecture Behavioral of single_port_ram is
 
    -- Create a 1x3 array that accepts verctors of size 3 
    type ram_type is array (2**addr_width-1 downto 0) of std_logic_vector (data_width-1 downto 0);
    signal ram_single_port : ram_type; -- Instance of a ram block 
 
begin
  process(clk)
  begin 
    -- Only trigger on the rising edge clock 
    if (clk'event and clk='1') then
      if (we ='1') then 
        -- Convert 'addr' type to integer from std_logic_vector
        -- Select the address that needs writing to
        -- Allows use of intergers in test bench..??
        ram_single_port(to_integer(unsigned(addr))) <= din; -- Write data to address 'addr' vector of size 2
      end if;
  end if;
  end process;

  -- read data from address 'addr'
  -- convert 'addr' type to integer from std_logic_vector
  -- Expects a vector of size 3 
  -- Address is a vector 
  -- Change to integer to select the address location 
  -- dout outputs the value at the address which is a vector 
  dout <= ram_single_port(to_integer(unsigned(addr)));


end Behavioral;
