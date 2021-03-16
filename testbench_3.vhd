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

entity testbench_3 is
--  Port ( );
end testbench_3;

architecture Behavioral of testbench_3 is

component divider is -- q : m = q rest a
    generic (size : natural := 8);
    Port ( q_divident : in STD_LOGIC_VECTOR (size - 1 downto 0);
           m_divisor : in STD_LOGIC_VECTOR (size - 1 downto 0);
           a_reminder : out STD_LOGIC_VECTOR (size - 1 downto 0);
           q_quotient : out STD_LOGIC_VECTOR (size - 1 downto 0)
     );
end component;

constant n : natural := 8;
signal q, m, a, q_quotient : STD_LOGIC_VECTOR (7 downto 0);

begin
    uut: divider generic map (n)
        port map (
            q, m, a, q_quotient
        );
    
    sim_proc : process
    begin
        q <= x"64"; -- 100 
        m <= x"0c"; -- 12
        wait for 10 ns; -- 8 r 4, namely x08 rest x04
        
        q <= x"9c"; -- -100 
        m <= x"0c"; -- 12
        wait for 10 ns;  
        
        q <= x"64"; -- 100
        m <= x"f4"; -- -12
        wait for 10 ns; 
        
        q <= x"9c"; -- 100
        m <= x"f4"; -- 12
        wait for 10 ns; 
        
    end process;

end Behavioral;
