----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2018 05:19:39 PM
-- Design Name: 
-- Module Name: dot_product - Behavioral
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




entity dot_product is
    -- N : size of vector 
    generic(
        N : positive := 784
        );
    Port ( 
        X : in WORD_ARRAY(N-1 downto 0);
        Y : in WORD_ARRAY(N-1 downto 0);
        O : out std_logic_vector(WORD_SIZE-1 downto 0)  
    );
    
end dot_product;

architecture Structural of dot_product is
    
    signal T : WORD_ARRAY(N-1 downto 0);

begin
    
    mult_loop : for i in 0 to X'length-1 generate    
        
        fixed_mult : entity work.fixed_mult(Behavioral)
                
                generic map(
                    -- fractionary part
                    Q => 12
                )
                
                port map( 
                    X => X(i),
                    Y => Y(i),
                    O => T(i)
                );
                
    end generate; 
    
    fixed_sumN : entity work.fixed_sumN(Behavioral)
            
            generic map(
                N => N
            )
            
            port map( 
                X => T,
                O => O
            );
     
end Structural;