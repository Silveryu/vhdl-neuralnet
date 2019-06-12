----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2018 06:11:07 PM
-- Design Name: 
-- Module Name: sig_tb - Stimulus
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

entity sig_tb is
end sig_tb;

architecture Stimulus of sig_tb is


    constant TIME_DELTA: time := 10 ns; -- clock wait time in ns
    
    signal X_val : std_logic_vector(WORD_SIZE-1 downto 0);

    signal O_val : std_logic_vector(WORD_SIZE-1 downto 0);

begin
    
    
   process
   begin
        X_val <= X"5000"; wait for TIME_DELTA; -- res : X"0001" 
        X_val <= X"2800"; wait for TIME_DELTA; -- res : X"0ec0"
        X_val <= X"1800"; wait for TIME_DELTA; -- res : X"00d0"
        X_val <= X"0000"; wait for TIME_DELTA; -- res : X"0000"
        X_val <= X"AF3D"; wait for TIME_DELTA; -- res : X"0000"
        X_val <= X"A000"; wait for TIME_DELTA; -- res : X"0000"
  
   end process;
    
    
    uut: entity work.sig(Behavioral)
        
        port map( 
                  X => X_val,
                  O => O_val
        );


end Stimulus;
