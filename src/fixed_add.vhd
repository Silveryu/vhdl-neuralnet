----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2018 02:37:39 PM
-- Design Name: 
-- Module Name: fixed_add - Behavioral
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

library work;
use work.custom_type.all;

entity fixed_add is
    -- assume a bit length of 16
    port (
        X : in std_logic_vector(WORD_SIZE-1 downto 0);
        Y : in std_logic_vector(WORD_SIZE-1 downto 0);
        O : out std_logic_vector(WORD_SIZE-1 downto 0)
     );
end fixed_add;

architecture Behavioral of fixed_add is
    
    
    signal tmp : signed(2*WORD_SIZE-1 downto 0);
    signal res : signed(WORD_SIZE-1 downto 0);
        
begin
    
    tmp <=  resize(signed(X) + signed(Y),tmp'length);
    
     O <=   std_logic_vector(SAT_POS) when tmp > SAT_POS else
            std_logic_vector(SAT_NEG) when tmp < SAT_NEG else
            std_logic_vector(tmp(WORD_SIZE-1 downto 0));

end Behavioral;
