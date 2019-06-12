----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2018 04:42:23 PM
-- Design Name: 
-- Module Name: sig - Behavioral
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


-- uses PLAN approximation found in "Efficient digital implementation of the sigmoid
--function for reprogrammable logic" paper
entity sig is
    port ( 
        X : in  std_logic_vector(WORD_SIZE-1 downto 0);
        O : out std_logic_vector(WORD_SIZE-1 downto 0)
    );
end sig;

architecture Behavioral of sig is

    signal X_abs  : signed(WORD_SIZE downto 0);
    
    signal X_sat  : signed(WORD_SIZE-1 downto 0);
    signal X_mult : signed(WORD_SIZE-1 downto 0) := X"1000";
    signal X_add  : signed(WORD_SIZE-1 downto 0) := X"0000";
    
    signal X_mult_out : std_logic_vector(WORD_SIZE-1 downto 0);
    signal X_add_out  : std_logic_vector(WORD_SIZE-1 downto 0);
    
    signal X_neg : std_logic;
    
    signal X_inv        : signed(WORD_SIZE-1 downto 0);
    signal X_inv_out    : std_logic_vector(WORD_SIZE-1 downto 0);





    
    
begin


    X_abs <= signed(resize(unsigned(abs(signed(X))), X_abs'length));
    
    X_sat  <=  X"7FFF" when X_abs > '0' & X"7FFF" else
                signed(X_abs(WORD_SIZE-1 downto 0));
    
    process (X_sat) is
    begin
        -- if abs(X) > = 5 : y = 1
        if (X_sat >= X"5000") then
        
            X_mult <= X"0000";
            X_add  <= X"1000";
        
        -- if 2.375 <= abs(X) < 5 : y = 0.03125*abs(X) + 0.84375
        elsif (X_sat >= X"2600" and X_sat < X"5000" ) then
            
            X_mult <= X"0080";
            X_add <= X"0D80";  
        
        -- if 1 <= abs(X) < 2.375 : y = 0.125*abs(X) + 0.625
        elsif(X_sat >= X"1000" and X_sat < X"2600") then
             
            X_mult <= X"0200";
            X_add <= X"0A00";  
        
        else
         
            X_mult <= X"0400";
            X_add <= X"0800";
        
        end if;
        
    end process;
    
    
        
    fixed_mult: entity work.fixed_mult(Behavioral)
        
        port map( 
                  X => std_logic_vector(X_sat),
                  Y => std_logic_vector(X_mult),
                  O => X_mult_out
        );
    
    
    
    fixed_add: entity work.fixed_add(Behavioral)
        
        port map( 
                  X => X_mult_out,
                  Y => std_logic_vector(X_add),
                  O => X_add_out
        );
        
        
        
    X_inv  <= -signed(X_add_out);
    
    -- if X < 0 : y = 1-y
    fixed_addInv: entity work.fixed_add(Behavioral)
                
                port map( 
                          X => X"1000",
                          Y => std_logic_vector(X_inv),
                          O => X_inv_out
                );
    
    O <= X_inv_out when X < X"0000" else X_add_out;
    
        
        
        



end Behavioral;
