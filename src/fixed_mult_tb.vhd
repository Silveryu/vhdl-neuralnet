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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fixed_mult_tb is
end fixed_mult_tb;

architecture Stimulus of fixed_mult_tb is
    
    constant TIME_DELTA: time := 10 ns; -- clock wait time in ns
    
    signal s_clk : std_logic;
    signal s_out : std_logic_vector(15 downto 0);
    signal s_X : std_logic_vector(15 downto 0);
    signal s_Y : std_logic_vector(15 downto 0);

    
begin
    
   process
   begin
       s_X <= X"FFFF";s_Y <= X"FFFF"; wait for TIME_DELTA;
       s_X <= X"FFFF";s_Y <= X"0000"; wait for TIME_DELTA;
       s_X <= X"7FFF";s_Y <= X"1000"; wait for TIME_DELTA;
       s_X <= X"800F";s_Y <= X"800F"; wait for TIME_DELTA;
       s_X <= X"0080";s_Y <= X"0080"; wait for TIME_DELTA;
   end process;
    
    uut: entity work.fixed_mult(Behavioral)
            generic map(
                        Q => 12
            )
            
            port map( 
                      X => s_X,
                      Y => s_Y,
                      O => s_out
            );


end Stimulus;
