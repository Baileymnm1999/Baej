----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:13:55 01/29/2019 
-- Design Name: 
-- Module Name:    reg_16_bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_16_bit is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           write : in  STD_LOGIC;
           read : in  STD_LOGIC;
           B : out  STD_LOGIC_VECTOR (15 downto 0));
end reg_16_bit;

architecture Behavioral of reg_16_bit is

begin


end Behavioral;

