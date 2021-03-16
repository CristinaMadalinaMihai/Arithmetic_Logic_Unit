----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2020 06:25:54 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
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

entity testbench_1 is
--  Port ( );
end testbench_1;

architecture Behavioral of testbench_1 is

component main is
    Port ( clk : in std_logic;
           data1 : in STD_LOGIC_VECTOR (7 downto 0);
           data2 : in STD_LOGIC_VECTOR (7 downto 0);
           operation : in STD_LOGIC_VECTOR (4 downto 0);
           res : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal clock : std_logic;
signal data_1, data_2 : std_logic_vector(7 downto 0);
signal op : std_logic_vector(4 downto 0);
signal result : std_logic_vector(15 downto 0);

begin
    uut : main port map (
        clock, data_1, data_2, op, result
    );
    
    clock_process : process 
    begin
        clock <= '1';
		wait for 10 ns;
		clock <= '0';
		wait for 10 ns;
    end process;
    
    simulation_process : process
    begin    
        wait for 20 ns; -- add
        data_1 <= x"55";
        data_2 <= x"33";
        op <= "00000";
        
        wait for 20 ns; -- subtract
        data_1 <= x"33";
        data_2 <= x"55";
        op <= "00001";
        
--        wait for 20 ns; -- ++
--        data_1 <= x"55";
--        data_2 <= x"03";
--        op <= "00010";
        
--        wait for 20 ns; -- ++
--        data_1 <= x"05";
--        data_2 <= x"80";
--        op <= "00011";
        
--        wait for 20 ns; -- --
--        data_1 <= x"55";
--        data_2 <= x"03";
--        op <= "00100";
        
--        wait for 20 ns; -- --
--        data_1 <= x"03";
--        data_2 <= x"80";
--        op <= "00101";
        
--        wait for 20 ns; -- and
--        data_1 <= x"80";
--        data_2 <= x"03";
--        op <= "00110";
        
--        wait for 20 ns; -- or
--        data_1 <= x"55";
--        data_2 <= x"33";
--        op <= "00111";
        
--        wait for 20 ns; -- not
--        data_1 <= x"05";
--        data_2 <= x"03";
--        op <= "01000";
        
--        wait for 20 ns; -- not
--        data_1 <= x"05";
--        data_2 <= x"03";
--        op <= "01001";
        
--        wait for 20 ns; -- negate
--        data_1 <= x"05";
--        data_2 <= x"03";
--        op <= "01010";
        
--        wait for 20 ns; -- negate
--        data_1 <= x"05";
--        data_2 <= x"03";
--        op <= "01011";
        
--        wait for 20 ns; -- rotate left 1
--        data_1 <= x"55";
--        data_2 <= x"03";
--        op <= "01100";
        
--        wait for 20 ns; -- rotate left 2
--        data_1 <= x"05";
--        data_2 <= x"33";
--        op <= "01101";
        
--        wait for 20 ns; -- rotate right 1
--        data_1 <= x"55";
--        data_2 <= x"03";
--        op <= "01110";
        
--        wait for 20 ns; -- rotate right 2
--        data_1 <= x"05";
--        data_2 <= x"33";
--        op <= "01111";
        
        wait for 20 ns; -- mul
        data_1 <= x"f0";
        data_2 <= x"80";
        op <= "10000";
        
        wait for 20 ns; -- div
        data_1 <= x"9c";
        data_2 <= x"0c";
        op <= "10001";
        
        
        wait for 20 ns; -- add
        data_1 <= x"55";
        data_2 <= x"33";
        op <= "00000";
        
        wait for 20 ns; -- subtract
        data_1 <= x"33";
        data_2 <= x"55";
        op <= "00001";
        
        wait for 20 ns; -- ++
        data_1 <= x"55";
        data_2 <= x"03";
        op <= "00010";
        
    end process;

end Behavioral;
