----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2020 05:52:35 PM
-- Design Name: 
-- Module Name: divider - Behavioral
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
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider is -- q : m = q rest a
    generic (size : natural := 8);
    Port ( q_divident : in STD_LOGIC_VECTOR (size - 1 downto 0);
           m_divisor : in STD_LOGIC_VECTOR (size - 1 downto 0);
           a_reminder : out STD_LOGIC_VECTOR (size - 1 downto 0);
           q_quotient : out STD_LOGIC_VECTOR (size - 1 downto 0)
     );
end divider;

architecture Behavioral of divider is

begin
    
    process(q_divident, m_divisor)
        variable q, m, a, initial_a : std_logic_vector (size - 1 downto 0);
        variable n : natural := size;
        variable aq : std_logic_vector (2 * size - 1 downto 0);
    begin
        a := (others => '0');
        if m_divisor(n - 1) = '1' then
            m := (not m_divisor) + '1';
        else
            m := m_divisor;
        end if;
        if q_divident(n - 1) = '1' then
            q := (not q_divident) + '1';
        else
            q := q_divident;
        end if;
        
        for i in 0 to (n - 1) loop
            aq := a & q;
            aq := aq (2 * n - 2 downto 0) & '0';
            initial_a := aq(2 * n - 1 downto n);
            q := aq(n - 1 downto 0);
            a := initial_a - m;
            if a(n - 1) = '1' then
                a := initial_a;
            else
                q(0) := '1';
            end if;
        end loop;
        a_reminder <= a;
        if (m_divisor(n - 1) xor q_divident(n - 1)) = '1' then
            q_quotient <= (not q) + '1';
        else
            q_quotient <= q;
        end if;
    end process;

end Behavioral;
