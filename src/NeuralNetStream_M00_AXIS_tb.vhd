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

library work;
use work.custom_type.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NeuralNetStream_M00_AXIS_tb is
end NeuralNetStream_M00_AXIS_tb;

architecture Stimulus of NeuralNetStream_M00_AXIS_tb is
  
  constant TIME_DELTA: time := 10 ns; -- clock wait time in ns
  
  signal s_clk : std_logic;
  
  signal outputUnit : WORD_ARRAY(0 to 10-1) :=  ( X"000A",X"0009",X"0008",X"0007", X"0006", X"0005", X"0004", X"0003", X"0002", X"0001");

  signal s_validData : std_logic;
  signal s_readEnable : std_logic;
  
  signal s_valid  : std_logic;
  signal s_tdata  : std_logic_vector(31 downto 0);
  signal s_tstrb  : std_logic_vector(3 downto 0);
  signal s_tlast  : std_logic;
  signal s_tready : std_logic;
  
begin
 
  --s_clk is prob fine
  aclk_process : process
  begin
      s_clk <= '1';wait for TIME_DELTA;
      s_clk <= '0';wait for TIME_DELTA;
  end process;
  
  process
    begin
        s_validData <= '1';wait for 5*TIME_DELTA;
        s_validData <= '0';wait for TIME_DELTA;
   end process;
  
  s_tready <= '1';
  
  uut: entity work.NeuralNetStream_v1_0_M00_AXIS(implementation)
          generic map(
              input_dim => 784,
              final_unit_num => 10
          )
          port map( 
                  -- Ports of Axi Master Bus Interface M00_AXIS
                  validData       => s_validData, --in
                  final_unitData  => outputUnit,           --in
                  readEnable      => s_readEnable,--out
                  
                  M_AXIS_ACLK       => s_clk,	--: in std_logic;
                  M_AXIS_ARESETN    => '0', --: in std_logic;
                  -- Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
                  M_AXIS_TVALID     =>  s_valid, --: out std_logic;
                  -- TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
                  M_AXIS_TDATA      => s_tdata, --: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
                  -- TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
                  M_AXIS_TSTRB      => s_tstrb, -- : out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
                  -- TLAST indicates the boundary of a packet.
                  M_AXIS_TLAST      =>  s_tlast,  --: out std_logic;
                  -- TREADY indicates that the slave can accept a transfer in the current cycle.
                  M_AXIS_TREADY     => s_tready  --: in std_logic
          );


end Stimulus;