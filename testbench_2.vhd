----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2020 04:22:42 PM
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

entity testbench_2 is
--  Port ( );
end testbench_2;

architecture Behavioral of testbench_2 is

component multiplier is -- b * q = a
    generic (size : natural := 8);
    Port ( b_port : in STD_LOGIC_VECTOR (size - 1 downto 0);
           a_port : out STD_LOGIC_VECTOR (2 * size - 1 downto 0);
           q_multiplier : in STD_LOGIC_VECTOR (size - 1 downto 0)
    );
end component;

constant n : natural := 8;
signal a : STD_LOGIC_VECTOR (15 downto 0);
signal b, q : STD_LOGIC_VECTOR (7 downto 0);

begin
    uut: multiplier generic map (n)
        port map (
            b_port => b, 
            a_port => a,
            q_multiplier => q
        );
    
    sim_proc : process
    begin
        b <= x"09"; -- 9 
        q <= x"0c"; -- 12 
        wait for 10 ns; -- 108 (6c in hex)
        
        
        b <= x"0f"; -- 15 
        q <= x"04"; -- 4 
        wait for 10 ns; -- 60 (3c in hex)
        
        b <= x"05"; 
        q <= x"05"; 
        wait for 10 ns; 
        
        b <= x"f0"; 
        q <= x"80"; 
        wait for 10 ns; 
        
        
    end process;

end Behavioral;
