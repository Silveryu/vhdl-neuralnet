library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.custom_type.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- actually matrix by vector mult but don't tell anyone ;)
entity mat_mult is
    
    generic(
        -- matrix M lines x N columns
        M : positive := 50;
        N : positive := 784
    );
    
    port ( 
        Aprev : in WORD_ARRAY(0 to N-1); 
        W : in WORD_MAT(0 to M-1, 0 to N-1);
        Z : out WORD_ARRAY(0 to M-1)
    );
    
end mat_mult;

architecture Structural of mat_mult is
    
begin


    mult_loop : for i in 0 to M-1 generate
        
        signal W_row : WORD_ARRAY(0 to N-1);
    
    begin


        unroll_row : for j in 0 to N-1 generate
            W_row(j) <= W(i,j);
        end generate;
        
         
        fixed_mult : entity work.dot_product(Structural)
                
                generic map(
                    N => N
                )
                
                port map( 
                    X => Aprev,
                    Y => W_row,
                    O => Z(i)
                );
            
    end generate;
    
end Structural;
