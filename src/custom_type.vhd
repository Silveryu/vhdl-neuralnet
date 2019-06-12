library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package custom_type is
      
       constant WORD_SIZE : positive := 16;
       
       constant SAT_POS : signed(WORD_SIZE-1 downto 0) := X"7FFF";
       constant SAT_NEG : signed(WORD_SIZE-1 downto 0) := X"8000"; 
       
       type WORD_ARRAY is array (natural range <>) of std_logic_vector (WORD_SIZE-1 downto 0);
       
       type WORD_MAT is array(natural range <>, natural range <>) of  std_logic_vector (WORD_SIZE-1 downto 0);


end custom_type;
