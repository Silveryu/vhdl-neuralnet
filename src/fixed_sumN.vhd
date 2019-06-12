----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2018 10:12:21 PM
-- Design Name: 
-- Module Name: fixed_addN - Structural
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


entity fixed_sumN is
    -- N : number of parallel additions
    generic(N : positive);
    port( 
        X : in WORD_ARRAY(N-1 downto 0);
        O : out std_logic_vector(WORD_SIZE-1 downto 0)
    );
end fixed_sumN;

architecture Behavioral of fixed_sumN is

    signal s_acc : signed(WORD_SIZE-1 downto 0) := X"0000";

    
    constant SAT_POS : signed(WORD_SIZE-1 downto 0) := X"7FFF";
    constant SAT_NEG : signed(WORD_SIZE-1 downto 0) := X"8000";

begin
    
    process(X)
        variable v_acc : signed(WORD_SIZE-1 downto 0);
        variable tmp : signed(2*WORD_SIZE-1 downto 0);
    begin
        v_acc := X"0000";
        for  i in 0 to X'length-1 loop
            
            tmp :=  resize(v_acc + signed(X(i)),tmp'length);
          
            if(tmp > SAT_POS) then 
                v_acc := SAT_POS;
            elsif(tmp < SAT_NEG) then
                v_acc := SAT_NEG;
            else
                v_acc :=  tmp(WORD_SIZE-1 downto 0);
            end if;
            
        end loop;
        s_acc <= v_acc;
        
    end process;
    
    O <= std_logic_vector(s_acc);


end Behavioral;
