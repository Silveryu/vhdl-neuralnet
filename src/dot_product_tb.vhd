----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2018 01:44:25 PM
-- Design Name: 
-- Module Name: fixed_mult_tb - Stimulus
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

entity dot_product_tb is
end dot_product_tb;

architecture Stimulus of dot_product_tb is
    
    constant TIME_DELTA: time := 10 ns; -- clock wait time in ns
    constant WORD_SIZE: natural := 16;
    
    signal s_clk : std_logic;
    signal s_out : std_logic_vector(WORD_SIZE-1 downto 0);
    
    signal X : WORD_ARRAY(2 downto 0) := (X"1000",X"0800",X"0400");
    signal Y : WORD_ARRAY(2 downto 0) := (X"2000",X"1000",X"0000");
            
begin
    
    uut: entity work.dot_product(Structural)
            generic map(
                    N => 3
            )
            
            port map( 
                      X => X,
                      Y => Y,
                      O => s_out
            );


end Stimulus;
