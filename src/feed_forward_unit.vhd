----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2018 06:44:53 PM
-- Design Name: 
-- Module Name: feed_forward_unit - Structural
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.custom_type.all;

-- implements output = activation(dot(weights, input) + bias)
entity feed_forward_unit is
    
    generic(
        -- matrix M lines x N columns
        unit_num  : positive; -- M 
        input_dim : positive  -- N

    );
    
    port ( 
        input       : in  WORD_ARRAY(0 to input_dim-1); 
        weights     : in  WORD_MAT(0 to unit_num-1, 0 to input_dim-1);
        bias        : in  WORD_ARRAY(0 to unit_num-1);
        a           : out WORD_ARRAY(0 to unit_num-1)
    );
    
end feed_forward_unit;
    

architecture Structural of feed_forward_unit is
    
    signal dot_out  :  WORD_ARRAY(0 to unit_num-1);
    signal Z        :  WORD_ARRAY(0 to unit_num-1);

begin

    
    
    mat_mult    : entity work.mat_mult(Structural)
               
               generic map(
                           M => unit_num,
                           N => input_dim
               )
               
               port map( 
                         Aprev => input,
                         W => weights,
                         Z => dot_out
               );
    
    
    addN        : entity work.fixed_addN(Structural)
                   -- N : number of parallel additions
                  generic map(
                       N => unit_num
                  )
                  port map ( 
                      X => dot_out,
                      Y => bias,
                      O => Z
                  );   
                  
  
   
    sig_loop:  for i in 0 to Z'length-1 generate    

        sig     : entity work.sig(Behavioral)
               
               port map( 
                   X => Z(i),
                   O => a(i)
               );
               
    end generate; 




end Structural;
