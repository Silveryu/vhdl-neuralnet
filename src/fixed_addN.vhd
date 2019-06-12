----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2018 03:53:29 PM
-- Design Name: 
-- Module Name: fixed_addN - Behavioral
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

library work;
use work.custom_type.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fixed_addN is
    -- N : number of parallel additions
   generic(
        N : positive := 50
   );
   port( 
       X : in  WORD_ARRAY(N-1 downto 0);
       Y : in  WORD_ARRAY(N-1 downto 0);
       O : out WORD_ARRAY(N-1 downto 0)
   );
end fixed_addN;

architecture Structural of fixed_addN is

begin
    
    add_loop : for i in 0 to X'length-1 generate    

        fixed_addN : entity work.fixed_add(Behavioral)
                
                port map( 
                    X => X(i),
                    Y => Y(i),
                    O => O(i)
                );
    end generate; 



end Structural;
